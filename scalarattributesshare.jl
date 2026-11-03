using Random, LinearAlgebra, Statistics, Distributions, StatsBase
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



function DecayWidthScalartoScalarwithoutVEVs(massscalar, massprodukt, Mstar, lambdaprime, numberofscalars)
   
   if rand() < 1.0
    Decaywidth = 1/(16*pi*massscalar)*sqrt(1-4*(massprodukt^2/(massscalar)^2))*Mstar^2 * lambdaprime^2 *(1/(numberofscalars^4))
    return Decaywidth
   else 
    Decaywidth = 0
    return Decaywidth
   end

end
function DecayWidthScalartoScalar(massscalar, massprodukt, Mstar, lambdaprime, numberofscalars)
    Decaywidth = 1/(16*pi*massscalar)*sqrt(1-4*(massprodukt^2/(massscalar)^2))*Mstar^2 * lambdaprime^2 *(1/(numberofscalars^4))
    return Decaywidth
end
function DecayWidthScalartoScalargeneralquartic(massscalar, massproduct1, massproduct2, Mstar, lambdaprime, numberofscalars)
    sumprod = massproduct1+ massproduct2
    if massscalar > sumprod
        
        Decaywidth = (1/(16*pi))*Mstar^2 * lambdaprime^2 *(24/(numberofscalars^2))*(sqrt((massscalar^2 -(massproduct1+massproduct2)^2)*(massscalar^2 -(massproduct1-massproduct2)^2)))/(massscalar^3)
        
    else
        Decaywidth = 0
    end
    return Decaywidth
end
function DecayWidthScalartoSM(massscalar, mfermion, fermioncoupling, colorfactor, lambda, Mstar, vevtwo, numberofscalars)
    Mixing = (lambda*Mstar*vevtwo)/(sqrt(numberofscalars)*m_h^2)
    Decaywidthfermions = 1/(8*pi)*Mixing^2 * fermioncoupling^2 *massscalar*(1-((4*mfermion^2)/(massscalar^2)))^(3/2) * colorfactor
    return Decaywidthfermions
end

function DecayWidthScalartoSMWboson(massscalar, mWboson, fermioncoupling, colorfactor, lambda, Mstar, vevtwo, numberofscalars)
    Mixing = (lambda*Mstar*vevtwo)/(sqrt(numberofscalars)*m_h^2)
    DecaywidthWboson = ((2)/(pi*32*vev^2))*Mixing^2 *(massscalar^3)*(1-((4*m_W^2)/(massscalar^2)))^(1/2) * (1-4*((m_W)^2/(massscalar^2))+12*((m_W)^4/(massscalar^4))) 
    return DecaywidthWboson
end

function DecayWidthScalartoSMZboson(massscalar, mWboson, fermioncoupling, colorfactor, lambda, Mstar, vevtwo, numberofscalars)
    Mixing = (lambda*Mstar*vevtwo)/(sqrt(numberofscalars)*m_h^2)
    DecaywidthZboson = ((1)/(pi*32*vev^2))*Mixing^2 *(massscalar^3)*(1-((4*m_W^2)/(massscalar^2)))^(1/2) * (1-4*((m_W)^2/(massscalar^2))+12*((m_W)^4/(massscalar^4))) 
    return DecaywidthZboson
end

function DecaytoPhotons(massscalar, lambda, Mstar, vevtwo, numberofscalars)
    Mixing = (lambda*Mstar*vevtwo)/(sqrt(numberofscalars)*m_h^2)
    Decaywidthtophoton= 7^2 * ((1/137)/(4*pi))^2 * Mixing^2 * 1.1664*10^(-5) * (massscalar^3)/(8*sqrt(2)*pi)
    return Decaywidthtophoton
end
function DecaytoPions(massscalar, lambda, Mstar, vevtwo, numberofscalars)
    
    
    Mixing = (lambda*Mstar*vevtwo)/(sqrt(numberofscalars)*m_h^2)
    if massscalar < 1.0
    DecaywidthtoPions = Mixing^2 * 10^(-8) * (0.983 + 6.54* massscalar^2  − 1.12*massscalar^4 + 0.071*massscalar^6)
    else
    DecaywidthtoPions= (0.3/massscalar)^3 * Mixing^2 * 10^(-8) * (0.983 + 6.54* massscalar^2  − 1.12*massscalar^4 + 0.071*massscalar^6)
    end
    
    return DecaywidthtoPions
end
function DecaytoGluons(massscalar, lambda, Mstar, vevtwo, numberofscalars)
   
   if massscalar >0.4
    Mixing = (lambda*Mstar*vevtwo)/(sqrt(numberofscalars)*m_h^2)
    if massscalar < 2*m_strange
        Nh = 4
    elseif massscalar <2*m_charm
        Nh = 3
    elseif massscalar < 2*m_b
        Nh = 2
    else 
        Nh = 1
    end
    alphas = 0.44
    
    Decaywidthtogluons= Mixing^2 * (Nh^2 * alphas^2 * massscalar^3)/(72*pi^3 * vev^2)
    return Decaywidthtogluons
    else 
    return 0.0
end
end
function BranchingRatios(massscalar, scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)

    alloweddecaymasses = [x for x in scalarmasses if 2 * x < massscalar]
    Decaywidths = Vector{Float64}(undef, 0)
 
    if length(alloweddecaymasses)>0
        for i in 1:length(alloweddecaymasses)
        Decaywidthstos= DecayWidthScalartoScalar(massscalar, alloweddecaymasses[i], Mstar, lambdaprime, numberofscalars)
        push!(Decaywidths, Decaywidthstos)
        end
    end



     if massscalar > 2*m_b
         Decaywidthstobb = DecayWidthScalartoSM(massscalar, m_b, y_b, 3, lambda, Mstar, vevtwo, numberofscalars)
         push!(Decaywidths, Decaywidthstobb)

     end

     if massscalar > 2*m_charm
         Decaywidthstocc = DecayWidthScalartoSM(massscalar, m_charm, y_c, 3, lambda, Mstar, vevtwo, numberofscalars)
         push!(Decaywidths, Decaywidthstocc)

     end
    if massscalar > 2*m_tau
        Decaywidthstotautau = DecayWidthScalartoSM(massscalar, m_tau, y_tau, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstotautau)
    end 
    if massscalar > 2*m_strange
        Decaywidthstostrangestrange = DecayWidthScalartoSM(massscalar, m_strange, y_s, 3, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstostrangestrange)
    end
    if massscalar > 2*m_muon
        Decaywidthstomuonmuon = DecayWidthScalartoSM(massscalar, m_muon, y_muon, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstomuonmuon)
    end
    if massscalar > 2*0.134
        Decaywidthstouu = 2*DecaytoPions(massscalar,lambda, Mstar, vevtwo, numberofscalars)#DecayWidthScalartoSM(massscalar, m_u, y_u, 3, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstouu)
    end
    if massscalar > 2*0.139
        Decaywidthstodd = DecaytoPions(massscalar,lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstodd)
    end
    if massscalar > 2*m_electron
        Decaywidthstoee = DecayWidthScalartoSM(massscalar, m_electron, y_e, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstoee)
    end
    Decaywidthphopho = DecaytoPhotons(massscalar,lambda, Mstar, vevtwo, numberofscalars)
    Decaywidthgluon = DecaytoGluons(massscalar,lambda, Mstar, vevtwo, numberofscalars)
    push!(Decaywidths,Decaywidthphopho)
    push!(Decaywidths,Decaywidthgluon)
    Denominator = sum(Decaywidths)
    Branchingratios = Decaywidths ./ Denominator
    return Branchingratios
end

function BranchingRatiospairing(massscalar, scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda, thedict)
    pairing_partner = get(thedict, massscalar, "Not found")
  
    if pairing_partner < massscalar/2
    alloweddecaymasses = [pairing_partner]
    else
    alloweddecaymasses = []
    end
 
    Decaywidths = Vector{Float64}(undef, 0)
    if length(alloweddecaymasses)>0
        for i in 1:length(alloweddecaymasses)
        Decaywidthstos= DecayWidthScalartoScalar(massscalar, alloweddecaymasses[i], Mstar, lambdaprime, numberofscalars)
        push!(Decaywidths, Decaywidthstos)
        end
    end



     if massscalar > 2*m_b
         Decaywidthstobb = DecayWidthScalartoSM(massscalar, m_b, y_b, 3, lambda, Mstar, vevtwo, numberofscalars)
         push!(Decaywidths, Decaywidthstobb)
     end

     if massscalar > 2*m_charm
         Decaywidthstocc = DecayWidthScalartoSM(massscalar, m_charm, y_c, 3, lambda, Mstar, vevtwo, numberofscalars)
         push!(Decaywidths, Decaywidthstocc)
     end
    if massscalar > 2*m_tau
        Decaywidthstotautau = DecayWidthScalartoSM(massscalar, m_tau, y_tau, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstotautau)
    end 
    if massscalar > 2*m_strange
        Decaywidthstostrangestrange = DecayWidthScalartoSM(massscalar, m_strange, y_s, 3, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstostrangestrange)
    end
    if massscalar > 2*m_muon
        Decaywidthstomuonmuon = DecayWidthScalartoSM(massscalar, m_muon, y_muon, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstomuonmuon)
    end
    if massscalar > 2*0.134
        Decaywidthstouu = 2*DecaytoPions(massscalar,lambda, Mstar, vevtwo, numberofscalars)#DecayWidthScalartoSM(massscalar, m_u, y_u, 3, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstouu)
    end
    if massscalar > 2*0.139
        Decaywidthstodd = DecaytoPions(massscalar,lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstodd)
    end
    if massscalar > 2*m_electron
        Decaywidthstoee = DecayWidthScalartoSM(massscalar, m_electron, y_e, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstoee)
    end
    Decaywidthphopho = DecaytoPhotons(massscalar,lambda, Mstar, vevtwo, numberofscalars)
    Decaywidthgluon = DecaytoGluons(massscalar,lambda, Mstar, vevtwo, numberofscalars)
    push!(Decaywidths,Decaywidthphopho)
    push!(Decaywidths,Decaywidthgluon)
    Denominator = sum(Decaywidths)
    Branchingratios = Decaywidths ./ Denominator

    return Branchingratios
end

function BranchingRatiosgeneralquartic(massscalar, scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)

    alloweddecaymasses = [x for x in scalarmasses if  (x+minimum(scalarmasses)) < massscalar]
    Decaywidths = Vector{Float64}(undef, 0)
    masses1 = Vector{Float64}(undef, 0)
    masses2 = Vector{Float64}(undef, 0)
    DecaywidthsSM = Vector{Float64}(undef, 0)
    if length(alloweddecaymasses)>0
        for i in 1:length(alloweddecaymasses)
            for j in 1:length(alloweddecaymasses)
                Decaywidthstos= DecayWidthScalartoScalargeneralquartic(massscalar, alloweddecaymasses[i], alloweddecaymasses[j], Mstar, lambdaprime, numberofscalars)
                push!(Decaywidths, Decaywidthstos)
                push!(masses1, alloweddecaymasses[i])
                push!(masses2, alloweddecaymasses[j])
            end
        end
    end


     if massscalar > 2*m_b
         Decaywidthstobb = DecayWidthScalartoSM(massscalar, m_b, y_b, 3, lambda, Mstar, vevtwo, numberofscalars)
         push!(Decaywidths, Decaywidthstobb)
         push!(DecaywidthsSM, Decaywidthstobb)
         push!(masses1, m_b)
         push!(masses2, m_b)
     end

     if massscalar > 2*m_charm
         Decaywidthstocc = DecayWidthScalartoSM(massscalar, m_charm, y_c, 3, lambda, Mstar, vevtwo, numberofscalars)
         push!(Decaywidths, Decaywidthstocc)
         push!(DecaywidthsSM, Decaywidthstocc)
         push!(masses1, m_charm)
         push!(masses2, m_charm)
     end
    if massscalar > 2*m_tau
        Decaywidthstotautau = DecayWidthScalartoSM(massscalar, m_tau, y_tau, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstotautau)
        push!(DecaywidthsSM, Decaywidthstotautau)
        push!(masses1, m_tau)
        push!(masses2, m_tau)
    end 
    if massscalar > 2*m_strange
        Decaywidthstostrangestrange = DecayWidthScalartoSM(massscalar, m_strange, y_s, 3, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstostrangestrange)
        push!(DecaywidthsSM, Decaywidthstostrangestrange)
        push!(masses1, m_strange)
        push!(masses2, m_strange)
    end
    if massscalar > 2*m_muon
        Decaywidthstomuonmuon = DecayWidthScalartoSM(massscalar, m_muon, y_muon, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstomuonmuon)
        push!(DecaywidthsSM, Decaywidthstomuonmuon)
        push!(masses1, m_muon)
        push!(masses2, m_muon)
    end
    if massscalar > 2*0.134
        Decaywidthstouu = 2*DecaytoPions(massscalar,lambda, Mstar, vevtwo, numberofscalars)#DecayWidthScalartoSM(massscalar, m_u, y_u, 3, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstouu)
        push!(DecaywidthsSM, Decaywidthstouu)
        push!(masses1,0.134)
        push!(masses2,0.134)
    end
    if massscalar > 2*0.139
        Decaywidthstodd = DecaytoPions(massscalar,lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstodd)
        push!(DecaywidthsSM, Decaywidthstodd)
        push!(masses1,0.139)
        push!(masses2,0.139)
    end
    if massscalar > 2*m_electron
        Decaywidthstoee = DecayWidthScalartoSM(massscalar, m_electron, y_e, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstoee)
        push!(DecaywidthsSM, Decaywidthstoee)
        push!(masses1, m_electron)
        push!(masses2, m_electron)
    end
    if massscalar > 2*m_W
        DecaywidthstoWW = DecayWidthScalartoSMWboson(massscalar, m_W, y_e, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, DecaywidthstoWW)
        push!(DecaywidthsSM, DecaywidthstoWW)
        push!(masses1, m_W)
        push!(masses2, m_W)
    end
    if massscalar > 2*m_Z
        DecaywidthstoZZ = DecayWidthScalartoSMZboson(massscalar, m_W, y_e, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, DecaywidthstoZZ)
        push!(DecaywidthsSM, DecaywidthstoZZ)
        push!(masses1, m_Z)
        push!(masses2, m_Z)
    end
    if massscalar > 2*m_top
        Decaywidthstott = DecayWidthScalartoSM(massscalar, m_top, y_t, 3, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstott)
        push!(DecaywidthsSM, Decaywidthstott)
        push!(masses1, m_top)
        push!(masses2, m_top)
    end

    Decaywidthphopho = DecaytoPhotons(massscalar,lambda, Mstar, vevtwo, numberofscalars)
    Decaywidthgluon = DecaytoGluons(massscalar,lambda, Mstar, vevtwo, numberofscalars)
    push!(DecaywidthsSM, Decaywidthphopho)
    push!(DecaywidthsSM, Decaywidthgluon)
    push!(Decaywidths,Decaywidthphopho)
    push!(masses1, massscalar/2)
    push!(masses2, massscalar/2)   
    push!(Decaywidths,Decaywidthgluon)
    push!(masses1, massscalar/2)
    push!(masses2, massscalar/2)  
    Denominator = sum(Decaywidths)
    TotalWidthtoSM = sum(DecaywidthsSM)
    Branchingratios = Decaywidths ./ Denominator
    BranchingratiotoSM = TotalWidthtoSM ./ Denominator
    return Branchingratios, masses1, masses2
end
function DecayChain(massscalar, scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)

    if 2*minimum(scalarmasses)> massscalar && 2*m_electron > massscalar
       return println("stable scalar")
    else

        massofedukts = Vector{Float64}(undef, 0)
        branchingratiosofedukts=Vector{Float64}(undef, 0)
        Products = Vector{Float64}(undef, 0)
        push!(massofedukts, massscalar)

        while length(massofedukts)>0 && (maximum(massofedukts) > 2*minimum(scalarmasses) || maximum(massofedukts) > 2*m_electron)
      
            massesofproducts = Vector{Float64}(undef, 0)
            for k in 1:length(massofedukts)
               
       
                massesavailable = [x for x in scalarmasses if 2 * x < massofedukts[k]]
                  if massofedukts[k] > 2*m_b
                     push!(massesavailable, m_b)
              
                   end
                   if massofedukts[k] > 2*m_charm
                    push!(massesavailable, m_charm)
                  end
                  if massofedukts[k] > 2*m_tau
                      push!(massesavailable, m_tau)
                  end
                  if massofedukts[k] > 2*m_strange
                    push!(massesavailable, m_strange)
                  end
                  if massofedukts[k] > 2*m_muon
                      push!(massesavailable, m_muon)
                  end
                  if massofedukts[k] > 2*m_u
                    push!(massesavailable, m_u)
                  end
                  if massofedukts[k] > 2*m_d
                    push!(massesavailable, m_d)
                  end
                  if massofedukts[k] > 2*m_electron
                    push!(massesavailable, m_electron)
                  end
                  push!(massesavailable, massofedukts[k]/2)
                  push!(massesavailable, massofedukts[k]/2)
              if length(massesavailable) ==0
                push!(Products, massofedukts[k])
              else
              BR = BranchingRatios(massofedukts[k], scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)
      
              dist = Categorical(BR)
             
              massproduct = massesavailable[rand(dist)]
 
                 if massproduct == m_b || massproduct == m_charm ||massproduct == m_tau ||massproduct == m_strange ||massproduct == m_muon  ||massproduct == m_u ||massproduct == m_d ||massproduct == m_electron

                  push!(Products, massproduct)
                  push!(Products, massproduct)
           
                 elseif massproduct == massofedukts[k]/2
                
                        l = length(BR)
                        
                        if BR[l-1]>BR[l]
                           pphoton = 1- BR[l]/BR[l-1]
                           pgluon = BR[l]/BR[l-1]
                           dist = Categorical([pphoton, pgluon])
    
                           # Draw a sample and map it to values 1 and 2
                           sample = rand(dist)
                           push!(Products, sample)
                           push!(Products, sample)
                           
                        else
                           pphoton = BR[l-1]/BR[l]
                           pgluon = 1-BR[l-1]/BR[l]
                           dist = Categorical([pphoton, pgluon])
    
                           # Draw a sample and map it to values 1 and 2
                           sample = rand(dist)
                           push!(Products, sample)
                           push!(Products, sample)
                           
                        end

                 else
                  push!(massesofproducts, massproduct)
                  push!(massesofproducts, massproduct)
             
                 end
                end
            end
    
     
            massofedukts = massesofproducts
         
   
        end
   
        append!(Products, massofedukts)
        return Products
    end
end

function DecayChainpaired(massscalar, scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)

    array1 = scalarmasses

    
    array2 = circshift(array1, -1)
    closestneighbour_paired = collect(zip(array1, array2))
    pair_dict = Dict(closestneighbour_paired)
    pair_partner = get(pair_dict, massscalar, "Not found")
    pparray = [pair_partner]


    if 2*minimum(scalarmasses)> massscalar && 2*m_electron > massscalar
       return println("stable scalar")
    else

        massofedukts = Vector{Float64}(undef, 0)
        branchingratiosofedukts=Vector{Float64}(undef, 0)
        Products = Vector{Float64}(undef, 0)
        push!(massofedukts, massscalar)

        while length(massofedukts)>0 && (maximum(massofedukts) > 2*minimum(scalarmasses) || maximum(massofedukts) > 2*m_electron)
      
            massesofproducts = Vector{Float64}(undef, 0)
            for k in 1:length(massofedukts)
               
                pairrr_partner = get(pair_dict, massofedukts[k], "Not found")
                ppparray = [pairrr_partner]
                massesavailable = [x for x in ppparray if 2 * x < massofedukts[k]]

                  if massofedukts[k] > 2*m_b
                     push!(massesavailable, m_b)
              
                   end
                   if massofedukts[k] > 2*m_charm
                    push!(massesavailable, m_charm)
                  end
                  if massofedukts[k] > 2*m_tau
                      push!(massesavailable, m_tau)
                  end
                  if massofedukts[k] > 2*m_strange
                    push!(massesavailable, m_strange)
                  end
                  if massofedukts[k] > 2*m_muon
                      push!(massesavailable, m_muon)
                  end
                  if massofedukts[k] > 2*m_u
                    push!(massesavailable, m_u)
                  end
                  if massofedukts[k] > 2*m_d
                    push!(massesavailable, m_d)
                  end
                  if massofedukts[k] > 2*m_electron
                    push!(massesavailable, m_electron)
                  end
                  push!(massesavailable, massofedukts[k]/2)
                  push!(massesavailable, massofedukts[k]/2)
              if length(massesavailable) ==0
                push!(Products, massofedukts[k])
              else
              BR = BranchingRatiospairing(massofedukts[k], scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda, pair_dict)
      
              dist = Categorical(BR)

              massproduct = massesavailable[rand(dist)]
 
                 if massproduct == m_b || massproduct == m_charm ||massproduct == m_tau ||massproduct == m_strange ||massproduct == m_muon  ||massproduct == m_u ||massproduct == m_d ||massproduct == m_electron

                  push!(Products, massproduct)
                  push!(Products, massproduct)
           
                 elseif massproduct == massofedukts[k]/2
                
                        l = length(BR)
                        
                        if BR[l-1]>BR[l]
                           pphoton = 1- BR[l]/BR[l-1]
                           pgluon = BR[l]/BR[l-1]
                           dist = Categorical([pphoton, pgluon])
    
                           # Draw a sample and map it to values 1 and 2
                           sample = rand(dist)
                           push!(Products, sample)
                           push!(Products, sample)
                           
                        else
                           pphoton = BR[l-1]/BR[l]
                           pgluon = 1-BR[l-1]/BR[l]
                           dist = Categorical([pphoton, pgluon])
    
                           # Draw a sample and map it to values 1 and 2
                           sample = rand(dist)
                           push!(Products, sample)
                           push!(Products, sample)
                           
                        end

                 else
                  push!(massesofproducts, massproduct)
                  push!(massesofproducts, massproduct)
             
                 end
                end
            end
    
     
            massofedukts = massesofproducts
         
   
        end
   
        append!(Products, massofedukts)
        return Products
    end
end




function DecayChaingeneralquartic(massscalar, scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)

    if 2*minimum(scalarmasses)> massscalar && 2*m_electron > massscalar
       return println("stable scalar")
    else

        massofedukts = Vector{Float64}(undef, 0)
        branchingratiosofedukts=Vector{Float64}(undef, 0)
        Products = Vector{Float64}(undef, 0)
        push!(massofedukts, massscalar)

        while length(massofedukts)>0 && (maximum(massofedukts) > 2*minimum(scalarmasses) || maximum(massofedukts) > 2*m_electron)
      
            massesofproducts = Vector{Float64}(undef, 0)
            for k in 1:length(massofedukts)
               
       
                massesavailable = [x for x in scalarmasses if (x+minimum(scalarmasses)) < massofedukts[k]]
                  if massofedukts[k] > 2*m_b
                     push!(massesavailable, m_b)
              
                   end
                   if massofedukts[k] > 2*m_charm
                    push!(massesavailable, m_charm)
                  end
                  if massofedukts[k] > 2*m_tau
                      push!(massesavailable, m_tau)
                  end
                  if massofedukts[k] > 2*m_strange
                    push!(massesavailable, m_strange)
                  end
                  if massofedukts[k] > 2*m_muon
                      push!(massesavailable, m_muon)
                  end
                  if massofedukts[k] > 2*0.134
                    push!(massesavailable, 0.134)
                  end
                  if massofedukts[k] > 2*0.139
                    push!(massesavailable, 0.139)
                  end
                  if massofedukts[k] > 2*m_electron
                    push!(massesavailable, m_electron)
                  end
                  if massofedukts[k] > 2*m_W
                    push!(massesavailable, m_W)
                  end
                  if massofedukts[k] > 2*m_Z
                    push!(massesavailable, m_Z)
                  end
                  if massofedukts[k] > 2*m_top
                    push!(massesavailable, m_top)
                  end
                  push!(massesavailable, massofedukts[k]/2)
                  push!(massesavailable, massofedukts[k]/2)
              if length(massesavailable) ==0
                push!(Products, massofedukts[k])
              else
              BR, mass1, mass2 = BranchingRatiosgeneralquartic(massofedukts[k], scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)
      
              dist = Categorical(BR)
              index = rand(dist)
              massproduct = mass1[index]
              massproduct2 = mass2[index]
                 if massproduct == m_b || massproduct == m_charm ||massproduct == m_tau ||massproduct == m_strange ||massproduct == m_muon  ||massproduct == m_u ||massproduct == m_d ||massproduct == m_electron ||massproduct == m_W ||massproduct == m_Z ||massproduct == m_top

                  push!(Products, massproduct)
                  push!(Products, massproduct2)
           
                 elseif massproduct == massofedukts[k]/2
                
                        l = length(BR)
                        
                        if BR[l-1]>BR[l]
                           pphoton = 1- BR[l]/BR[l-1]
                           pgluon = BR[l]/BR[l-1]
                           dist = Categorical([pphoton, pgluon])
    
                           # Draw a sample and map it to values 1 and 2
                           sample = rand(dist)
                           push!(Products, sample)
                           push!(Products, sample)
                           
                        else
                           pphoton = BR[l-1]/BR[l]
                           pgluon = 1-BR[l-1]/BR[l]
                           dist = Categorical([pphoton, pgluon])
    
                           # Draw a sample and map it to values 1 and 2
                           sample = rand(dist)
                           push!(Products, sample)
                           push!(Products, sample)
                           
                        end

                 else
                  push!(massesofproducts, massproduct)
                  push!(massesofproducts, massproduct2)
             
                 end
                end
            end
    
     
            massofedukts = massesofproducts
         
   
        end
   
        append!(Products, massofedukts)
        return Products
    end
end
function BranchingRatios2(massscalar, scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)

    alloweddecaymasses = [x for x in scalarmasses if 2 * x < massscalar]
    Decaywidths = Vector{Float64}(undef, 0)
    DecaywidthsSM = Vector{Float64}(undef, 0)
    if length(alloweddecaymasses)>0
        for i in 1:length(alloweddecaymasses)
        Decaywidthstos= DecayWidthScalartoScalar(massscalar, alloweddecaymasses[i], Mstar, lambdaprime, numberofscalars)
        push!(Decaywidths, Decaywidthstos)
        end
    end

    scalardecaywidth = sum(Decaywidths)

     if massscalar > 2*m_b
         Decaywidthstobb = DecayWidthScalartoSM(massscalar, m_b, y_b, 3, lambda, Mstar, vevtwo, numberofscalars)
         push!(Decaywidths, Decaywidthstobb)
         push!(DecaywidthsSM, Decaywidthstobb)
     end

     if massscalar > 2*m_charm
         Decaywidthstocc = DecayWidthScalartoSM(massscalar, m_charm, y_c, 3, lambda, Mstar, vevtwo, numberofscalars)
         push!(Decaywidths, Decaywidthstocc)
         push!(DecaywidthsSM, Decaywidthstocc)
     end
    if massscalar > 2*m_tau
        Decaywidthstotautau = DecayWidthScalartoSM(massscalar, m_tau, y_tau, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstotautau)
        push!(DecaywidthsSM, Decaywidthstotautau)
    end 
    if massscalar > 2*m_strange
        Decaywidthstostrangestrange = DecayWidthScalartoSM(massscalar, m_strange, y_s, 3, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstostrangestrange)
        push!(DecaywidthsSM, Decaywidthstostrangestrange)
    end
    if massscalar > 2*m_muon
        Decaywidthstomuonmuon = DecayWidthScalartoSM(massscalar, m_muon, y_muon, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstomuonmuon)
        push!(DecaywidthsSM, Decaywidthstomuonmuon)
    end

    if massscalar > 2*0.134
        Decaywidthstouu = 2*DecaytoPions(massscalar,lambda, Mstar, vevtwo, numberofscalars)#DecayWidthScalartoSM(massscalar, m_u, y_u, 3, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstouu)
        push!(DecaywidthsSM, Decaywidthstouu)
    end
    if massscalar > 2*0.139
        Decaywidthstodd = DecaytoPions(massscalar,lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstodd)
        push!(DecaywidthsSM, Decaywidthstodd)
    end




    if massscalar > 2*m_electron
        Decaywidthstoee = DecayWidthScalartoSM(massscalar, m_electron, y_e, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstoee)
        push!(DecaywidthsSM, Decaywidthstoee)
    end

    Decaywidthphopho = DecaytoPhotons(massscalar,lambda, Mstar, vevtwo, numberofscalars)
    Decaywidthgluon = DecaytoGluons(massscalar,lambda, Mstar, vevtwo, numberofscalars)
    push!(Decaywidths,Decaywidthphopho)
    push!(Decaywidths,Decaywidthgluon)
    push!(DecaywidthsSM,Decaywidthphopho)
    push!(DecaywidthsSM,Decaywidthgluon)



    Denominator = sum(Decaywidths)
    Branchingratios = Decaywidths ./ Denominator
    DecaywidthstoSM=sum(DecaywidthsSM)
  #  println(scalardecaywidth/DecaywidthstoSM)
    a = scalardecaywidth/DecaywidthstoSM
    return a
end
function BranchingRatiosgeneralquartic2(massscalar, scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)

    alloweddecaymasses = [x for x in scalarmasses if (x+minimum(scalarmasses)) < massscalar]
    Decaywidths = Vector{Float64}(undef, 0)
    DecaywidthsSM = Vector{Float64}(undef, 0)
    if length(alloweddecaymasses)>0
        for i in 1:length(alloweddecaymasses)
            for j in 1:length(alloweddecaymasses)
                Decaywidthstos= DecayWidthScalartoScalargeneralquartic(massscalar, alloweddecaymasses[i], alloweddecaymasses[j], Mstar, lambdaprime, numberofscalars)
                push!(Decaywidths, Decaywidthstos)
            end
        end
    end

    scalardecaywidth = sum(Decaywidths)

     if massscalar > 2*m_b
         Decaywidthstobb = DecayWidthScalartoSM(massscalar, m_b, y_b, 3, lambda, Mstar, vevtwo, numberofscalars)
         push!(Decaywidths, Decaywidthstobb)
         push!(DecaywidthsSM, Decaywidthstobb)
     end

     if massscalar > 2*m_charm
         Decaywidthstocc = DecayWidthScalartoSM(massscalar, m_charm, y_c, 3, lambda, Mstar, vevtwo, numberofscalars)
         push!(Decaywidths, Decaywidthstocc)
         push!(DecaywidthsSM, Decaywidthstocc)
     end
    if massscalar > 2*m_tau
        Decaywidthstotautau = DecayWidthScalartoSM(massscalar, m_tau, y_tau, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstotautau)
        push!(DecaywidthsSM, Decaywidthstotautau)
    end 
    if massscalar > 2*m_strange
        Decaywidthstostrangestrange = DecayWidthScalartoSM(massscalar, m_strange, y_s, 3, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstostrangestrange)
        push!(DecaywidthsSM, Decaywidthstostrangestrange)
    end
    if massscalar > 2*m_muon
        Decaywidthstomuonmuon = DecayWidthScalartoSM(massscalar, m_muon, y_muon, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstomuonmuon)
        push!(DecaywidthsSM, Decaywidthstomuonmuon)
    end

    if massscalar > 2*0.134
        Decaywidthstouu = 2*DecaytoPions(massscalar,lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstouu)
        push!(DecaywidthsSM, Decaywidthstouu)
    end
    if massscalar > 2*0.139
        Decaywidthstodd = DecaytoPions(massscalar,lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstodd)
        push!(DecaywidthsSM, Decaywidthstodd)
    end




    if massscalar > 2*m_electron
        Decaywidthstoee = DecayWidthScalartoSM(massscalar, m_electron, y_e, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstoee)
        push!(DecaywidthsSM, Decaywidthstoee)
    end

    Decaywidthphopho = DecaytoPhotons(massscalar,lambda, Mstar, vevtwo, numberofscalars)
    Decaywidthgluon = DecaytoGluons(massscalar,lambda, Mstar, vevtwo, numberofscalars)
    push!(Decaywidths,Decaywidthphopho)
    push!(Decaywidths,Decaywidthgluon)
    push!(DecaywidthsSM,Decaywidthphopho)
    push!(DecaywidthsSM,Decaywidthgluon)



    Denominator = sum(Decaywidths)
    Branchingratios = Decaywidths ./ Denominator
    DecaywidthstoSM=sum(DecaywidthsSM)
    BranchingratiostoSM = DecaywidthstoSM ./ Denominator
  
    a = scalardecaywidth/DecaywidthstoSM
    return a, BranchingratiostoSM, massscalar
end

function BranchingRatiospairing2(massscalar, scalarmasses, Mstar, lambdaprime, numberofscalars, vevtwo, lambda)
    array1 = scalarmasses

    
    array2 = circshift(array1, -1)
    closestneighbour_paired = collect(zip(array1, array2))
    pair_dict = Dict(closestneighbour_paired)
    
    pair_partner = get(pair_dict, massscalar, "Not found")
    if pair_partner < massscalar/2
    alloweddecaymasses = [pair_partner]
    else
    alloweddecaymasses = []
    end
    Decaywidths = Vector{Float64}(undef, 0)
    DecaywidthsSM = Vector{Float64}(undef, 0)
    if length(alloweddecaymasses)>0
        for i in 1:length(alloweddecaymasses)
        Decaywidthstos= DecayWidthScalartoScalar(massscalar, alloweddecaymasses[i], Mstar, lambdaprime, numberofscalars)
        push!(Decaywidths, Decaywidthstos)
        end
    end

    scalardecaywidth = sum(Decaywidths)

     if massscalar > 2*m_b
         Decaywidthstobb = DecayWidthScalartoSM(massscalar, m_b, y_b, 3, lambda, Mstar, vevtwo, numberofscalars)
         push!(Decaywidths, Decaywidthstobb)
         push!(DecaywidthsSM, Decaywidthstobb)
     end

     if massscalar > 2*m_charm
         Decaywidthstocc = DecayWidthScalartoSM(massscalar, m_charm, y_c, 3, lambda, Mstar, vevtwo, numberofscalars)
         push!(Decaywidths, Decaywidthstocc)
         push!(DecaywidthsSM, Decaywidthstocc)
     end
    if massscalar > 2*m_tau
        Decaywidthstotautau = DecayWidthScalartoSM(massscalar, m_tau, y_tau, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstotautau)
        push!(DecaywidthsSM, Decaywidthstotautau)
    end 
    if massscalar > 2*m_strange
        Decaywidthstostrangestrange = DecayWidthScalartoSM(massscalar, m_strange, y_s, 3, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstostrangestrange)
        push!(DecaywidthsSM, Decaywidthstostrangestrange)
    end
    if massscalar > 2*m_muon
        Decaywidthstomuonmuon = DecayWidthScalartoSM(massscalar, m_muon, y_muon, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstomuonmuon)
        push!(DecaywidthsSM, Decaywidthstomuonmuon)
    end

    if massscalar > 2*0.134
        Decaywidthstouu = 2*DecaytoPions(massscalar,lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstouu)
        push!(DecaywidthsSM, Decaywidthstouu)
    end
    if massscalar > 2*0.139
        Decaywidthstodd = DecaytoPions(massscalar,lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstodd)
        push!(DecaywidthsSM, Decaywidthstodd)
    end




    if massscalar > 2*m_electron
        Decaywidthstoee = DecayWidthScalartoSM(massscalar, m_electron, y_e, 1, lambda, Mstar, vevtwo, numberofscalars)
        push!(Decaywidths, Decaywidthstoee)
        push!(DecaywidthsSM, Decaywidthstoee)
    end

    Decaywidthphopho = DecaytoPhotons(massscalar,lambda, Mstar, vevtwo, numberofscalars)
    Decaywidthgluon = DecaytoGluons(massscalar,lambda, Mstar, vevtwo, numberofscalars)
    push!(Decaywidths,Decaywidthphopho)
    push!(Decaywidths,Decaywidthgluon)
    push!(DecaywidthsSM,Decaywidthphopho)
    push!(DecaywidthsSM,Decaywidthgluon)



    Denominator = sum(Decaywidths)
    Branchingratios = Decaywidths ./ Denominator
    DecaywidthstoSM=sum(DecaywidthsSM)
  
    a = scalardecaywidth/DecaywidthstoSM
    return a
end

function decreasing_geometric_interval(high, low, N)
    # compute common ratio r such that a * r^(N-1) = low
    r = (low / high)^(1 / (N - 1))
    return [high * r^(i - 1) for i in 1:N]
end