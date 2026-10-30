# Tier 3 reference: statistical backstop at the shipped benchmark (N = 200),
# with the ORIGINAL unmodified DecayChaingeneralquartic and Julia's own RNG.
#
#   JULIA_DEPOT_PATH=<depot> julia landscape/julia_ref/dump_tier3.jl <outdir> <nevents>
#
# Writes two files.  tier3_events.csv has one line per event (root mass,
# multiplicity, flavour counts) and is kept out of version control; the
# committed fixture is tier3_summary.csv, the multiplicity histogram and
# flavour totals, which is all the Python comparison consumes.
#
# The spectrum is drawn ONCE and written out (instructions section 7g: default
# to a fixed realisation per sample rather than the driver's per-event
# redraw, which marginalises over landscape realisations).

using Random, LinearAlgebra, Statistics, Distributions, StatsBase
using DelimitedFiles
using Interpolations   # required by ProductionProb / Crosssections

outdir = length(ARGS) >= 1 ? ARGS[1] : "landscape/julia_ref/fixtures"
nevents = length(ARGS) >= 2 ? parse(Int, ARGS[2]) : 100000
mkpath(outdir)
repo = dirname(dirname(@__DIR__))

function include_stripped(path)
    src = read(path, String); kept = String[]
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
include_stripped(joinpath(repo, "ScalarProductionshare.jl"))

N = 200; lambdaa = 0.0001; lambdaaprime = 0.0001
Mstarr = 10000.0; vev_2 = 0.9*vev
low = 10/sqrt(N); up = 10.0

# fixed spectrum, seed recorded
SPECTRUM_SEED = 424242
Random.seed!(SPECTRUM_SEED)
spectrum = rand(Uniform(low, up), N)
writedlm(joinpath(outdir, "tier3_spectrum.csv"), spectrum, ',')

probabs = ProductionProb(spectrum, Mstarr, lambdaaprime, N, vev_2, lambdaa)
writedlm(joinpath(outdir, "tier3_prodprob.csv"), probabs, ',')

xs = Crosssections(spectrum, Mstarr, lambdaaprime, N, vev_2, lambdaa)
open(joinpath(outdir, "tier3_xsec.csv"), "w") do io
    println(io, "key,value")
    println(io, "total_crosssection_barn,", repr(sum(xs)))
    println(io, "spectrum_seed,", SPECTRUM_SEED)
    println(io, "julia_version,", VERSION)
end

Random.seed!(555000111)
disti = Categorical(probabs)

FLAVOURS = ["b","tau","c","s","mu","pi2","pi1","e","gamma","gluon","W","Z","t","scalar"]
multhist = Dict{Int,Int}()
flavtot = zeros(Int, 14)
naccepted = Ref(0)   # the write below is inside a do-block closure

open(joinpath(outdir, "tier3_events.csv"), "w") do io
    println(io, "root,multiplicity,", join(FLAVOURS, ","))
    for ev in 1:nevents
        root = spectrum[rand(disti)]
        prods = DecayChaingeneralquartic(root, spectrum, Mstarr, lambdaaprime, N, vev_2, lambdaa)
        if prods === nothing
            continue
        end
        c = zeros(Int, 14)
        for p in prods
            if p == m_b; c[1]+=1
            elseif p == m_tau; c[2]+=1
            elseif p == m_charm; c[3]+=1
            elseif p == m_strange; c[4]+=1
            elseif p == m_muon; c[5]+=1
            elseif p == m_u; c[6]+=1
            elseif p == m_d; c[7]+=1
            elseif p == m_electron; c[8]+=1
            elseif p == 1; c[9]+=1
            elseif p == 2; c[10]+=1
            elseif p == m_W; c[11]+=1
            elseif p == m_Z; c[12]+=1
            elseif p == m_top; c[13]+=1
            else; c[14]+=1
            end
        end
        naccepted[] += 1
        multhist[length(prods)] = get(multhist, length(prods), 0) + 1
        flavtot .= flavtot .+ c
        println(io, join(vcat([repr(root), string(length(prods))], map(string, c)), ","))
    end
end

# Committed fixture: the per-event file above is ~5 MB at 10^5 events and is
# gitignored.  Everything the Tier 3 comparison actually uses -- the
# multiplicity histogram and the flavour totals -- is a sufficient statistic
# for both the KS test (the ECDF is fully determined by the histogram) and the
# flavour fractions, so only this summary is version controlled.
open(joinpath(outdir, "tier3_summary.csv"), "w") do io
    println(io, "kind,key,value")
    println(io, "meta,nevents_requested,", nevents)
    println(io, "meta,nevents_accepted,", naccepted[])
    println(io, "meta,julia_version,", VERSION)
    for k in sort(collect(keys(multhist)))
        println(io, "mult,", k, ",", multhist[k])
    end
    for (i, f) in enumerate(FLAVOURS)
        println(io, "flav,", f, ",", flavtot[i])
    end
end
println("Tier 3 reference written: ", naccepted[], " accepted of ", nevents,
        " events at N=", N)
