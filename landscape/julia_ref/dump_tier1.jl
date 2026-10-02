# Tier 1 reference dump: evaluate every deterministic width and the full
# BranchingRatiosgeneralquartic output on a threshold-spanning grid and write
# the results to CSV for the Python port to be compared against.
#
# Run from the repository root:
#   JULIA_DEPOT_PATH=<depot> julia landscape/julia_ref/dump_tier1.jl <outdir>
#
# The original scalarattributesshare.jl pulls in BAT, Neurthino, HDF5,
# ValueShapes, DensityInterface, QuadGK and TypedTables, none of which it uses.
# Rather than install them we strip the `using` block and evaluate the rest of
# the file, so this script depends only on Distributions/StatsBase.

using Random, LinearAlgebra, Statistics, Distributions, StatsBase
using DelimitedFiles
using Interpolations

outdir = length(ARGS) >= 1 ? ARGS[1] : "landscape/julia_ref/fixtures"
mkpath(outdir)

repo = dirname(dirname(@__DIR__))

function include_stripped(path)
    src = read(path, String)
    lines = split(src, '\n')
    kept = String[]
    for l in lines
        s = strip(l)
        # drop the dead imports and the plotting stack
        if startswith(s, "using ") || startswith(s, "Pkg.add") ||
           startswith(s, "using Pkg") || startswith(s, "include(")
            push!(kept, "")
        else
            push!(kept, l)
        end
    end
    Base.include_string(Main, join(kept, '\n'), path)
end

# --- globals, copied verbatim from ScalarScanningshare.jl -------------------
m_h = 125.11
m_b = 4.18
m_tau = 1.78
m_charm = 1.28
m_strange = 0.096
m_muon = 0.10566
m_u = 0.134
m_d = 0.139
m_electron = 0.000511
m_W = 80.37
m_Z = 91.19
m_top = 172.57
vev = 246

y_b = m_b/vev
y_c = m_charm/vev
y_tau = m_tau/vev
y_s = m_strange/vev
y_muon = m_muon/vev
y_u = m_u/vev
y_d = m_d/vev
y_e = m_electron/vev
y_t = m_top/vev

include_stripped(joinpath(repo, "scalarattributesshare.jl"))
include_stripped(joinpath(repo, "ScalarProductionshare.jl"))

# --- benchmark parameters --------------------------------------------------
N = 200
lambdaa = 0.0001
lambdaaprime = 0.0001
Mstarr = 10000.0
vev_2 = 0.9*vev

# --- threshold-spanning mass grid -----------------------------------------
# Deliberately straddles: 2m_e, 2m_pi0, 2m_pipm, 2m_mu, 2m_s, the 0.4 GeV
# gluon turn-on, the 1.0 GeV pion form-factor breakpoint, 2m_c, 2m_tau, 2m_b,
# 2m_W, 2m_Z and 2m_top.
edges = [2*m_electron, 2*0.134, 2*0.139, 2*m_muon, 2*m_strange, 0.4, 1.0,
         2*m_charm, 2*m_tau, 2*m_b, 2*m_W, 2*m_Z, 2*m_top]
grid = Float64[]
for e in edges
    for f in (0.5, 0.9, 0.999, 1.001, 1.1, 2.0)
        push!(grid, e*f)
    end
end
append!(grid, [1e-4, 1e-3, 0.05, 0.2, 0.707, 2.0, 5.0, 7.5, 10.0, 15.0,
               18.0, 18.1, 18.2, 25.0, 50.0, 100.0, 200.0, 400.0])
sort!(grid)
unique!(grid)
grid = filter(x -> x > 0, grid)

# --- 1. single-argument widths --------------------------------------------
open(joinpath(outdir, "widths.csv"), "w") do io
    println(io, "m,photons,pions,gluons,WW,ZZ,bb,cc,tautau,ss,mumu,ee,tt")
    for m in grid
        wgam = DecaytoPhotons(m, lambdaa, Mstarr, vev_2, N)
        wpi  = DecaytoPions(m, lambdaa, Mstarr, vev_2, N)
        wglu = DecaytoGluons(m, lambdaa, Mstarr, vev_2, N)
        wWW  = m > 2*m_W ? DecayWidthScalartoSMWboson(m, m_W, y_e, 1, lambdaa, Mstarr, vev_2, N) : 0.0
        wZZ  = m > 2*m_Z ? DecayWidthScalartoSMZboson(m, m_W, y_e, 1, lambdaa, Mstarr, vev_2, N) : 0.0
        wbb  = m > 2*m_b ? DecayWidthScalartoSM(m, m_b, y_b, 3, lambdaa, Mstarr, vev_2, N) : 0.0
        wcc  = m > 2*m_charm ? DecayWidthScalartoSM(m, m_charm, y_c, 3, lambdaa, Mstarr, vev_2, N) : 0.0
        wtt_ = m > 2*m_tau ? DecayWidthScalartoSM(m, m_tau, y_tau, 1, lambdaa, Mstarr, vev_2, N) : 0.0
        wss  = m > 2*m_strange ? DecayWidthScalartoSM(m, m_strange, y_s, 3, lambdaa, Mstarr, vev_2, N) : 0.0
        wmu  = m > 2*m_muon ? DecayWidthScalartoSM(m, m_muon, y_muon, 1, lambdaa, Mstarr, vev_2, N) : 0.0
        wee  = m > 2*m_electron ? DecayWidthScalartoSM(m, m_electron, y_e, 1, lambdaa, Mstarr, vev_2, N) : 0.0
        wtop = m > 2*m_top ? DecayWidthScalartoSM(m, m_top, y_t, 3, lambdaa, Mstarr, vev_2, N) : 0.0
        println(io, join(map(x -> repr(x), [m, wgam, wpi, wglu, wWW, wZZ, wbb, wcc, wtt_, wss, wmu, wee, wtop]), ","))
    end
end

# --- 2. hidden-sector pair width ------------------------------------------
open(joinpath(outdir, "pairwidth.csv"), "w") do io
    println(io, "m,m1,m2,width")
    for m in [0.8, 1.5, 3.0, 7.0, 10.0, 25.0]
        for m1 in [0.05, 0.3, 0.707, 1.0, 3.0, 5.0]
            for m2 in [0.05, 0.3, 0.707, 1.0, 3.0, 5.0]
                w = DecayWidthScalartoScalargeneralquartic(m, m1, m2, Mstarr, lambdaaprime, N)
                println(io, join(map(x -> repr(x), [m, m1, m2, w]), ","))
            end
        end
    end
end

# --- 3. full BranchingRatiosgeneralquartic output, order preserved ---------
Random.seed!(20240607)
spectrum = sort(rand(Uniform(10/sqrt(N), 10.0), 12))
writedlm(joinpath(outdir, "spectrum.csv"), spectrum, ',')

open(joinpath(outdir, "branching.csv"), "w") do io
    println(io, "m,index,BR,mass1,mass2")
    for m in [0.5, 0.9, 1.2, 2.5, 5.0, 9.5, 12.0, 30.0, 200.0, 400.0]
        BR, m1, m2 = BranchingRatiosgeneralquartic(m, spectrum, Mstarr, lambdaaprime, N, vev_2, lambdaa)
        for k in 1:length(BR)
            println(io, join([repr(m), string(k), repr(BR[k]), repr(m1[k]), repr(m2[k])], ","))
        end
    end
end

# --- 4. production ---------------------------------------------------------
open(joinpath(outdir, "production.csv"), "w") do io
    println(io, "index,prodprob,crosssection,higgsonly")
    pp = ProductionProb(spectrum, Mstarr, lambdaaprime, N, vev_2, lambdaa)
    xs = Crosssections(spectrum, Mstarr, lambdaaprime, N, vev_2, lambdaa)
    ho = CrosssectionsjustHiggsDecay(spectrum, Mstarr, lambdaaprime, N, vev_2, lambdaa)
    for k in 1:length(pp)
        println(io, join([string(k), repr(pp[k]), repr(xs[k]), repr(ho[k])], ","))
    end
end

open(joinpath(outdir, "higgspairs.csv"), "w") do io
    println(io, "index,prob,mass1,mass2")
    pv, hm1, hm2, brsum = ProductionProbjustHiggsDecaytwomasses(spectrum, Mstarr, lambdaaprime, N, vev_2, lambdaa)
    for k in 1:length(pv)
        println(io, join([string(k), repr(pv[k]), repr(hm1[k]), repr(hm2[k])], ","))
    end
    println(io, join(["BRSUM", repr(brsum), "0.0", "0.0"], ","))
end

println("Tier 1 reference written to ", outdir)
println("julia ", VERSION)
