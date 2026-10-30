# Tier 2 reference dump: run DecayChaingeneralquartic with the randomness
# replaced by a pre-generated stream of uniforms read from file, so the Python
# port can be driven by the identical stream and the resulting Products lists
# compared element by element.
#
#   JULIA_DEPOT_PATH=<depot> julia landscape/julia_ref/dump_tier2.jl <outdir> <nchains>
#
# The cascade body below is copied verbatim from scalarattributesshare.jl with
# exactly two changes, both marked INJECTED:
#   * rand(Categorical(BR))            -> icdf(BR, next_uniform())
#   * rand(Categorical([pph, pgl]))    -> icdf([pph, pgl], next_uniform())
# Everything else -- the loop structure, the ordering, the thresholds, the
# photon/gluon split -- is untouched.

using Random, LinearAlgebra, Statistics, Distributions, StatsBase
using DelimitedFiles

outdir = length(ARGS) >= 1 ? ARGS[1] : "landscape/julia_ref/fixtures"
nchains = length(ARGS) >= 2 ? parse(Int, ARGS[2]) : 10000
mkpath(outdir)
repo = dirname(dirname(@__DIR__))

function include_stripped(path)
    src = read(path, String)
    kept = String[]
    for l in split(src, '\n')
        s = strip(l)
        if startswith(s, "using ") || startswith(s, "Pkg.add") ||
           startswith(s, "using Pkg") || startswith(s, "include(")
            push!(kept, "")
        else
            push!(kept, l)
        end
    end
    Base.include_string(Main, join(kept, '\n'), path)
end

m_h = 125.11; m_b = 4.18; m_tau = 1.78; m_charm = 1.28; m_strange = 0.096
m_muon = 0.10566; m_u = 0.134; m_d = 0.139; m_electron = 0.000511
m_W = 80.37; m_Z = 91.19; m_top = 172.57; vev = 246
y_b = m_b/vev; y_c = m_charm/vev; y_tau = m_tau/vev; y_s = m_strange/vev
y_muon = m_muon/vev; y_u = m_u/vev; y_d = m_d/vev; y_e = m_electron/vev
y_t = m_top/vev

include_stripped(joinpath(repo, "scalarattributesshare.jl"))

N = 200; lambdaa = 0.0001; lambdaaprime = 0.0001
Mstarr = 10000.0; vev_2 = 0.9*vev

# ---- injected uniform stream ---------------------------------------------
const STREAM = Ref{Vector{Float64}}(Float64[])
const POS = Ref{Int}(0)
function next_uniform()
    POS[] += 1
    if POS[] > length(STREAM[])
        error("uniform stream exhausted after $(POS[]-1) draws")
    end
    return STREAM[][POS[]]
end
# inverse CDF matching Julia's rand(Categorical(p)), verified separately
function icdf(p, u)
    cp = 0.0
    for i in 1:length(p)
        cp += p[i]
        if u <= cp
            return i
        end
    end
    return length(p)
end

# ---- cascade with INJECTED randomness ------------------------------------
function DecayChaingeneralquartic_injected(massscalar, scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)
    if 2*minimum(scalarmasses) > massscalar && 2*m_electron > massscalar
        return nothing
    else
        massofedukts = Vector{Float64}(undef, 0)
        Products = Vector{Float64}(undef, 0)
        push!(massofedukts, massscalar)

        while length(massofedukts)>0 && (maximum(massofedukts) > 2*minimum(scalarmasses) || maximum(massofedukts) > 2*m_electron)
            massesofproducts = Vector{Float64}(undef, 0)
            for k in 1:length(massofedukts)
                BR, mass1, mass2 = BranchingRatiosgeneralquartic(massofedukts[k], scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)
                index = icdf(BR, next_uniform())            # INJECTED
                massproduct = mass1[index]
                massproduct2 = mass2[index]
                if massproduct == m_b || massproduct == m_charm || massproduct == m_tau || massproduct == m_strange || massproduct == m_muon || massproduct == m_u || massproduct == m_d || massproduct == m_electron || massproduct == m_W || massproduct == m_Z || massproduct == m_top
                    push!(Products, massproduct)
                    push!(Products, massproduct2)
                elseif massproduct == massofedukts[k]/2
                    l = length(BR)
                    if BR[l-1] > BR[l]
                        pphoton = 1 - BR[l]/BR[l-1]
                        pgluon = BR[l]/BR[l-1]
                    else
                        pphoton = BR[l-1]/BR[l]
                        pgluon = 1 - BR[l-1]/BR[l]
                    end
                    sample = icdf([pphoton, pgluon], next_uniform())   # INJECTED
                    push!(Products, sample)
                    push!(Products, sample)
                else
                    push!(massesofproducts, massproduct)
                    push!(massesofproducts, massproduct2)
                end
            end
            massofedukts = massesofproducts
        end
        append!(Products, massofedukts)
        return Products
    end
end

# ---- fixed spectrum and stream -------------------------------------------
Random.seed!(20240607)
spectrum = sort(rand(Uniform(10/sqrt(N), 10.0), 12))
writedlm(joinpath(outdir, "tier2_spectrum.csv"), spectrum, ',')

Random.seed!(987654321)
# generous budget; only the consumed prefix is written out (after the run), so
# the fixture stays small enough to commit.  A prefix of the pool is exactly
# what a shorter pool would have been, so this is not an approximation.
stream = rand(200 * nchains)
STREAM[] = stream

# roots cycle through the spectrum so every mass seeds some chains
open(joinpath(outdir, "tier2_products.csv"), "w") do io
    println(io, "chain,root,products")
    for c in 1:nchains
        root = spectrum[mod1(c, length(spectrum))]
        prods = DecayChaingeneralquartic_injected(root, spectrum, Mstarr, lambdaaprime, N, vev_2, lambdaa)
        s = prods === nothing ? "STABLE" : join(map(x -> repr(x), prods), " ")
        println(io, string(c), ",", repr(root), ",", s)
    end
end

writedlm(joinpath(outdir, "tier2_uniforms.csv"), stream[1:POS[]], ',')

open(joinpath(outdir, "tier2_meta.csv"), "w") do io
    println(io, "key,value")
    println(io, "nchains,", nchains)
    println(io, "uniforms_consumed,", POS[])
    println(io, "julia_version,", VERSION)
end
println("Tier 2 reference written: ", nchains, " chains, ", POS[], " uniforms consumed")
