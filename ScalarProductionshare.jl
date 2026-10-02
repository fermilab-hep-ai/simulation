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
using Interpolations



function ProductionProb(scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)
    Mixing = (lambda*Mstar*vevtwo)/(sqrt(numberofscalars)*m_h^2)
    sigma_h = 21.39 * 10^(-12)
    C = 2.25*3.34754 * 10^(-7)
    Gamma_bb = (3* m_h * m_b^2 *1.166*10^(-5)) / (4*pi * sqrt(2))
    expectedeventsvec = Vector{Float64}(undef, 0)

    x = [5.0456, 5.3263, 5.5929, 5.8316, 6.1263, 6.3790, 6.6456, 6.9123,
    7.1789, 7.4456, 7.7263, 8.0070, 8.3579, 8.6667, 9.0316, 9.3965,
    9.7053, 10.0702, 10.4351, 10.7860, 11.1228, 11.4596, 11.7544, 12.0632,
     12.3719, 12.7228, 13.0175, 13.3544, 13.6772, 14.0, 14.3368, 14.6456, 14.9263]

    y = 2.25*[6.6593, 6.4374, 6.2155, 6.0048, 5.7940, 5.5610, 5.3724, 5.1727,
     4.9509, 4.7512, 4.5626, 4.3851, 4.1965, 4.0856, 3.9857, 3.9525,
     4.1189, 4.1854, 4.1521, 4.0523, 3.9192, 3.7750, 3.6197, 3.4643,
     3.2979, 3.1204, 2.9762, 2.7987, 2.6434, 2.4992, 2.3661, 2.2330, 2.1331] 

    y_fit = y

    itp = extrapolate(interpolate((x,), y_fit, Gridded(Linear())), Line())

# -----------------------
# Evaluate for plotting
# -----------------------
   x_full = range(0.001, stop=25.0, length=500)   # extend below and above original range
   y_full = itp.(x_full)

    for i in 1:length(scalarmasses)
        local summedbrara =0
        
        for j in 1:length(scalarmasses)
            if m_h > (scalarmasses[i] + scalarmasses[j])
            Gamma_scalar = 2* (lambda^2 * vevtwo^2)* sqrt((m_h^2-(scalarmasses[i] + scalarmasses[j])^2)*(m_h^2 - (scalarmasses[i] - scalarmasses[j])^2)) /(numberofscalars^2 *4*pi*m_h^3)
            brara = Gamma_scalar/(Gamma_bb*1.89)
            summedbrara += brara
            else summedbrara += 0
            end
        end
        local sigma_s =0
        if scalarmasses[i] > 18.1
          sigma_s = C/((scalarmasses[i])^2)
        else
          sigma_s = (itp(scalarmasses[i]) * 10^(-9))
        end

      local bmesondecay =0
      if scalarmasses[i] < 4.7
        m_bmeson = 5.27934
        
        pms = (sqrt((m_bmeson^2 - (scalarmasses[i]+0.493)^2)*(m_bmeson^2 - (scalarmasses[i]-0.493)^2)))/(2*m_bmeson)
        
        F = (0.33)/(1-((scalarmasses[i])^2/(38)))
        bmesondecay = Mixing^2 * 0.5 * 2* pms *F / m_bmeson
      else
        bmesondecay = 0
      end




        summedbrarafinal =  sigma_h*summedbrara + sigma_s*(Mixing^2) + 10^(-3)*bmesondecay
        push!(expectedeventsvec, summedbrarafinal)
    end
    probvec = normalize(expectedeventsvec, 1)
    return probvec
end

function Crosssections(scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)
    Mixing = (lambda*Mstar*vevtwo)/(sqrt(numberofscalars)*m_h^2)
    sigma_h = 48.51 * 10^(-12)
    C = 2.25*3.34754 * 10^(-7)
    Gamma_bb = (3* m_h * m_b^2*1.166*10^(-5)) / (4*pi * sqrt(2))
    expectedeventsvec = Vector{Float64}(undef, 0)


    x = [5.0456, 5.3263, 5.5929, 5.8316, 6.1263, 6.3790, 6.6456, 6.9123,
    7.1789, 7.4456, 7.7263, 8.0070, 8.3579, 8.6667, 9.0316, 9.3965,
    9.7053, 10.0702, 10.4351, 10.7860, 11.1228, 11.4596, 11.7544, 12.0632,
     12.3719, 12.7228, 13.0175, 13.3544, 13.6772, 14.0, 14.3368, 14.6456, 14.9263]

    y = 2.25*[6.6593, 6.4374, 6.2155, 6.0048, 5.7940, 5.5610, 5.3724, 5.1727,
     4.9509, 4.7512, 4.5626, 4.3851, 4.1965, 4.0856, 3.9857, 3.9525,
     4.1189, 4.1854, 4.1521, 4.0523, 3.9192, 3.7750, 3.6197, 3.4643,
     3.2979, 3.1204, 2.9762, 2.7987, 2.6434, 2.4992, 2.3661, 2.2330, 2.1331] 

    y_fit = y

    itp = extrapolate(interpolate((x,), y_fit, Gridded(Linear())), Line())

# -----------------------
# Evaluate for plotting
# -----------------------
   x_full = range(0.001, stop=25.0, length=500)   # extend below and above original range
   y_full = itp.(x_full)






    
    for i in 1:length(scalarmasses)
        
        local summedbrara =0
      #  println(summedbrara)
        for j in 1:length(scalarmasses)
            if m_h > (scalarmasses[i] + scalarmasses[j])
            Gamma_scalar = 2* (lambda^2 * vevtwo^2)* sqrt((m_h^2-(scalarmasses[i] + scalarmasses[j])^2)*(m_h^2 - (scalarmasses[i] - scalarmasses[j])^2)) /(numberofscalars^2 * 4*pi*m_h^3)
            brara = Gamma_scalar/(Gamma_bb*1.89)
            
            summedbrara += brara
            else summedbrara += 0
            end
        end
       # println(summedbrara)
       local sigma_s =0
       if scalarmasses[i] > 18.1
        sigma_s = C/((scalarmasses[i])^2)
       else
        sigma_s = (itp(scalarmasses[i]) * 10^(-9))
       end
      #  println(sigma_s)
      local bmesondecay =0
      if scalarmasses[i] < 4.7
        m_bmeson = 5.27934
        pms = (sqrt((m_bmeson^2 - (scalarmasses[i]+0.493)^2)*(m_bmeson^2 - (scalarmasses[i]-0.493)^2)))/(2*m_bmeson)
        F = (0.33)/(1-((scalarmasses[i])^2/(38)))
        bmesondecay = Mixing^2 * 0.5 * 2* pms *F / m_bmeson
      else
        bmesondecay = 0
      end
      
        summedbrarafinal = sigma_h*summedbrara + sigma_s*(Mixing^2) + 10^(-3)*bmesondecay
        push!(expectedeventsvec, summedbrarafinal)
    end

    return expectedeventsvec
end



function ProductionProbjustHiggsDecaytwomasses(scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)
  Mixing = (lambda*Mstar*vevtwo)/(sqrt(numberofscalars)*m_h^2)
  sigma_h = 48.51 * 10^(-12)
  C = 2.25*3.34754 * 10^(-7)
  Gamma_bb = (3* m_h * m_b^2 *1.166*10^(-5)) / (4*pi * sqrt(2))
  expectedeventsvec = Vector{Float64}(undef, 0)
  BRHscalarsclar= Vector{Float64}(undef, 0)
  mass1 = Vector{Float64}(undef, 0)
  mass2 = Vector{Float64}(undef, 0)


  for i in 1:length(scalarmasses)
      local brara =0
      
      for j in 1:length(scalarmasses)
          if m_h > (scalarmasses[i] + scalarmasses[j])
          Gamma_scalar = 2* (lambda^2 * vevtwo^2)* sqrt((m_h^2-(scalarmasses[i] + scalarmasses[j])^2)*(m_h^2 - (scalarmasses[i] - scalarmasses[j])^2)) /(numberofscalars^2 *4*pi*m_h^3)
          brara = Gamma_scalar/(Gamma_bb*1.89)
          
          else brara = 0
          end
          push!(expectedeventsvec, brara)
          push!(mass1, scalarmasses[i])
          push!(mass2, scalarmasses[j])
          push!(BRHscalarsclar, brara)
      end
      
  end
  probvec = normalize(expectedeventsvec, 1)
  return probvec, mass1, mass2, sum(BRHscalarsclar)
end




function ProductionProbjustHiggsDecay(scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)
  Mixing = (lambda*Mstar*vevtwo)/(sqrt(numberofscalars)*m_h^2)
  sigma_h = 48.51 * 10^(-12)
  C = 2.25*3.34754 * 10^(-7)
  Gamma_bb = (3* m_h * m_b^2 *1.166*10^(-5)) / (4*pi * sqrt(2))
  expectedeventsvec = Vector{Float64}(undef, 0)
  for i in 1:length(scalarmasses)
      local summedbrara =0
      
      for j in 1:length(scalarmasses)
          if m_h > (scalarmasses[i] + scalarmasses[j])
          Gamma_scalar = 2* (lambda^2 * vevtwo^2)* sqrt((m_h^2-(scalarmasses[i] + scalarmasses[j])^2)*(m_h^2 - (scalarmasses[i] - scalarmasses[j])^2)) /(numberofscalars^2 *4*pi*m_h^3)
          brara = Gamma_scalar/(Gamma_bb*1.89)
          summedbrara += brara
          else summedbrara += 0
          end
      end
      
      sigma_s = C/((scalarmasses[i])^2)

    local bmesondecay =0
    if scalarmasses[i] < 4.7
      m_bmeson = 5.27934
      
      pms = (sqrt((m_bmeson^2 - (scalarmasses[i]+0.493)^2)*(m_bmeson^2 - (scalarmasses[i]-0.493)^2)))/(2*m_bmeson)
      
      F = (0.33)/(1-((scalarmasses[i])^2/(38)))
      bmesondecay = Mixing^2 * 0.5 * 2* pms *F / m_bmeson
    else
      bmesondecay = 0
    end




      summedbrarafinal =  sigma_h*summedbrara 
      push!(expectedeventsvec, summedbrarafinal)
  end
  probvec = normalize(expectedeventsvec, 1)
  return probvec
end





function CrosssectionsjustHiggsDecay(scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)
  Mixing = (lambda*Mstar*vevtwo)/(sqrt(numberofscalars)*m_h^2)
  sigma_h = 48.51 * 10^(-12)
    C = 2.25*3.34754 * 10^(-7)
  Gamma_bb = (3* m_h * m_b^2*1.166*10^(-5)) / (4*pi * sqrt(2))
  expectedeventsvec = Vector{Float64}(undef, 0)
  for i in 1:length(scalarmasses)
      
      local summedbrara =0
    
      for j in 1:length(scalarmasses)
          if m_h > (scalarmasses[i] + scalarmasses[j])
          Gamma_scalar = 2* (lambda^2 * vevtwo^2)* sqrt((m_h^2-(scalarmasses[i] + scalarmasses[j])^2)*(m_h^2 - (scalarmasses[i] - scalarmasses[j])^2)) /(numberofscalars^2 * 4*pi*m_h^3)
          brara = Gamma_scalar/(Gamma_bb*1.89)
          
          summedbrara += brara
          else summedbrara += 0
          end
      end
     
      sigma_s = C/((scalarmasses[i])^2)
    
    local bmesondecay =0
    if scalarmasses[i] < 4.7
      m_bmeson = 5.27934
      pms = (sqrt((m_bmeson^2 - (scalarmasses[i]+0.493)^2)*(m_bmeson^2 - (scalarmasses[i]-0.493)^2)))/(2*m_bmeson)
      F = (0.33)/(1-((scalarmasses[i])^2/(38)))
      bmesondecay = Mixing^2 * 0.5 * 2* pms *F / m_bmeson
    else
      bmesondecay = 0
    end

      summedbrarafinal = sigma_h*summedbrara
      push!(expectedeventsvec, summedbrarafinal)
  end

  return expectedeventsvec
end
