# Set this at the very beginning of your script, or in the REPL
#ENV["PLOTS_HOST_DEFAULT"] = "browser"

using Pkg


Pkg.add("WebIO")
using WebIO
using StatsBase
using Random, LinearAlgebra, Statistics, Distributions
using Plots
using FileIO
using BAT, IntervalSets
using DelimitedFiles
using DensityInterface
using ValueShapes
using HDF5
using Neurthino
using Base.Threads
using QuadGK
using Tables
using TypedTables
using Statistics
using Distributions
using PlotlyJS
using LaTeXStrings

include("scalarattributesshare.jl")
include("ScalarProductionshare.jl")

default(fontfamily = "Computer Modern")

#masses in GeV
m_h = 125.11
m_b =   4.18
m_tau = 1.78
m_charm = 1.28
m_strange = 0.096
m_muon = 0.10566
m_u = 0.134#0.0022
m_d = 0.139#0.0047
m_electron = 0.000511
m_W = 80.37
m_Z = 91.19
m_top = 172.57
vev= 246


#couplings
y_b = m_b/vev
y_c = m_charm/vev
y_tau = m_tau/vev
y_s = m_strange/vev
y_muon = m_muon/vev
y_u = m_u/vev 
y_d = m_d/vev 
y_e = m_electron/vev
y_t = m_top/vev
#BSMparameters
N = 200
lambdaa=0.0001
lambdaaprime= 0.0001
Mstarr = 10000.0
vev_2 = 0.9*vev
sigma = 10
mphi = sqrt(2* lambdaa)* vev
printmphi= round(mphi)
low =   10/sqrt(N) # 0.1* mphi 
up =10 # mphi +10
printlow=round(low)
printup = round(up)
luminosity = 3000 * 10^(15)

println(lambdaaprime/((vev_2*Mstarr*lambdaa)/(N*m_h^2)))
println("low =", low)
println("up=", up)
factor = 1


    lowermass = Vector{Float64}(undef, 0)
    meanlength = Vector{Float64}(undef, 0)



massdistribution = Uniform(low,up)

massdis = rand(massdistribution, N)

AnzahlSMVector = Vector{Float64}(undef, 0)
FlavorSMVector = []
ratiovector = Vector{Float64}(undef, 0)

@threads for i in 1:10000
    massdistsample2 = rand(massdistribution, N)

    probabs = ProductionProb(massdistsample2, Mstarr, factor*lambdaaprime, N, vev_2, lambdaa)

    disti = Categorical(probabs)
    chos_value = massdistsample2[rand(disti)]

     productvector = DecayChaingeneralquartic(chos_value,  massdistsample2, Mstarr, factor*lambdaaprime, N, vev_2, lambdaa)
 
    ratiovector2 = Vector{Float64}(undef, 0)
    sorted_massdistsample2 = sort(massdistsample2, rev=true)
    for k in 1:length(massdistsample2)
       r = BranchingRatiosgeneralquartic2(sorted_massdistsample2[k],  massdis, Mstarr, factor*lambdaaprime, N, vev_2, lambdaa)
   
       push!(ratiovector2,r[1])
    end
     
    closest_index = argmin(abs.(ratiovector2 .- 1))
 

    push!(ratiovector, closest_index)
    push!(AnzahlSMVector, length(productvector))
    push!(FlavorSMVector, productvector)
end

meanindex = mean(ratiovector)

equalitypoint = meanindex/N

expectedevents =sum(luminosity*Crosssections(massdis, Mstarr, factor*lambdaaprime, N, vev_2, lambdaa))



println("expectedevents =", expectedevents)

Higgsparticles = 40 * 10^(15) *21.39 * 10^(-12)

RangeofCounts = collect(1:Int(maximum(AnzahlSMVector)))
flav2 = []
flavbars = [zeros(Int(maximum(AnzahlSMVector))),zeros(Int(maximum(AnzahlSMVector))),zeros(Int(maximum(AnzahlSMVector))),zeros(Int(maximum(AnzahlSMVector))),zeros(Int(maximum(AnzahlSMVector))),zeros(Int(maximum(AnzahlSMVector))),zeros(Int(maximum(AnzahlSMVector))),zeros(Int(maximum(AnzahlSMVector))),zeros(Int(maximum(AnzahlSMVector))),zeros(Int(maximum(AnzahlSMVector))),zeros(Int(maximum(AnzahlSMVector))),zeros(Int(maximum(AnzahlSMVector))),zeros(Int(maximum(AnzahlSMVector)))]
for k in 1:size(FlavorSMVector)[1]
    value_counts = countmap(FlavorSMVector[k])
    for key in keys(value_counts)
       
        if key == m_b
            flavbars[1][length(FlavorSMVector[k])] += value_counts[key]
        elseif key ==m_tau
            flavbars[2][length(FlavorSMVector[k])] += value_counts[key]
        elseif key == m_charm
            flavbars[3][length(FlavorSMVector[k])] += value_counts[key]
        elseif key == m_strange
            flavbars[4][length(FlavorSMVector[k])] += value_counts[key]
        elseif key == m_muon
            flavbars[5][length(FlavorSMVector[k])] += value_counts[key]
        elseif key == m_u
            flavbars[6][length(FlavorSMVector[k])] += value_counts[key]
        elseif key == m_d
            flavbars[7][length(FlavorSMVector[k])] += value_counts[key]
        elseif key == m_electron
            flavbars[8][length(FlavorSMVector[k])] += value_counts[key]
        elseif key == 1
            flavbars[9][length(FlavorSMVector[k])] += value_counts[key]
        elseif key == 2
            flavbars[10][length(FlavorSMVector[k])] += value_counts[key]
        elseif key == m_W
            flavbars[11][length(FlavorSMVector[k])] += value_counts[key]
        elseif key == m_Z
            flavbars[12][length(FlavorSMVector[k])] += value_counts[key]
        elseif key == m_top
            flavbars[13][length(FlavorSMVector[k])] += value_counts[key]
        end
    end
end

for i in 1:length(flavbars)  # Loop over each vector
    for j in 1:length(flavbars[i])  # Loop over elements in the vector
        flavbars[i][j] /= (j * size(FlavorSMVector)[1])  # Divide element by its position
    end
end

colors = [
"#636EFA",  # blue
"#EF553B",  # red
"#00CC96",  # green
"#AB63FA",  # purple
"#FFA15A",  # orange
"#19D3F3",  # light blue
"#FF6692",  # pink
"#B6E880",  # light green
"#FF97FF",  # magenta
"#FECB52",   # yellow
"#1f77b4",  # 11. W⁺W⁻ → now deeper blue (so it stays blue but unique)
"#4b4b8f",  # 12. ZZ   → new muted indigo-blue
"#008080"   # 13. t t̄ → teal (distinct from green bb̄)
]


plot_data = [
    PlotlyJS.bar(x=RangeofCounts, y=flavbars[1], name="b b̄", marker_color=colors[1]),
    PlotlyJS.bar(x=RangeofCounts, y=flavbars[2], name="τ⁺τ⁻", marker_color=colors[2]),
    PlotlyJS.bar(x=RangeofCounts, y=flavbars[3], name="c c̄", marker_color=colors[3]),
    PlotlyJS.bar(x=RangeofCounts, y=flavbars[4], name="s s̄", marker_color=colors[4]),
    PlotlyJS.bar(x=RangeofCounts, y=flavbars[5], name="μ⁺μ⁻", marker_color=colors[5]),
    PlotlyJS.bar(x=RangeofCounts, y=flavbars[6], name="π⁺π⁻", marker_color=colors[6]),
    PlotlyJS.bar(x=RangeofCounts, y=flavbars[7], name="π⁰π⁰", marker_color=colors[7]),
    PlotlyJS.bar(x=RangeofCounts, y=flavbars[8], name="e⁺e⁻", marker_color=colors[8]),
    PlotlyJS.bar(x=RangeofCounts, y=flavbars[9], name="γγ", marker_color=colors[9]),
    PlotlyJS.bar(x=RangeofCounts, y=flavbars[10], name="gg", marker_color=colors[10]),
    PlotlyJS.bar(x=RangeofCounts, y=flavbars[11], name="W⁺W⁻", marker_color=colors[11]),
    PlotlyJS.bar(x=RangeofCounts, y=flavbars[12], name="ZZ", marker_color=colors[12]),
    PlotlyJS.bar(x=RangeofCounts, y=flavbars[13], name="t t̄", marker_color=colors[13])
]



function sum_y_at_max_x(data_json)
    data = data_json

    # Find the global maximum x value
    all_x_values = reduce(vcat, [item["x"] for item in data])
    max_x = maximum(all_x_values)

    # Sum y values corresponding to max_x
    y_sum = 0.0
    for item in data
        x_vals = item["x"]
        y_vals = item["y"]
        for (x, y) in zip(x_vals, y_vals)
            if x ≥ 8
                y_sum += y
            end
        end
    end

    println("Sum of all y values for x ≥ 8: $y_sum")
    return y_sum
end



highjetevents= expectedevents*sum_y_at_max_x(plot_data)
println(highjetevents)


muon_entry = filter(d -> d["name"] == "μ⁺μ⁻", plot_data)
println(muon_entry)
# Access the x and y values
if !isempty(muon_entry)
    x_vals = muon_entry[1]["x"]
    y_vals = muon_entry[1]["y"]
    println("Muon x values: ", x_vals)
    println("Muon y values: ", y_vals)
else
    println("No 'muon' entry found.")
end

plot_layout = Layout(
    xaxis = attr(
        title = "Final State Particles",
        showline = true,         # draw axis line
        linecolor = "black",     # color of axis line
        linewidth = 2,           # thickness of axis line
        mirror = false,           # draw line on both sides
        ticks = "outside",       # ticks outward
        tickcolor = "black",
        tickwidth = 2,
        ticklen = 6,
        showgrid = false         # turn off grid lines
    ),
    yaxis = attr(
        title = "Fraction of Events",
        showline = true,
        linecolor = "black",
        linewidth = 2,
        mirror = false,
        ticks = "outside",
        tickcolor = "black",
        tickwidth = 2,
        ticklen = 6,
        showgrid = false,         # optional: keep light grid
        gridcolor = "lightgray",
        gridwidth = 1
    ),
    width = 825,
    height = 375,
    plot_bgcolor = "white",       # white plotting area
    paper_bgcolor = "white",      # white outside area
    font = attr(
        family="Latin Modern Roman",
        size=16,
        color="black"
    ),
    barmode = "stack",
    bargap = 0,          # remove space between bar groups
    bargroupgap = 0,    # remove space between bars within a group
    grid = false,
    showlegend = true,
    legend = attr(
        x = 1.02,  # slightly closer to the plot
        y = 1.0,
        xanchor = "left",
        yanchor = "top",
        orientation = "v",  # vertical legend
        font = attr(size = 19),
    ),
    margin = attr(r = 120)  # more room
)



println(maximum(RangeofCounts))

println("!")


#save("/home/mettengruber/FinalCascadeN200ratio1scale110.pdf", fig)



weights_per_x = sum(flavbars, dims=1)

mean_events = sum(RangeofCounts .* weights_per_x[1][:])


println(mean_events)

fig= PlotlyJS.plot(plot_data, plot_layout)





