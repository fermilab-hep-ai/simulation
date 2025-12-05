########################################
#
#  CMS Phase II Configuration Card: Snowmass2021 Tune with COLLIDE-2V Dual-View Architecture
#
#  Main authors: Michele Selvaggi, Ryan Liu, Eric Moreno (CERN)
#
#  Released on: November 14, 2025
#
#  Version: v1.0
#
#  Based on: CMS_PhaseII_200PU_Snowmass2021_v0.tcl + Custom L1T dual-view architecture based on CMS_PhasII_200PU_v04.tcl
#
#  Description: This card provides two independent reconstruction views:
#    - Full-Reco: Modern Snowmass tune with high-performance tracking
#    - L1T: Degraded performance matching L1 trigger constraints 
#
#######################################
# Order of execution of various modules
#######################################

# set max events
set MaxEvents 100

set ExecutionPath {

  PileUpMerger
  ParticlePropagator
  TrackMergerProp

  DenseProp
  DenseMergeTracks
  DenseTrackFilter

  ChargedHadronTrackingEfficiency
  ElectronTrackingEfficiency
  MuonTrackingEfficiency

  ChargedHadronMomentumSmearing
  ElectronEnergySmearing
  MuonMomentumSmearing

  TrackMerger

  ECal
  HCal

  PhotonEnergySmearing
  ElectronFilter

  TrackPileUpSubtractor
  RecoPuFilter

  TowerMerger
  NeutralEFlowMerger

  EFlowMerger
  EFlowMergerCHS
  Rho

  LeptonFilterNoLep
  LeptonFilterLep
  RunPUPPIBase
  RunPUPPIMerger
  RunPUPPI

  EFlowFilterPuppi

  GenParticleFilter
  PhotonFilter

  NeutrinoFilter

  PhotonIsolation
  PhotonScale
  PhotonSmear


  PhotonLooseID
  PhotonMediumID
  PhotonTightID

  ElectronIsolation
  ElectronScale
  ElectronSmear

  ElectronLooseEfficiency
  ElectronMediumEfficiency
  ElectronTightEfficiency

  MuonIsolation
  MuonScale
  MuonSmear

  MuonLooseIdEfficiency
  MuonMediumIdEfficiency
  MuonTightIdEfficiency

  GenMissingET
  GenPileUpMissingET

  GenJetFinder
  GenJetFinderAK8

  PuppiMissingET
  ScalarHT

  FastJetFinderPUPPI
  FastJetFinderPUPPIAK8

  JetScalePUPPI
  JetScalePUPPIAK8
  JetSmearPUPPI
  JetSmearPUPPIAK8

  JetFlavorAssociationPUPPI
  JetFlavorAssociationPUPPIAK8

  BTaggingPUPPILoose
  BTaggingPUPPIMedium
  BTaggingPUPPITight

  BTaggingPUPPIAK8Loose
  BTaggingPUPPIAK8Medium
  BTaggingPUPPIAK8Tight

  TauTaggingPUPPILoose
  TauTaggingPUPPIMedium
  TauTaggingPUPPITight

  JetLooseID
  JetTightID

  JetFakeMakerLoose
  JetFakeMakerMedium
  JetFakeMakerTight

  PhotonFakeMergerLoose
  PhotonFakeMergerMedium
  PhotonFakeMergerTight

  ElectronFakeMergerLoose
  ElectronFakeMergerMedium
  ElectronFakeMergerTight

  MuonFakeMergerLoose
  MuonFakeMergerMedium
  MuonFakeMergerTight

  L1TChargedHadronTrackingEfficiency
  L1TElectronTrackingEfficiency
  L1TMuonTrackingEfficiency

  L1TChargedHadronMomentumSmearing
  L1TElectronEnergySmearing
  L1TMuonMomentumSmearing

  L1TTrackMerger

  L1TECal
  L1THCal

  L1TPhotonEnergySmearing
  L1TElectronFilter

  L1TTrackPileUpSubtractor
  L1TRecoPuFilter

  L1TTowerMerger
  L1TNeutralEFlowMerger

  L1TEFlowMerger
  L1TEFlowMergerCHS
  L1TRho

  L1TLeptonFilterNoLep
  L1TLeptonFilterLep
  L1TRunPUPPIBase
  L1TRunPUPPIMerger
  L1TRunPUPPI

  L1TEFlowFilterPuppi

  L1TPhotonFilter

  L1TPhotonIsolation
  L1TPhotonScale
  L1TPhotonSmear


  L1TPhotonLooseID
  L1TPhotonMediumID
  L1TPhotonTightID

  L1TElectronIsolation
  L1TElectronScale
  L1TElectronSmear

  L1TElectronLooseEfficiency
  L1TElectronMediumEfficiency
  L1TElectronTightEfficiency

  L1TMuonIsolation
  L1TMuonScale
  L1TMuonSmear

  L1TMuonLooseIdEfficiency
  L1TMuonMediumIdEfficiency
  L1TMuonTightIdEfficiency

  L1TPuppiMissingET
  L1TScalarHT

  L1TFastJetFinderPUPPI
  L1TFastJetFinderPUPPIAK8

  L1TJetScalePUPPI
  L1TJetScalePUPPIAK8
  L1TJetSmearPUPPI
  L1TJetSmearPUPPIAK8

  L1TJetFlavorAssociationPUPPI
  L1TJetFlavorAssociationPUPPIAK8

  L1TBTaggingPUPPILoose
  L1TBTaggingPUPPIMedium
  L1TBTaggingPUPPITight

  L1TBTaggingPUPPIAK8Loose
  L1TBTaggingPUPPIAK8Medium
  L1TBTaggingPUPPIAK8Tight

  L1TTauTaggingPUPPILoose
  L1TTauTaggingPUPPIMedium
  L1TTauTaggingPUPPITight

  L1TJetLooseID
  L1TJetTightID

  L1TJetFakeMakerLoose
  L1TJetFakeMakerMedium
  L1TJetFakeMakerTight

  L1TPhotonFakeMergerLoose
  L1TPhotonFakeMergerMedium
  L1TPhotonFakeMergerTight

  L1TElectronFakeMergerLoose
  L1TElectronFakeMergerMedium
  L1TElectronFakeMergerTight

  L1TMuonFakeMergerLoose
  L1TMuonFakeMergerMedium
  L1TMuonFakeMergerTight

  TreeWriter
}


###############
# PileUp Merger
###############

module PileUpMerger PileUpMerger {
  set InputArray Delphes/stableParticles

  set ParticleOutputArray stableParticles
  set VertexOutputArray vertices

  # pre-generated minbias input file
  #set PileUpFile /eos/cms/store/group/upgrade/delphes/PhaseII/MinBias_100k.pileup
  set PileUpFile MinBias_100k.pileup
  
  # average expected pile up
  set MeanPileUp 200

  # maximum spread in the beam direction in m
  set ZVertexSpread 0.25

  # maximum spread in time in s
  set TVertexSpread 800E-12

  # vertex smearing formula f(z,t) (z,t need to be respectively given in m,s) - {exp(-(t^2/160e-12^2/2))*exp(-(z^2/0.053^2/2))}
  set VertexDistributionFormula {exp(-(t^2/160e-12^2/2))*exp(-(z^2/0.053^2/2))}

}



#####################################
# Track propagation to calorimeters
#####################################

module ParticlePropagator ParticlePropagator {
  set InputArray PileUpMerger/stableParticles

  set OutputArray stableParticles
  set NeutralOutputArray neutralParticles
  set ChargedHadronOutputArray chargedHadrons
  set ElectronOutputArray electrons
  set MuonOutputArray muons

  # radius of the magnetic field coverage, in m
  set Radius 1.29
  # half-length of the magnetic field coverage, in m
  set HalfLength 3.0

  # magnetic field
  set Bz 3.8
}


##############
# Track merger
##############

module Merger TrackMergerProp {
# add InputArray InputArray
  add InputArray ParticlePropagator/chargedHadrons
  add InputArray ParticlePropagator/electrons
  add InputArray ParticlePropagator/muons
  set OutputArray tracks
}


####################################
# Track propagation to pseudo-pixel
####################################

module ParticlePropagator DenseProp {

  set InputArray TrackMergerProp/tracks

  # radius of the first pixel layer
  set Radius 0.3
  set RadiusMax 1.29
  # half-length of the magnetic field coverage, in m
  set HalfLength 0.7
  set HalfLengthMax 3.0

  # magnetic field
  set Bz 3.8
}


####################
# Dense Track merger
###################

module Merger DenseMergeTracks {
# add InputArray InputArray
  add InputArray DenseProp/chargedHadrons
  add InputArray DenseProp/electrons
  add InputArray DenseProp/muons
  set OutputArray tracks
}

######################
#   Dense Track Filter
######################

module DenseTrackFilter DenseTrackFilter {

  set TrackInputArray DenseMergeTracks/tracks

  set TrackOutputArray tracks
  set ChargedHadronOutputArray chargedHadrons
  set ElectronOutputArray electrons
  set MuonOutputArray muons

  set EtaPhiRes 0.003
  set EtaMax 4.0

  set pi [expr {acos(-1)}]

  set nbins_phi [expr {$pi/$EtaPhiRes} ]
  set nbins_phi [expr {int($nbins_phi)} ]

  set PhiBins {}
  for {set i -$nbins_phi} {$i <= $nbins_phi} {incr i} {
    add PhiBins [expr {$i * $pi/$nbins_phi}]
  }

  set nbins_eta [expr {$EtaMax/$EtaPhiRes} ]
  set nbins_eta [expr {int($nbins_eta)} ]

  for {set i -$nbins_eta} {$i <= $nbins_eta} {incr i} {
    set eta [expr {$i * $EtaPhiRes}]
    add EtaPhiBins $eta $PhiBins
  }

}



####################################
# Charged hadron tracking efficiency
####################################

module Efficiency ChargedHadronTrackingEfficiency {
  ## particles after propagation
  set InputArray  DenseTrackFilter/chargedHadrons
  set OutputArray chargedHadrons
  # tracking efficiency formula for charged hadrons
  set UseMomentumVector true

  set EfficiencyFormula {
      (pt <= 0.2) * (0.00) + \
          (abs(eta) <= 1.2) * (pt > 0.2 && pt <= 1.0) * (pt * 0.96) + \
          (abs(eta) <= 1.2) * (pt > 1.0) * (0.97) + \
          (abs(eta) > 1.2 && abs(eta) <= 2.5) * (pt > 0.2 && pt <= 1.0) * (pt*0.85) + \
          (abs(eta) > 1.2 && abs(eta) <= 2.5) * (pt > 1.0) * (0.87) + \
          (abs(eta) > 2.5 && abs(eta) <= 4.0) * (pt > 0.2 && pt <= 1.0) * (pt*0.8) + \
          (abs(eta) > 2.5 && abs(eta) <= 4.0) * (pt > 1.0) * (0.82) + \
          (abs(eta) > 4.0) * (0.00)
  }
}


#####################################
# Electron tracking efficiency - ID
####################################

module Efficiency ElectronTrackingEfficiency {
  set InputArray  DenseTrackFilter/electrons
  set OutputArray electrons
  set UseMomentumVector true

  # tracking efficiency formula for electrons
  set EfficiencyFormula {
      (pt <= 0.2) * (0.00) + \
          (abs(eta) <= 1.2) * (pt > 0.2 && pt <= 1.0) * (pt * 0.96) + \
          (abs(eta) <= 1.2) * (pt > 1.0) * (0.97) + \
          (abs(eta) > 1.2 && abs(eta) <= 2.5) * (pt > 0.2 && pt <= 1.0) * (pt*0.85) + \
          (abs(eta) > 1.2 && abs(eta) <= 2.5) * (pt > 1.0 && pt <= 10.0) * (0.82+pt*0.01) + \
          (abs(eta) > 1.2 && abs(eta) <= 2.5) * (pt > 10.0) * (1.0) + \
          (abs(eta) > 2.5 && abs(eta) <= 4.0) * (pt > 0.2 && pt <= 1.0) * (pt*0.8) + \
          (abs(eta) > 2.5 && abs(eta) <= 4.0) * (pt > 1.0 && pt <= 10.0) * (0.8+pt*0.01) + \
          (abs(eta) > 2.5 && abs(eta) <= 4.0) * (pt > 10.0) * (1.0) + \
          (abs(eta) > 4.0) * (0.00)

  }
  # eta 1.2-2.5 had 0.9 and 2.5-4.0 had 0.85 above 10 GeV
}

##########################
# Muon tracking efficiency
##########################

module Efficiency MuonTrackingEfficiency {
  set InputArray DenseTrackFilter/muons
  set OutputArray muons
  set UseMomentumVector true
  # tracking efficiency formula for muons
  set EfficiencyFormula {
      (pt <= 0.2) * (0.00) + \
          (abs(eta) <= 1.2) * (pt > 0.2 && pt <= 1.0) * (pt * 1.00) + \
          (abs(eta) <= 1.2) * (pt > 1.0) * (1.00) + \
          (abs(eta) > 1.2 && abs(eta) <= 2.8) * (pt > 0.2 && pt <= 1.0) * (pt*1.00) + \
          (abs(eta) > 1.2 && abs(eta) <= 2.8) * (pt > 1.0) * (1.00) + \
          (abs(eta) > 2.8 && abs(eta) <= 4.0) * (pt > 0.2 && pt <= 1.0) * (pt*0.95) + \
          (abs(eta) > 2.8 && abs(eta) <= 4.0) * (pt > 1.0) * (0.95) + \
          (abs(eta) > 4.0) * (0.00)

  }
}


########################################
# Momentum resolution for charged tracks
########################################

module MomentumSmearing ChargedHadronMomentumSmearing {
  ## hadrons after having applied the tracking efficiency
  set InputArray  ChargedHadronTrackingEfficiency/chargedHadrons
  set OutputArray chargedHadrons
  # resolution formula for charged hadrons ,

  #
  # Automatically generated tracker resolution formula for layout: OT612IT4025
  #
  #  By Unknown author on: 2017-06-30.17:03:00
  #
  set ResolutionFormula {    (abs(eta) >= 0.0000 && abs(eta) < 0.2000) * (pt >= 0.0000 && pt < 1.0000) * (0.00457888) + \
     (abs(eta) >= 0.0000 && abs(eta) < 0.2000) * (pt >= 1.0000 && pt < 10.0000) * (0.004579 + (pt-1.000000)* 0.000045) + \
     (abs(eta) >= 0.0000 && abs(eta) < 0.2000) * (pt >= 10.0000 && pt < 100.0000) * (0.004983 + (pt-10.000000)* 0.000047) + \
     (abs(eta) >= 0.0000 && abs(eta) < 0.2000) * (pt >= 100.0000) * (0.009244*pt/100.000000) + \
     (abs(eta) >= 0.2000 && abs(eta) < 0.4000) * (pt >= 0.0000 && pt < 1.0000) * (0.00505011) + \
     (abs(eta) >= 0.2000 && abs(eta) < 0.4000) * (pt >= 1.0000 && pt < 10.0000) * (0.005050 + (pt-1.000000)* 0.000033) + \
     (abs(eta) >= 0.2000 && abs(eta) < 0.4000) * (pt >= 10.0000 && pt < 100.0000) * (0.005343 + (pt-10.000000)* 0.000043) + \
     (abs(eta) >= 0.2000 && abs(eta) < 0.4000) * (pt >= 100.0000) * (0.009172*pt/100.000000) + \
     (abs(eta) >= 0.4000 && abs(eta) < 0.6000) * (pt >= 0.0000 && pt < 1.0000) * (0.00510573) + \
     (abs(eta) >= 0.4000 && abs(eta) < 0.6000) * (pt >= 1.0000 && pt < 10.0000) * (0.005106 + (pt-1.000000)* 0.000023) + \
     (abs(eta) >= 0.4000 && abs(eta) < 0.6000) * (pt >= 10.0000 && pt < 100.0000) * (0.005317 + (pt-10.000000)* 0.000042) + \
     (abs(eta) >= 0.4000 && abs(eta) < 0.6000) * (pt >= 100.0000) * (0.009077*pt/100.000000) + \
     (abs(eta) >= 0.6000 && abs(eta) < 0.8000) * (pt >= 0.0000 && pt < 1.0000) * (0.00578020) + \
     (abs(eta) >= 0.6000 && abs(eta) < 0.8000) * (pt >= 1.0000 && pt < 10.0000) * (0.005780 + (pt-1.000000)* -0.000000) + \
     (abs(eta) >= 0.6000 && abs(eta) < 0.8000) * (pt >= 10.0000 && pt < 100.0000) * (0.005779 + (pt-10.000000)* 0.000038) + \
     (abs(eta) >= 0.6000 && abs(eta) < 0.8000) * (pt >= 100.0000) * (0.009177*pt/100.000000) + \
     (abs(eta) >= 0.8000 && abs(eta) < 1.0000) * (pt >= 0.0000 && pt < 1.0000) * (0.00728723) + \
     (abs(eta) >= 0.8000 && abs(eta) < 1.0000) * (pt >= 1.0000 && pt < 10.0000) * (0.007287 + (pt-1.000000)* -0.000031) + \
     (abs(eta) >= 0.8000 && abs(eta) < 1.0000) * (pt >= 10.0000 && pt < 100.0000) * (0.007011 + (pt-10.000000)* 0.000038) + \
     (abs(eta) >= 0.8000 && abs(eta) < 1.0000) * (pt >= 100.0000) * (0.010429*pt/100.000000) + \
     (abs(eta) >= 1.0000 && abs(eta) < 1.2000) * (pt >= 0.0000 && pt < 1.0000) * (0.01045117) + \
     (abs(eta) >= 1.0000 && abs(eta) < 1.2000) * (pt >= 1.0000 && pt < 10.0000) * (0.010451 + (pt-1.000000)* -0.000051) + \
     (abs(eta) >= 1.0000 && abs(eta) < 1.2000) * (pt >= 10.0000 && pt < 100.0000) * (0.009989 + (pt-10.000000)* 0.000043) + \
     (abs(eta) >= 1.0000 && abs(eta) < 1.2000) * (pt >= 100.0000) * (0.013867*pt/100.000000) + \
     (abs(eta) >= 1.2000 && abs(eta) < 1.4000) * (pt >= 0.0000 && pt < 1.0000) * (0.01477199) + \
     (abs(eta) >= 1.2000 && abs(eta) < 1.4000) * (pt >= 1.0000 && pt < 10.0000) * (0.014772 + (pt-1.000000)* -0.000128) + \
     (abs(eta) >= 1.2000 && abs(eta) < 1.4000) * (pt >= 10.0000 && pt < 100.0000) * (0.013616 + (pt-10.000000)* 0.000035) + \
     (abs(eta) >= 1.2000 && abs(eta) < 1.4000) * (pt >= 100.0000) * (0.016800*pt/100.000000) + \
     (abs(eta) >= 1.4000 && abs(eta) < 1.6000) * (pt >= 0.0000 && pt < 1.0000) * (0.01731474) + \
     (abs(eta) >= 1.4000 && abs(eta) < 1.6000) * (pt >= 1.0000 && pt < 10.0000) * (0.017315 + (pt-1.000000)* -0.000208) + \
     (abs(eta) >= 1.4000 && abs(eta) < 1.6000) * (pt >= 10.0000 && pt < 100.0000) * (0.015439 + (pt-10.000000)* 0.000030) + \
     (abs(eta) >= 1.4000 && abs(eta) < 1.6000) * (pt >= 100.0000) * (0.018161*pt/100.000000) + \
     (abs(eta) >= 1.6000 && abs(eta) < 1.8000) * (pt >= 0.0000 && pt < 1.0000) * (0.01942025) + \
     (abs(eta) >= 1.6000 && abs(eta) < 1.8000) * (pt >= 1.0000 && pt < 10.0000) * (0.019420 + (pt-1.000000)* -0.000417) + \
     (abs(eta) >= 1.6000 && abs(eta) < 1.8000) * (pt >= 10.0000 && pt < 100.0000) * (0.015669 + (pt-10.000000)* 0.000026) + \
     (abs(eta) >= 1.6000 && abs(eta) < 1.8000) * (pt >= 100.0000) * (0.018039*pt/100.000000) + \
     (abs(eta) >= 1.8000 && abs(eta) < 2.0000) * (pt >= 0.0000 && pt < 1.0000) * (0.02201432) + \
     (abs(eta) >= 1.8000 && abs(eta) < 2.0000) * (pt >= 1.0000 && pt < 10.0000) * (0.022014 + (pt-1.000000)* -0.000667) + \
     (abs(eta) >= 1.8000 && abs(eta) < 2.0000) * (pt >= 10.0000 && pt < 100.0000) * (0.016012 + (pt-10.000000)* 0.000045) + \
     (abs(eta) >= 1.8000 && abs(eta) < 2.0000) * (pt >= 100.0000) * (0.020098*pt/100.000000) + \
     (abs(eta) >= 2.0000 && abs(eta) < 2.2000) * (pt >= 0.0000 && pt < 1.0000) * (0.02574300) + \
     (abs(eta) >= 2.0000 && abs(eta) < 2.2000) * (pt >= 1.0000 && pt < 10.0000) * (0.025743 + (pt-1.000000)* -0.001118) + \
     (abs(eta) >= 2.0000 && abs(eta) < 2.2000) * (pt >= 10.0000 && pt < 100.0000) * (0.015681 + (pt-10.000000)* 0.000051) + \
     (abs(eta) >= 2.0000 && abs(eta) < 2.2000) * (pt >= 100.0000) * (0.020289*pt/100.000000) + \
     (abs(eta) >= 2.2000 && abs(eta) < 2.4000) * (pt >= 0.0000 && pt < 1.0000) * (0.02885821) + \
     (abs(eta) >= 2.2000 && abs(eta) < 2.4000) * (pt >= 1.0000 && pt < 10.0000) * (0.028858 + (pt-1.000000)* -0.001345) + \
     (abs(eta) >= 2.2000 && abs(eta) < 2.4000) * (pt >= 10.0000 && pt < 100.0000) * (0.016753 + (pt-10.000000)* 0.000053) + \
     (abs(eta) >= 2.2000 && abs(eta) < 2.4000) * (pt >= 100.0000) * (0.021524*pt/100.000000) + \
     (abs(eta) >= 2.4000 && abs(eta) < 2.6000) * (pt >= 0.0000 && pt < 1.0000) * (0.03204812) + \
     (abs(eta) >= 2.4000 && abs(eta) < 2.6000) * (pt >= 1.0000 && pt < 10.0000) * (0.032048 + (pt-1.000000)* -0.001212) + \
     (abs(eta) >= 2.4000 && abs(eta) < 2.6000) * (pt >= 10.0000 && pt < 100.0000) * (0.021138 + (pt-10.000000)* 0.000037) + \
     (abs(eta) >= 2.4000 && abs(eta) < 2.6000) * (pt >= 100.0000) * (0.024477*pt/100.000000) + \
     (abs(eta) >= 2.6000 && abs(eta) < 2.8000) * (pt >= 0.0000 && pt < 1.0000) * (0.03950405) + \
     (abs(eta) >= 2.6000 && abs(eta) < 2.8000) * (pt >= 1.0000 && pt < 10.0000) * (0.039504 + (pt-1.000000)* -0.001386) + \
     (abs(eta) >= 2.6000 && abs(eta) < 2.8000) * (pt >= 10.0000 && pt < 100.0000) * (0.027026 + (pt-10.000000)* 0.000037) + \
     (abs(eta) >= 2.6000 && abs(eta) < 2.8000) * (pt >= 100.0000) * (0.030392*pt/100.000000) + \
     (abs(eta) >= 2.8000 && abs(eta) < 3.0000) * (pt >= 0.0000 && pt < 1.0000) * (0.04084751) + \
     (abs(eta) >= 2.8000 && abs(eta) < 3.0000) * (pt >= 1.0000 && pt < 10.0000) * (0.040848 + (pt-1.000000)* -0.001780) + \
     (abs(eta) >= 2.8000 && abs(eta) < 3.0000) * (pt >= 10.0000 && pt < 100.0000) * (0.024824 + (pt-10.000000)* 0.000029) + \
     (abs(eta) >= 2.8000 && abs(eta) < 3.0000) * (pt >= 100.0000) * (0.027445*pt/100.000000) + \
     (abs(eta) >= 3.0000 && abs(eta) < 3.2000) * (pt >= 0.0000 && pt < 1.0000) * (0.04532425) + \
     (abs(eta) >= 3.0000 && abs(eta) < 3.2000) * (pt >= 1.0000 && pt < 10.0000) * (0.045324 + (pt-1.000000)* -0.002497) + \
     (abs(eta) >= 3.0000 && abs(eta) < 3.2000) * (pt >= 10.0000 && pt < 100.0000) * (0.022851 + (pt-10.000000)* 0.000024) + \
     (abs(eta) >= 3.0000 && abs(eta) < 3.2000) * (pt >= 100.0000) * (0.025053*pt/100.000000) + \
     (abs(eta) >= 3.2000 && abs(eta) < 3.4000) * (pt >= 0.0000 && pt < 1.0000) * (0.06418925) + \
     (abs(eta) >= 3.2000 && abs(eta) < 3.4000) * (pt >= 1.0000 && pt < 10.0000) * (0.064189 + (pt-1.000000)* -0.004055) + \
     (abs(eta) >= 3.2000 && abs(eta) < 3.4000) * (pt >= 10.0000 && pt < 100.0000) * (0.027691 + (pt-10.000000)* 0.000034) + \
     (abs(eta) >= 3.2000 && abs(eta) < 3.4000) * (pt >= 100.0000) * (0.030710*pt/100.000000) + \
     (abs(eta) >= 3.4000 && abs(eta) < 3.6000) * (pt >= 0.0000 && pt < 1.0000) * (0.07682500) + \
     (abs(eta) >= 3.4000 && abs(eta) < 3.6000) * (pt >= 1.0000 && pt < 10.0000) * (0.076825 + (pt-1.000000)* -0.004510) + \
     (abs(eta) >= 3.4000 && abs(eta) < 3.6000) * (pt >= 10.0000 && pt < 100.0000) * (0.036234 + (pt-10.000000)* 0.000049) + \
     (abs(eta) >= 3.4000 && abs(eta) < 3.6000) * (pt >= 100.0000) * (0.040629*pt/100.000000) + \
     (abs(eta) >= 3.6000 && abs(eta) < 3.8000) * (pt >= 0.0000 && pt < 1.0000) * (0.09796358) + \
     (abs(eta) >= 3.6000 && abs(eta) < 3.8000) * (pt >= 1.0000 && pt < 10.0000) * (0.097964 + (pt-1.000000)* -0.005758) + \
     (abs(eta) >= 3.6000 && abs(eta) < 3.8000) * (pt >= 10.0000 && pt < 100.0000) * (0.046145 + (pt-10.000000)* 0.000069) + \
     (abs(eta) >= 3.6000 && abs(eta) < 3.8000) * (pt >= 100.0000) * (0.052345*pt/100.000000) + \
     (abs(eta) >= 3.8000 && abs(eta) < 4.0000) * (pt >= 0.0000 && pt < 1.0000) * (0.13415929) + \
     (abs(eta) >= 3.8000 && abs(eta) < 4.0000) * (pt >= 1.0000 && pt < 10.0000) * (0.134159 + (pt-1.000000)* -0.008283) + \
     (abs(eta) >= 3.8000 && abs(eta) < 4.0000) * (pt >= 10.0000 && pt < 100.0000) * (0.059612 + (pt-10.000000)* 0.000111) + \
     (abs(eta) >= 3.8000 && abs(eta) < 4.0000) * (pt >= 100.0000) * (0.069617*pt/100.000000)
  }


}


#################################
# Energy resolution for electrons
#################################

module EnergySmearing ElectronEnergySmearing {
  set InputArray ElectronTrackingEfficiency/electrons
  set OutputArray electrons

  # set ResolutionFormula {resolution formula as a function of eta and energy}

  # resolution formula for electrons

  # taking something flat in energy for now, ECAL will take over at high energy anyway.
  # inferred from hep-ex/1306.2016 and 1502.02701
  set ResolutionFormula {
                        (abs(eta) <= 5.0)  * (1e-10)
  }
}

###############################
# Momentum resolution for muons
###############################

module MomentumSmearing MuonMomentumSmearing {
  set InputArray MuonTrackingEfficiency/muons
  set OutputArray muons
  # resolution formula for muons

  # up to |eta| < 2.8 take measurement from tracking + muon chambers
  # for |eta| > 2.8 and pT < 5.0 take measurement from tracking alone taken from
  # http://mersi.web.cern.ch/mersi/layouts/.private/Baseline_tilted_200_Pixel_1_1_1/index.html
  source muonMomentumResolution.tcl
}



##############
# Track merger
##############

module Merger TrackMerger {
# add InputArray InputArray
  add InputArray ChargedHadronMomentumSmearing/chargedHadrons
  add InputArray ElectronEnergySmearing/electrons
  add InputArray MuonMomentumSmearing/muons
  set OutputArray tracks
}


#############
#   ECAL
#############

module SimpleCalorimeter ECal {
  set ParticleInputArray ParticlePropagator/stableParticles
  set TrackInputArray TrackMerger/tracks

  set TowerOutputArray ecalTowers
  set EFlowTrackOutputArray eflowTracks
  set EFlowTowerOutputArray eflowPhotons

  set IsEcal true

  set EnergyMin 0.5
  set EnergySignificanceMin 1.0

  set SmearTowerCenter true

  set pi [expr {acos(-1)}]

  # lists of the edges of each tower in eta and phi
  # each list starts with the lower edge of the first tower
  # the list ends with the higher edged of the last tower

  # assume 0.02 x 0.02 resolution in eta,phi in the barrel |eta| < 1.5

  set PhiBins {}
  for {set i -180} {$i <= 180} {incr i} {
    add PhiBins [expr {$i * $pi/180.0}]
  }

  # 0.02 unit in eta up to eta = 1.5 (barrel)
  for {set i -85} {$i <= 86} {incr i} {
    set eta [expr {$i * 0.0174}]
    add EtaPhiBins $eta $PhiBins
  }

  # assume 0.02 x 0.02 resolution in eta,phi in the endcaps 1.5 < |eta| < 3.0 (HGCAL- ECAL)

  set PhiBins {}
  for {set i -180} {$i <= 180} {incr i} {
    add PhiBins [expr {$i * $pi/180.0}]
  }

  # 0.02 unit in eta up to eta = 3
  for {set i 1} {$i <= 84} {incr i} {
    set eta [expr { -2.958 + $i * 0.0174}]
    add EtaPhiBins $eta $PhiBins
  }

  for {set i 1} {$i <= 84} {incr i} {
    set eta [expr { 1.4964 + $i * 0.0174}]
    add EtaPhiBins $eta $PhiBins
  }

  # take present CMS granularity for HF

  # 0.175 x (0.175 - 0.35) resolution in eta,phi in the HF 3.0 < |eta| < 5.0
  set PhiBins {}
  for {set i -18} {$i <= 18} {incr i} {
    add PhiBins [expr {$i * $pi/18.0}]
  }

  foreach eta {-5 -4.7 -4.525 -4.35 -4.175 -4 -3.825 -3.65 -3.475 -3.3 -3.125 -2.958 3.125 3.3 3.475 3.65 3.825 4 4.175 4.35 4.525 4.7 5} {
    add EtaPhiBins $eta $PhiBins
  }


  add EnergyFraction {0} {0.0}
  # energy fractions for e, gamma and pi0
  add EnergyFraction {11} {1.0}
  add EnergyFraction {22} {1.0}
  add EnergyFraction {111} {1.0}
  # energy fractions for muon, neutrinos and neutralinos
  add EnergyFraction {12} {0.0}
  add EnergyFraction {13} {0.0}
  add EnergyFraction {14} {0.0}
  add EnergyFraction {16} {0.0}
  add EnergyFraction {1000022} {0.0}
  add EnergyFraction {1000023} {0.0}
  add EnergyFraction {1000025} {0.0}
  add EnergyFraction {1000035} {0.0}
  add EnergyFraction {1000045} {0.0}
  # energy fractions for K0short and Lambda
  add EnergyFraction {310} {0.3}
  add EnergyFraction {3122} {0.3}

  # set ResolutionFormula {resolution formula as a function of eta and energy}

  # for the ECAL barrel (|eta| < 1.5), see hep-ex/1306.2016 and 1502.02701
  # for the endcaps (1.5 < |eta| < 3.0), we take HGCAL  see LHCC-P-008, Fig. 3.39, p.117

  ## add 0.5 factor now since this resolution seems to be worse than fullsim, will smear later to correct for
  set ResolutionFormula {  0.5*( 0.5*(abs(eta) <= 1.50)          * sqrt(energy^2*0.009^2 + energy*0.12^2 + 0.45^2) +
                           (abs(eta) > 1.50 && abs(eta) <= 1.75) * sqrt(energy^2*0.006^2 + energy*0.20^2) + \
                           (abs(eta) > 1.75 && abs(eta) <= 2.15) * sqrt(energy^2*0.007^2 + energy*0.21^2) + \
                           (abs(eta) > 2.15 && abs(eta) <= 3.00) * sqrt(energy^2*0.008^2 + energy*0.24^2) + \
                           (abs(eta) >= 3.0 && abs(eta) <= 5.0)  * sqrt(energy^2*0.08^2 + energy*1.98^2))}

}

#############
#   HCAL
#############

module SimpleCalorimeter HCal {
  set ParticleInputArray ParticlePropagator/stableParticles
  set TrackInputArray ECal/eflowTracks

  set TowerOutputArray hcalTowers
  set EFlowTrackOutputArray eflowTracks
  set EFlowTowerOutputArray eflowNeutralHadrons

  set IsEcal false

  set EnergyMin 1.0
  set EnergySignificanceMin 1.0

  set SmearTowerCenter true

  set pi [expr {acos(-1)}]

  # lists of the edges of each tower in eta and phi
  # each list starts with the lower edge of the first tower
  # the list ends with the higher edged of the last tower

  # assume 0.087 x 0.087 resolution in eta,phi in the barrel |eta| < 1.5

  set PhiBins {}
  for {set i -36} {$i <= 36} {incr i} {
    add PhiBins [expr {$i * $pi/36.0}]
  }
  foreach eta {-1.566 -1.479 -1.392 -1.305 -1.218 -1.131 -1.044 -0.957 -0.87 -0.783 -0.696 -0.609 -0.522 -0.435 -0.348 -0.261 -0.174 -0.087 0 0.087 0.174 0.261 0.348 0.435 0.522 0.609 0.696 0.783 0.87 0.957 1.044 1.131 1.218 1.305 1.392 1.479 1.566 1.65} {
    add EtaPhiBins $eta $PhiBins
  }

  # assume 0.07 x 0.07 resolution in eta,phi in the endcaps 1.5 < |eta| < 3.0 (HGCAL- HCAL)

  set PhiBins {}
  for {set i -45} {$i <= 45} {incr i} {
    add PhiBins [expr {$i * $pi/45.0}]
  }

  # 0.07 unit in eta up to eta = 3
  for {set i 1} {$i <= 21} {incr i} {
    set eta [expr { -2.958 + $i * 0.0696}]
    add EtaPhiBins $eta $PhiBins
  }

  for {set i 1} {$i <= 21} {incr i} {
    set eta [expr { 1.4964 + $i * 0.0696}]
    add EtaPhiBins $eta $PhiBins
  }

  # take present CMS granularity for HF

  # 0.175 x (0.175 - 0.35) resolution in eta,phi in the HF 3.0 < |eta| < 5.0
  set PhiBins {}
  for {set i -18} {$i <= 18} {incr i} {
    add PhiBins [expr {$i * $pi/18.0}]
  }

  foreach eta {-5 -4.7 -4.525 -4.35 -4.175 -4 -3.825 -3.65 -3.475 -3.3 -3.125 -2.958 3.125 3.3 3.475 3.65 3.825 4 4.175 4.35 4.525 4.7 5} {
    add EtaPhiBins $eta $PhiBins
  }


  # default energy fractions {abs(PDG code)} {Fecal Fhcal}
  add EnergyFraction {0} {1.0}
  # energy fractions for e, gamma and pi0
  add EnergyFraction {11} {0.0}
  add EnergyFraction {22} {0.0}
  add EnergyFraction {111} {0.0}
  # energy fractions for muon, neutrinos and neutralinos
  add EnergyFraction {12} {0.0}
  add EnergyFraction {13} {0.0}
  add EnergyFraction {14} {0.0}
  add EnergyFraction {16} {0.0}
  add EnergyFraction {1000022} {0.0}
  add EnergyFraction {1000023} {0.0}
  add EnergyFraction {1000025} {0.0}
  add EnergyFraction {1000035} {0.0}
  add EnergyFraction {1000045} {0.0}
  # energy fractions for K0short and Lambda
  add EnergyFraction {310} {0.7}
  add EnergyFraction {3122} {0.7}

# set ResolutionFormula {resolution formula as a function of eta and energy}
  set ResolutionFormula {                    (abs(eta) <= 1.5) * sqrt(energy^2*0.05^2 + energy*1.00^2) + \
                                                   (abs(eta) > 1.5 && abs(eta) <= 3.0) * sqrt(energy^2*0.05^2 + energy*1.00^2) + \
                                                   (abs(eta) > 3.0 && abs(eta) <= 5.0) * sqrt(energy^2*0.11^2 + energy*2.80^2)}

}

#################################
# Energy resolution for electrons
#################################

module EnergySmearing PhotonEnergySmearing {
  set InputArray ECal/eflowPhotons
  set OutputArray eflowPhotons

  # adding 1% extra photon smearing
  set ResolutionFormula {energy*0.001}

}



#################
# Electron filter
#################

module PdgCodeFilter ElectronFilter {
  set InputArray HCal/eflowTracks
  set OutputArray electrons
  set Invert true
  add PdgCode {11}
  add PdgCode {-11}
}



##########################
# Track pile-up subtractor
##########################

module TrackPileUpSubtractor TrackPileUpSubtractor {
# add InputArray InputArray OutputArray
  add InputArray HCal/eflowTracks eflowTracks
  add InputArray ElectronFilter/electrons electrons
  add InputArray MuonMomentumSmearing/muons muons

  set VertexInputArray PileUpMerger/vertices
  # assume perfect pile-up subtraction for tracks with |z| > fZVertexResolution
  # Z vertex resolution in m (naive guess from tkLayout, assumed flat in pt for now)
  
  set ZVertexResolution {
  
     (pt < 10. ) * ( ( -0.8*log10(pt) + 1. ) * (10^(0.5*abs(eta) + 1.5)) * 1e-06 ) +
     (pt >= 10. ) * ( ( 0.2 ) * (10^(0.5*abs(eta) + 1.5)) * 1e-06 )
     
     }
 }

########################
# Reco PU filter
########################

module RecoPuFilter RecoPuFilter {
  set InputArray HCal/eflowTracks
  set OutputArray eflowTracks
}

###################################################
# Tower Merger (in case not using e-flow algorithm)
###################################################

module Merger TowerMerger {
# add InputArray InputArray
  add InputArray ECal/ecalTowers
  add InputArray HCal/hcalTowers
  set OutputArray towers
}

####################
# Neutral eflow erger
####################

module Merger NeutralEFlowMerger {
# add InputArray InputArray
  add InputArray PhotonEnergySmearing/eflowPhotons
  add InputArray HCal/eflowNeutralHadrons
  set OutputArray eflowTowers
}

#####################
# Energy flow merger
#####################

module Merger EFlowMerger {
# add InputArray InputArray
  add InputArray HCal/eflowTracks
  add InputArray PhotonEnergySmearing/eflowPhotons
  add InputArray HCal/eflowNeutralHadrons
  set OutputArray eflow
}

############################
# Energy flow merger no PU
############################

module Merger EFlowMergerCHS {
# add InputArray InputArray
  add InputArray RecoPuFilter/eflowTracks
  add InputArray PhotonEnergySmearing/eflowPhotons
  add InputArray HCal/eflowNeutralHadrons
  set OutputArray eflow
}

#########################################
### Run the puppi code (to be tuned) ###
#########################################

module PdgCodeFilter LeptonFilterNoLep {
  set InputArray HCal/eflowTracks
  set OutputArray eflowTracksNoLeptons
  set Invert false
  add PdgCode {13}
  add PdgCode {-13}
  add PdgCode {11}
  add PdgCode {-11}
}

module PdgCodeFilter LeptonFilterLep {
  set InputArray HCal/eflowTracks
  set OutputArray eflowTracksLeptons
  set Invert true
  add PdgCode {11}
  add PdgCode {-11}
  add PdgCode {13}
  add PdgCode {-13}
}

module RunPUPPI RunPUPPIBase {
  ## input information
  set TrackInputArray   LeptonFilterNoLep/eflowTracksNoLeptons
  set NeutralInputArray NeutralEFlowMerger/eflowTowers
  set PVInputArray      PileUpMerger/vertices
  set MinPuppiWeight    0.05
  set UseExp            false
  set UseNoLep          false

  ## define puppi algorithm parameters (more than one for the same eta region is possible)
  add EtaMinBin           0.0   1.5   4.0
  add EtaMaxBin           1.5   4.0   10.0
  add PtMinBin            0.0   0.0   0.0
  add ConeSizeBin         0.2   0.2   0.2
  add RMSPtMinBin         0.1   0.5   0.5
  add RMSScaleFactorBin   1.0   1.0   1.0
  add NeutralMinEBin      0.2   0.2   0.5
  add NeutralPtSlope      0.006 0.013 0.067
  add ApplyCHS            true  true  true
  add UseCharged          true  true  false
  add ApplyLowPUCorr      true  true  true
  add MetricId            5     5     5
  add CombId              0     0     0

  ## output name
  set OutputArray         PuppiParticles
  set OutputArrayTracks   puppiTracks
  set OutputArrayNeutrals puppiNeutrals
}

module Merger RunPUPPIMerger {
  add InputArray RunPUPPIBase/PuppiParticles
  add InputArray LeptonFilterLep/eflowTracksLeptons
  set OutputArray PuppiParticles
}

# need this because of leptons that were added back
module RecoPuFilter RunPUPPI {
  set InputArray RunPUPPIMerger/PuppiParticles
  set OutputArray PuppiParticles
}

######################
# EFlowFilterPuppi
######################

module PdgCodeFilter EFlowFilterPuppi {
  set InputArray RunPUPPI/PuppiParticles
  set OutputArray eflow

  add PdgCode {11}
  add PdgCode {-11}
  add PdgCode {13}
  add PdgCode {-13}
}

######################
# EFlowFilterCHS
######################

module PdgCodeFilter EFlowFilterCHS {
  set InputArray EFlowMergerCHS/eflow
  set OutputArray eflow

  add PdgCode {11}
  add PdgCode {-11}
  add PdgCode {13}
  add PdgCode {-13}
}


###################
# Missing ET merger
###################

module Merger MissingET {
# add InputArray InputArray
#  add InputArray RunPUPPI/PuppiParticles
  add InputArray EFlowMerger/eflow
  set MomentumOutputArray momentum
}

module Merger PuppiMissingET {
  #add InputArray InputArray
  add InputArray RunPUPPI/PuppiParticles
  #add InputArray EFlowMerger/eflow
  set MomentumOutputArray momentum
  set UsePUPPI 0
}

#########################
# Ger PileUp Missing ET
#########################

module Merger GenPileUpMissingET {
# add InputArray InputArray
#  add InputArray RunPUPPI/PuppiParticles
  add InputArray ParticlePropagator/stableParticles
  set MomentumOutputArray momentum
}

##################
# Scalar HT merger
##################

module Merger ScalarHT {
# add InputArray InputArray
  add InputArray RunPUPPI/PuppiParticles
  set EnergyOutputArray energy
}

#################
# Neutrino Filter
#################

module PdgCodeFilter NeutrinoFilter {

  set InputArray Delphes/stableParticles
  set OutputArray filteredParticles

  set PTMin 0.0

  add PdgCode {12}
  add PdgCode {14}
  add PdgCode {16}
  add PdgCode {-12}
  add PdgCode {-14}
  add PdgCode {-16}

}

#####################
# MC truth jet finder
#####################

module FastJetFinder GenJetFinder {
  set InputArray NeutrinoFilter/filteredParticles

  set OutputArray jets

  # algorithm: 1 CDFJetClu, 2 MidPoint, 3 SIScone, 4 kt, 5 Cambridge/Aachen, 6 antikt
  set JetAlgorithm 6
  set ParameterR 0.4

  set JetPTMin 15.0
}

module FastJetFinder GenJetFinderAK8 {
  set InputArray NeutrinoFilter/filteredParticles

  set OutputArray jetsAK8

  # algorithm: 1 CDFJetClu, 2 MidPoint, 3 SIScone, 4 kt, 5 Cambridge/Aachen, 6 antikt
  set JetAlgorithm 6
  set ParameterR 0.8

  set JetPTMin 200.0
}

#########################
# Gen Missing ET merger
########################

module Merger GenMissingET {

# add InputArray InputArray
  add InputArray NeutrinoFilter/filteredParticles
  set MomentumOutputArray momentum
}


#############
# Rho pile-up
#############

module FastJetGridMedianEstimator Rho {

  set InputArray EFlowMergerCHS/eflow
  set RhoOutputArray rho

  # add GridRange rapmin rapmax drap dphi
  # rapmin - the minimum rapidity extent of the grid
  # rapmax - the maximum rapidity extent of the grid
  # drap - the grid spacing in rapidity
  # dphi - the grid spacing in azimuth

  add GridRange -5.0 -4.0 1.0 1.0
  add GridRange -4.0 -1.5 1.0 1.0
  add GridRange -1.5 1.5 1.0 1.0
  add GridRange 1.5 4.0 1.0 1.0
  add GridRange 4.0 5.0 1.0 1.0

}



module FastJetFinder FastJetFinderPUPPI {
#  set InputArray TowerMerger/towers
  set InputArray RunPUPPI/PuppiParticles

  set OutputArray jets

  # algorithm: 1 CDFJetClu, 2 MidPoint, 3 SIScone, 4 kt, 5 Cambridge/Aachen, 6 antikt
  set JetAlgorithm 6
  set ParameterR 0.4
  set UsePUPPI 0

  set JetPTMin 15.0
}


module FastJetFinder FastJetFinderPUPPIAK8 {
#  set InputArray TowerMerger/towers
  set InputArray RunPUPPI/PuppiParticles

  set OutputArray jets

  set JetAlgorithm 6
  set ParameterR 0.8

  set ComputeNsubjettiness 1
  set Beta 1.0
  set AxisMode 4

  set ComputeTrimming 1
  set RTrim 0.2
  set PtFracTrim 0.05

  set ComputePruning 1
  set ZcutPrun 0.1
  set RcutPrun 0.5
  set RPrun 0.8

  set ComputeSoftDrop 1
  set BetaSoftDrop 0.0
  set SymmetryCutSoftDrop 0.1
  set R0SoftDrop 0.8
  set UsePUPPI 0

  set JetPTMin 200.0
}

##################
# Jet Energy Scale
##################


module EnergyScale JetScalePUPPI {
  set InputArray FastJetFinderPUPPI/jets
  set OutputArray jets

 # scale formula for jets
    ### jetpuppi tightID momentum scale
  set ScaleFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 15.0 && pt <= 20.0) * (1.45) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.953) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 50.0) * (0.910) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 75.0) * (0.912) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 75.0 && pt <= 100.0) * (0.930) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 150.0) * (0.953) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 150.0 && pt <= 200.0) * (0.968) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (0.983) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 1000.0) * (0.988) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 1000.0 && pt <= 14000.0) * (0.992) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 15.0 && pt <= 20.0) * (1.200) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (1.103) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 50.0) * (1.037) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 75.0) * (1.007) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 75.0 && pt <= 100.0) * (1.002) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 150.0) * (1.005) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 150.0 && pt <= 200.0) * (1.004) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 500.0) * (1.003) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 1000.0) * (0.997) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 1000.0 && pt <= 14000.0) * (0.996) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 15.0 && pt <= 20.0) * (1.057) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.855) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 50.0) * (0.776) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 75.0) * (0.801) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 75.0 && pt <= 100.0) * (0.810) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 150.0) * (0.860) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 150.0 && pt <= 200.0) * (0.913) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 500.0) * (0.926) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 1000.0) * (0.963) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 1000.0 && pt <= 14000.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 15.0 && pt <= 20.0) * (1.971) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 30.0) * (1.465) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 30.0 && pt <= 50.0) * (1.213) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 75.0) * (1.054) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 75.0 && pt <= 100.0) * (0.986) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 150.0) * (0.957) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 150.0 && pt <= 200.0) * (1.010) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 500.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 1000.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 1000.0 && pt <= 14000.0) * (1.000)
  }

}
module EnergyScale JetScalePUPPIAK8 {
  set InputArray FastJetFinderPUPPIAK8/jets
  set OutputArray jets

 # scale formula for jets
  ## DUMMY_JETAK8_SCALE
  set ScaleFormula {1.00}
  ## ENDDUMMY_JETAK8_SCALE
}

####################
# Jet Energy Smear #
####################


module MomentumSmearing JetSmearPUPPI {
  set InputArray JetScalePUPPI/jets
  set OutputArray jets
  set UseMomentumVector true

 # scale formula for jets
   ### jetpuppi tightID momentum resolution
  set ResolutionFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 15.0 && pt <= 20.0) * (0.60) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.20) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 50.0) * (0.10) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 75.0) * (0.07) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 75.0 && pt <= 100.0) * (0.08) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 150.0) * (0.15) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 150.0 && pt <= 200.0) * (0.08) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (0.08) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 1000.0) * (0.065) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 1000.0 && pt <= 14000.0) * (0.04) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 15.0 && pt <= 20.0) * (0.70) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.70) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 50.0) * (0.35) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 75.0) * (0.27) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 75.0 && pt <= 100.0) * (0.30) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 150.0) * (0.28) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 150.0 && pt <= 200.0) * (0.22) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 500.0) * (0.16) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 1000.0) * (0.10) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 1000.0 && pt <= 14000.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 15.0 && pt <= 20.0) * (0.55) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.47) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 50.0) * (0.38) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 75.0) * (0.25) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 75.0 && pt <= 100.0) * (0.26) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 150.0) * (0.29) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 150.0 && pt <= 200.0) * (0.20) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 500.0) * (0.18) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 1000.0) * (0.11) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 1000.0 && pt <= 14000.0) * (0.05) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 15.0 && pt <= 20.0) * (0.50) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 30.0) * (0.25) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 30.0 && pt <= 50.0) * (0.19) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 75.0) * (0.19) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 75.0 && pt <= 100.0) * (0.08) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 150.0) * (0.04) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 150.0 && pt <= 200.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 500.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 1000.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 1000.0 && pt <= 14000.0) * (0.00)
  } 
}

module MomentumSmearing JetSmearPUPPIAK8 {
  set InputArray JetScalePUPPIAK8/jets
  set OutputArray jets
  set UseMomentumVector true

 ## DUMMY_JETPUPPIAK8_SMEAR
  set ResolutionFormula {1.00e-10}
 ## ENDDUMMY_JETPUPPIAK8_SMEAR
}



#####################
# Jet Id Loose     #
#####################

module Efficiency JetLooseID {

  ## input particles
  set InputArray JetSmearPUPPI/jets
  ## output particles
  set OutputArray jets
  # set EfficiencyFormula {efficiency formula as a function of eta and pt}
  # efficiency formula for jets

  set UseMomentumVector true

    ### jetpuppi loose ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 15.0 && pt <= 16.0) * (0.35) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 18.0) * (0.38) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 18.0 && pt <= 20.0) * (0.42) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 23.0) * (0.48) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 23.0 && pt <= 26.0) * (0.53) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 26.0 && pt <= 30.0) * (0.62) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 36.0) * (0.71) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 36.0 && pt <= 43.0) * (0.81) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 43.0 && pt <= 50.0) * (0.87) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 58.0) * (0.91) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 58.0 && pt <= 66.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 75.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 75.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 91.0) * (0.98) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 15.0 && pt <= 16.0) * (0.36) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 18.0) * (0.39) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 18.0 && pt <= 20.0) * (0.43) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 23.0) * (0.47) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 23.0 && pt <= 26.0) * (0.53) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 26.0 && pt <= 30.0) * (0.61) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 36.0) * (0.7) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 36.0 && pt <= 43.0) * (0.8) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 43.0 && pt <= 50.0) * (0.87) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 58.0) * (0.9) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 58.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 75.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 75.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 91.0) * (0.98) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 15.0 && pt <= 16.0) * (0.44) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 18.0) * (0.45) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 18.0 && pt <= 20.0) * (0.45) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 23.0) * (0.48) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 23.0 && pt <= 26.0) * (0.54) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 26.0 && pt <= 30.0) * (0.6) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 36.0) * (0.69) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 36.0 && pt <= 43.0) * (0.79) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 43.0 && pt <= 50.0) * (0.86) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 58.0) * (0.9) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 58.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 75.0) * (0.95) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 75.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 91.0) * (0.98) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 15.0 && pt <= 16.0) * (0.29) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 18.0) * (0.26) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 18.0 && pt <= 20.0) * (0.26) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 23.0) * (0.28) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 23.0 && pt <= 26.0) * (0.32) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 26.0 && pt <= 30.0) * (0.39) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 36.0) * (0.5) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 36.0 && pt <= 43.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 43.0 && pt <= 50.0) * (0.77) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 58.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 58.0 && pt <= 66.0) * (0.89) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 75.0) * (0.93) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 75.0 && pt <= 83.0) * (0.95) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 91.0) * (0.97) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 91.0 && pt <= 100.0) * (0.98) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 150.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 15.0 && pt <= 16.0) * (0.99) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 18.0) * (0.77) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 18.0 && pt <= 20.0) * (0.61) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 23.0) * (0.55) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 23.0 && pt <= 26.0) * (0.53) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 26.0 && pt <= 30.0) * (0.56) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 36.0) * (0.64) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 36.0 && pt <= 43.0) * (0.75) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 43.0 && pt <= 50.0) * (0.82) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 58.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 58.0 && pt <= 66.0) * (0.91) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 75.0) * (0.94) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 75.0 && pt <= 83.0) * (0.96) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 91.0) * (0.97) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 91.0 && pt <= 100.0) * (0.98) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 15.0 && pt <= 16.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 18.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 18.0 && pt <= 20.0) * (0.81) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 23.0) * (0.67) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 23.0 && pt <= 26.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 26.0 && pt <= 30.0) * (0.62) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 36.0) * (0.67) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 36.0 && pt <= 43.0) * (0.75) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 43.0 && pt <= 50.0) * (0.81) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 58.0) * (0.86) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 58.0 && pt <= 66.0) * (0.9) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 75.0) * (0.93) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 75.0 && pt <= 83.0) * (0.96) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 91.0) * (0.97) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 15.0 && pt <= 16.0) * (0.48) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 16.0 && pt <= 18.0) * (0.43) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 18.0 && pt <= 20.0) * (0.4) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 23.0) * (0.4) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 23.0 && pt <= 26.0) * (0.42) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 26.0 && pt <= 30.0) * (0.46) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 36.0) * (0.51) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 36.0 && pt <= 43.0) * (0.62) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 43.0 && pt <= 50.0) * (0.71) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 58.0) * (0.78) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 58.0 && pt <= 66.0) * (0.84) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 75.0) * (0.88) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 75.0 && pt <= 83.0) * (0.91) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 91.0) * (0.94) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 91.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 116.0) * (0.97) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 183.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 200.0 && pt <= 300.0) * (0.99) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 300.0 && pt <= 400.0) * (0.98) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 15.0 && pt <= 16.0) * (0.061) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 16.0 && pt <= 18.0) * (0.066) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 18.0 && pt <= 20.0) * (0.073) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 23.0) * (0.098) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 23.0 && pt <= 26.0) * (0.13) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 26.0 && pt <= 30.0) * (0.18) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 36.0) * (0.26) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 36.0 && pt <= 43.0) * (0.4) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 43.0 && pt <= 50.0) * (0.54) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 58.0) * (0.66) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 58.0 && pt <= 66.0) * (0.76) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 75.0) * (0.83) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 75.0 && pt <= 83.0) * (0.89) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 91.0) * (0.92) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 91.0 && pt <= 100.0) * (0.95) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 116.0) * (0.97) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 116.0 && pt <= 133.0) * (0.98) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 150.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 166.0 && pt <= 183.0) * (0.99) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 183.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 15.0 && pt <= 16.0) * (0.075) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 18.0) * (0.087) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 18.0 && pt <= 20.0) * (0.11) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 23.0) * (0.13) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 23.0 && pt <= 26.0) * (0.16) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 26.0 && pt <= 30.0) * (0.21) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 36.0) * (0.29) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 36.0 && pt <= 43.0) * (0.4) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 43.0 && pt <= 50.0) * (0.53) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 58.0) * (0.64) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 58.0 && pt <= 66.0) * (0.76) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 75.0) * (0.82) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 75.0 && pt <= 83.0) * (0.9) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 91.0) * (0.94) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 91.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 116.0) * (0.98) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 183.0 && pt <= 200.0) * (0.92) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 15.0 && pt <= 16.0) * (0.33) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 16.0 && pt <= 18.0) * (0.41) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 18.0 && pt <= 20.0) * (0.55) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 20.0 && pt <= 23.0) * (0.55) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 23.0 && pt <= 26.0) * (0.58) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 26.0 && pt <= 30.0) * (0.65) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 30.0 && pt <= 36.0) * (0.67) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 36.0 && pt <= 43.0) * (0.65) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 43.0 && pt <= 50.0) * (0.66) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 50.0 && pt <= 58.0) * (0.69) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 58.0 && pt <= 66.0) * (0.77) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 66.0 && pt <= 75.0) * (0.84) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 75.0 && pt <= 83.0) * (0.87) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 83.0 && pt <= 91.0) * (0.9) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 91.0 && pt <= 100.0) * (0.86) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 100.0 && pt <= 116.0) * (0.97) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 116.0 && pt <= 133.0) * (0.94) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 15.0 && pt <= 16.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 16.0 && pt <= 18.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 18.0 && pt <= 20.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 20.0 && pt <= 23.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 23.0 && pt <= 26.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 26.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 30.0 && pt <= 36.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 36.0 && pt <= 43.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 43.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 50.0 && pt <= 58.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 58.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 66.0 && pt <= 75.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 75.0 && pt <= 83.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 83.0 && pt <= 91.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 91.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 100.0 && pt <= 116.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 15.0 && pt <= 16.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 16.0 && pt <= 18.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 18.0 && pt <= 20.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 23.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 23.0 && pt <= 26.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 26.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 30.0 && pt <= 36.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 36.0 && pt <= 43.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 43.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 58.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 58.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 66.0 && pt <= 75.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 75.0 && pt <= 83.0) * (0.98) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 83.0 && pt <= 91.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 91.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 116.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 5.0 && abs(eta) <= 100000.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 15.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 16.0 && pt <= 18.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 18.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 20.0 && pt <= 23.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 23.0 && pt <= 26.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 26.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 30.0 && pt <= 36.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 36.0 && pt <= 43.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 43.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 50.0 && pt <= 58.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 58.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 66.0 && pt <= 75.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 75.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 83.0 && pt <= 91.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 91.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 100.0 && pt <= 116.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 116.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 133.0 && pt <= 150.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 150.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 166.0 && pt <= 183.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 183.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 500.0 && pt <= 666.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 666.0 && pt <= 833.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 833.0 && pt <= 1000.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 1000.0) * (0.0)  
  }

}



#####################
# Jet Id Tight      #
#####################

module Efficiency JetTightID {

  ## input particles
  set InputArray JetSmearPUPPI/jets
  ## output particles
  set OutputArray jets
  # set EfficiencyFormula {efficiency formula as a function of eta and pt}
  # efficiency formula for jets

  set UseMomentumVector true

    ### jetpuppi tight ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 15.0 && pt <= 16.0) * (0.35) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 18.0) * (0.38) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 18.0 && pt <= 20.0) * (0.42) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 23.0) * (0.48) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 23.0 && pt <= 26.0) * (0.53) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 26.0 && pt <= 30.0) * (0.62) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 36.0) * (0.71) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 36.0 && pt <= 43.0) * (0.81) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 43.0 && pt <= 50.0) * (0.87) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 58.0) * (0.91) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 58.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 75.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 75.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 91.0) * (0.98) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 15.0 && pt <= 16.0) * (0.36) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 18.0) * (0.39) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 18.0 && pt <= 20.0) * (0.43) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 23.0) * (0.47) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 23.0 && pt <= 26.0) * (0.53) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 26.0 && pt <= 30.0) * (0.61) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 36.0) * (0.7) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 36.0 && pt <= 43.0) * (0.8) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 43.0 && pt <= 50.0) * (0.87) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 58.0) * (0.9) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 58.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 75.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 75.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 91.0) * (0.98) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 150.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 15.0 && pt <= 16.0) * (0.44) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 18.0) * (0.45) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 18.0 && pt <= 20.0) * (0.45) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 23.0) * (0.48) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 23.0 && pt <= 26.0) * (0.54) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 26.0 && pt <= 30.0) * (0.6) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 36.0) * (0.69) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 36.0 && pt <= 43.0) * (0.79) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 43.0 && pt <= 50.0) * (0.85) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 58.0) * (0.9) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 58.0 && pt <= 66.0) * (0.92) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 75.0) * (0.95) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 75.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 91.0) * (0.98) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 15.0 && pt <= 16.0) * (0.29) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 18.0) * (0.26) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 18.0 && pt <= 20.0) * (0.26) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 23.0) * (0.28) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 23.0 && pt <= 26.0) * (0.32) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 26.0 && pt <= 30.0) * (0.39) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 36.0) * (0.5) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 36.0 && pt <= 43.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 43.0 && pt <= 50.0) * (0.76) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 58.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 58.0 && pt <= 66.0) * (0.89) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 75.0) * (0.93) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 75.0 && pt <= 83.0) * (0.95) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 91.0) * (0.96) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 91.0 && pt <= 100.0) * (0.98) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 150.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 183.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 15.0 && pt <= 16.0) * (0.99) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 18.0) * (0.76) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 18.0 && pt <= 20.0) * (0.61) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 23.0) * (0.55) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 23.0 && pt <= 26.0) * (0.53) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 26.0 && pt <= 30.0) * (0.56) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 36.0) * (0.64) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 36.0 && pt <= 43.0) * (0.75) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 43.0 && pt <= 50.0) * (0.82) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 58.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 58.0 && pt <= 66.0) * (0.91) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 75.0) * (0.93) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 75.0 && pt <= 83.0) * (0.95) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 91.0) * (0.97) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 91.0 && pt <= 100.0) * (0.98) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 150.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 15.0 && pt <= 16.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 18.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 18.0 && pt <= 20.0) * (0.81) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 23.0) * (0.67) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 23.0 && pt <= 26.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 26.0 && pt <= 30.0) * (0.62) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 36.0) * (0.67) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 36.0 && pt <= 43.0) * (0.75) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 43.0 && pt <= 50.0) * (0.81) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 58.0) * (0.86) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 58.0 && pt <= 66.0) * (0.89) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 75.0) * (0.93) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 75.0 && pt <= 83.0) * (0.96) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 91.0) * (0.97) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 91.0 && pt <= 100.0) * (0.98) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 150.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 15.0 && pt <= 16.0) * (0.48) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 16.0 && pt <= 18.0) * (0.43) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 18.0 && pt <= 20.0) * (0.4) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 23.0) * (0.4) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 23.0 && pt <= 26.0) * (0.42) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 26.0 && pt <= 30.0) * (0.45) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 36.0) * (0.51) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 36.0 && pt <= 43.0) * (0.62) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 43.0 && pt <= 50.0) * (0.71) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 58.0) * (0.77) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 58.0 && pt <= 66.0) * (0.84) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 75.0) * (0.88) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 75.0 && pt <= 83.0) * (0.91) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 91.0) * (0.94) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 91.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 116.0) * (0.97) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 166.0 && pt <= 183.0) * (0.99) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 183.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 200.0 && pt <= 300.0) * (0.99) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 300.0 && pt <= 400.0) * (0.98) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 15.0 && pt <= 16.0) * (0.06) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 16.0 && pt <= 18.0) * (0.065) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 18.0 && pt <= 20.0) * (0.073) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 23.0) * (0.096) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 23.0 && pt <= 26.0) * (0.13) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 26.0 && pt <= 30.0) * (0.18) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 36.0) * (0.26) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 36.0 && pt <= 43.0) * (0.39) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 43.0 && pt <= 50.0) * (0.52) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 58.0) * (0.65) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 58.0 && pt <= 66.0) * (0.75) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 75.0) * (0.82) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 75.0 && pt <= 83.0) * (0.88) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 91.0) * (0.91) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 91.0 && pt <= 100.0) * (0.94) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 116.0) * (0.96) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 116.0 && pt <= 133.0) * (0.97) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 150.0 && pt <= 166.0) * (0.98) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 166.0 && pt <= 183.0) * (0.99) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 183.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 15.0 && pt <= 16.0) * (0.073) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 18.0) * (0.085) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 18.0 && pt <= 20.0) * (0.11) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 23.0) * (0.12) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 23.0 && pt <= 26.0) * (0.15) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 26.0 && pt <= 30.0) * (0.2) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 36.0) * (0.27) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 36.0 && pt <= 43.0) * (0.38) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 43.0 && pt <= 50.0) * (0.5) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 58.0) * (0.62) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 58.0 && pt <= 66.0) * (0.72) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 75.0) * (0.79) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 75.0 && pt <= 83.0) * (0.89) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 91.0) * (0.93) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 116.0) * (0.97) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 183.0 && pt <= 200.0) * (0.92) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 15.0 && pt <= 16.0) * (0.32) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 16.0 && pt <= 18.0) * (0.41) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 18.0 && pt <= 20.0) * (0.54) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 20.0 && pt <= 23.0) * (0.54) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 23.0 && pt <= 26.0) * (0.57) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 26.0 && pt <= 30.0) * (0.63) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 30.0 && pt <= 36.0) * (0.66) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 36.0 && pt <= 43.0) * (0.64) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 43.0 && pt <= 50.0) * (0.64) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 50.0 && pt <= 58.0) * (0.67) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 58.0 && pt <= 66.0) * (0.74) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 66.0 && pt <= 75.0) * (0.82) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 75.0 && pt <= 83.0) * (0.84) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 83.0 && pt <= 91.0) * (0.87) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 91.0 && pt <= 100.0) * (0.85) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 100.0 && pt <= 116.0) * (0.96) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 116.0 && pt <= 133.0) * (0.94) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 15.0 && pt <= 16.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 16.0 && pt <= 18.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 18.0 && pt <= 20.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 20.0 && pt <= 23.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 23.0 && pt <= 26.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 26.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 30.0 && pt <= 36.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 36.0 && pt <= 43.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 43.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 50.0 && pt <= 58.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 58.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 66.0 && pt <= 75.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 75.0 && pt <= 83.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 83.0 && pt <= 91.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 91.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 100.0 && pt <= 116.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 15.0 && pt <= 16.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 16.0 && pt <= 18.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 18.0 && pt <= 20.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 23.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 23.0 && pt <= 26.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 26.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 30.0 && pt <= 36.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 36.0 && pt <= 43.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 43.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 58.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 58.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 66.0 && pt <= 75.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 75.0 && pt <= 83.0) * (0.98) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 83.0 && pt <= 91.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 91.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 116.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 5.0 && abs(eta) <= 100000.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 15.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 16.0 && pt <= 18.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 18.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 20.0 && pt <= 23.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 23.0 && pt <= 26.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 26.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 30.0 && pt <= 36.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 36.0 && pt <= 43.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 43.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 50.0 && pt <= 58.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 58.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 66.0 && pt <= 75.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 75.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 83.0 && pt <= 91.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 91.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 100.0 && pt <= 116.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 116.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 133.0 && pt <= 150.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 150.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 166.0 && pt <= 183.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 183.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 500.0 && pt <= 666.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 666.0 && pt <= 833.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 833.0 && pt <= 1000.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 1000.0) * (0.0)  
  }

}




#################
# Photon filter
#################

module PdgCodeFilter PhotonFilter {
  set InputArray PhotonEnergySmearing/eflowPhotons
  set OutputArray photons
  set Invert true
  set PTMin 5.0
  add PdgCode {22}
}



####################
# Photon isolation #
####################

module Isolation PhotonIsolation {

  # particle for which calculate the isolation
  set CandidateInputArray PhotonFilter/photons

  # isolation collection
  set IsolationInputArray EFlowFilterPuppi/eflow

  # output array
  set OutputArray photons

  # veto isolation cand. based on proximity to input cand.
  set DeltaRMin 0.01
  set UseMiniCone true

  # isolation cone
  set DeltaRMax 0.3

  # minimum pT
  set PTMin     0.0

  # iso ratio to cut
  set PTRatioMax 9999.

}

##################
# Photon scale #
##################


module EnergyScale PhotonScale {
  set InputArray PhotonIsolation/photons
  set OutputArray photons

    ### photon looseIDISO momentum scale
  set ScaleFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 10.0) * (1.002) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 20.0) * (1.001) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 50.0) * (1.001) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (0.999) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 14000.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 10.0) * (0.998) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 20.0) * (1.001) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 50.0) * (1.001) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 500.0) * (0.999) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 14000.0) * (1.278) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 10.0) * (0.843) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 20.0) * (0.908) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 50.0) * (0.975) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 100.0) * (0.971) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 200.0) * (0.992) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 500.0) * (0.860) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 14000.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 4.0 && pt <= 10.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 10.0 && pt <= 20.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 50.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 500.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 14000.0) * (1.000)  
  }

}


##################
# Photon smear #
##################

module MomentumSmearing PhotonSmear {

  set InputArray PhotonScale/photons
  set OutputArray photons
  set UseMomentumVector true

    ### photon looseIDISO momentum resolution
  set ResolutionFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 10.0) * (0.01) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 20.0) * (0.01) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 50.0) * (0.01) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (0.00) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 14000.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 10.0) * (0.07) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 20.0) * (0.07) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 50.0) * (0.03) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 100.0) * (0.02) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 200.0) * (0.00) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 500.0) * (0.00) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 14000.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 10.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 20.0) * (0.03) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 50.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 100.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 200.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 500.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 14000.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 4.0 && pt <= 10.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 10.0 && pt <= 20.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 50.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 100.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 200.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 500.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 14000.0) * (0.00)  
  }

}




#####################
# Photon Id Loose   #
#####################

module Efficiency PhotonLooseID {

  ## input particles
  set InputArray PhotonSmear/photons
  ## output particles
  set OutputArray photons
  # set EfficiencyFormula {efficiency formula as a function of eta and pt}
  # efficiency formula for photons

  set UseMomentumVector true

    ### photon loose ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.07) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.35) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.56) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.76) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.87) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.89) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.9) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.91) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.92) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.9) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.91) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.91) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.91) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.89) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.88) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.81) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.094) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.42) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.56) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.77) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.88) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.9) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.91) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.9) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.91) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.9) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.91) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.92) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.92) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.91) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.91) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.9) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.16) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.31) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.53) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.73) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.81) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.82) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.84) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.84) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.85) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.85) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.86) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.87) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.83) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.85) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.8) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.25) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.55) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.6) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.58) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.64) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.8) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.81) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.81) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.82) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.82) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.83) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.82) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.83) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0) * (0.83) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.013) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.23) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.67) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.7) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.83) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.93) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.94) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.95) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.95) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.95) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0) * (0.95) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.088) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.39) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.54) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.59) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.78) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.85) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.91) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.95) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.96) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.96) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.95) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.97) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.019) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.024) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.084) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.17) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.21) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.29) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.3) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.41) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.44) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.48) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.56) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.67) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.52) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

}


#####################
# Photon Id Medium   #
#####################

module Efficiency PhotonMediumID {

  ## input particles
  set InputArray PhotonSmear/photons
  ## output particles
  set OutputArray photons
  # set EfficiencyFormula {efficiency formula as a function of eta and pt}
  # efficiency formula for photons
  set UseMomentumVector true

    ### photon medium ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0066) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.093) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.3) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.56) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.75) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.81) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.82) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.82) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.83) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.81) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.81) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.81) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.82) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.78) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.75) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.71) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.017) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.13) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.33) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.61) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.78) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.8) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.8) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.8) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.82) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.81) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.81) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.83) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.84) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.81) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.8) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.82) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0063) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.1) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.33) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.57) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.67) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.67) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.7) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.7) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.73) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.72) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.72) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.76) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.76) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.73) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.79) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.59) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.2) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.44) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.47) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.42) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.5) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.68) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.69) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.71) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.72) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.72) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.72) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.72) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.72) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.722) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.72) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.72) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.72) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.013) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.16) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.54) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.62) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.67) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.76) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.84) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.89) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.89) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.89) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.91) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.9) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.068) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.31) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.47) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.53) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.7) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.79) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.86) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.9) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.91) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.93) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.92) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.86) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.89) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.9) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.9) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.9) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.9) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.012) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.086) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.16) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.2) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.27) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.3) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.41) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.43) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.48) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.56) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.66) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.53) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

}


#####################
# Photon Id Tight   #
#####################

module Efficiency PhotonTightID {

  ## input particles
  set InputArray PhotonSmear/photons
  ## output particles
  set OutputArray photons
  # set EfficiencyFormula {efficiency formula as a function of eta and pt}
  # efficiency formula for photons
  set UseMomentumVector true

  ### photon tight ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.012) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.095) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.34) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.61) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.71) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.71) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.7) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.72) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.72) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.72) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.72) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.722) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.72) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.722) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.72) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.028) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.1) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.43) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.66) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.68) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.69) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.68) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.69) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.68) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.67) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.68) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.69) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.69) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.69) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.69) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0089) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.14) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.4) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.51) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.51) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.54) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.52) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.56) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.54) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.53) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.55) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.54) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.52) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.57) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.57) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.14) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.3) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.34) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.32) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.35) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.63) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.64) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.64) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.64) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.64) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.65) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.12) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.5) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.55) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.61) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.72) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.82) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.85) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.85) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.84) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.038) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.26) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.46) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.48) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.65) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.81) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.86) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.88) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.88) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.88) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.88) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.88) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.88) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.88) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.88) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.014) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.079) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.14) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.21) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.29) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.31) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.43) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.45) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.48) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.56) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.63) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.63) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.63) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.63) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.63) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.63) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (0.63) +
   (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
}




######################
# Electron isolation #
######################

module Isolation ElectronIsolation {

  set CandidateInputArray ElectronFilter/electrons

  # isolation collection
  set IsolationInputArray EFlowFilterPuppi/eflow

  set OutputArray electrons

  set DeltaRMax 0.3
  set PTMin 0.0
  set PTRatioMax 9999.

}


##################
# Electron scale #
##################


module EnergyScale ElectronScale {
  set InputArray ElectronIsolation/electrons
  set OutputArray electrons

    ### electron looseIDISO momentum scale
  set ScaleFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 10.0) * (1.00) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 20.0) * (1.00) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 50.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 14000.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 10.0) * (1.00) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 20.0) * (1.00) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 50.0) * (1.00) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 500.0) * (1.00) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 14000.0) * (1.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 10.0) * (1.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 20.0) * (1.000) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 50.0) * (1.000) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 500.0) * (1.000) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 14000.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 4.0 && pt <= 10.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 10.0 && pt <= 20.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 50.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 500.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 14000.0) * (1.000)  
  }

}

##################
# Electron smear #
##################

module MomentumSmearing ElectronSmear {

  set InputArray ElectronScale/electrons
  set OutputArray electrons
  set UseMomentumVector true

    ### electron looseIDISO momentum resolution
  set ResolutionFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 10.0) * (0.03) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 20.0) * (0.03) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 50.0) * (0.028) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 100.0) * (0.021) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 200.0) * (0.014) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (0.01) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 14000.0) * (0.01) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 10.0) * (0.09) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 20.0) * (0.09) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 50.0) * (0.05) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 100.0) * (0.035) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 200.0) * (0.021) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 500.0) * (0.02) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 14000.0) * (0.02) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 10.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 20.0) * (0.04) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 50.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 100.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 200.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 14000.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 4.0 && pt <= 10.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 10.0 && pt <= 20.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 50.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 100.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 200.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 500.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 14000.0) * (0.00)  
  }

}



#######################
# Electron loose ID efficiency #
#######################

module Efficiency ElectronLooseEfficiency {

  set InputArray ElectronSmear/electrons
  set OutputArray electrons
  set UseMomentumVector true

    ### electron loose ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0059) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0079) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.039) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.38) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.54) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.71) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.86) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.93) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.98) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.98) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.98) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0029) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0054) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.032) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.37) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.55) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.69) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.84) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.98) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0034) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0097) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.042) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.26) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.41) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.5) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.71) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.82) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.85) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.85) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.89) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.84) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.87) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.89) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.9) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.92) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.9) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.91) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.01) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.02) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.1) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.37) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.49) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.58) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.66) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.78) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.8) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.85) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.83) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.83) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.84) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.038) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.04) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.2) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.59) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.7) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.72) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.8) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.9) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.042) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.07) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.13) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.39) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.49) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.6) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.69) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.8) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.85) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.87) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.015) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.017) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.061) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.061) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.1) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.12) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.15) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.18) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.18) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.2) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.22) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.17) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.22) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.29) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.3) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.43) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.35) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.44) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }


}

#######################
# Electron medium ID efficiency #
#######################

module Efficiency ElectronMediumEfficiency {

  set InputArray ElectronSmear/electrons
  set OutputArray electrons
  set UseMomentumVector true

    ### electron medium ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0031) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.019) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.26) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.4) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.58) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.77) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.88) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.93) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.95) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.95) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0031) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.017) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.25) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.37) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.55) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.72) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.86) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.91) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.92) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.96) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0036) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0033) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.026) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.17) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.28) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.41) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.61) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.75) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.8) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.81) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.86) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.85) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.83) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.86) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.87) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.89) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.89) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.007) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.044) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.16) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.28) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.29) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.4) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.63) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.7) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.75) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.75) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.74) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.76) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.76) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.76) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.76) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.76) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.76) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.041) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.024) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.026) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.15) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.42) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.57) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.58) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.69) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.81) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.8) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.81) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.78) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.021) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.047) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.074) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.29) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.39) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.5) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.58) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.69) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.74) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.016) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.017) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.046) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.055) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.097) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.11) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.15) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.18) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.18) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.19) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.21) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.16) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.21) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.28) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.3) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.39) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.31) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.22) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
}

#######################
# Electron tight ID efficiency #
#######################

module Efficiency ElectronTightEfficiency {

  set InputArray ElectronSmear/electrons
  set OutputArray electrons
  set UseMomentumVector true

    ### electron tight ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0057) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.1) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.2) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.39) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.65) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.81) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.88) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.91) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.93) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.92) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.93) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.009) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.12) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.22) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.39) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.6) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.79) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.85) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.88) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.89) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.94) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.92) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.95) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0084) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.096) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.18) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.31) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.53) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.69) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.73) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.78) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.81) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.84) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.8) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.84) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.86) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.87) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.87) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.89) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0038) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.02) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.067) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.1) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.14) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.21) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.42) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.53) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.59) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.61) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0096) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.024) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.097) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.3) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.45) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.45) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.59) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.71) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.75) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.72) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0059) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.029) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.042) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.21) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.31) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.41) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.5) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.59) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.63) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.019) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.016) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.041) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.049) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.098) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.11) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.15) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.18) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.17) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.18) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.19) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.17) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.19) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.26) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.28) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.34) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.17) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.22) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
}



##################
# Muon isolation #
##################

module Isolation MuonIsolation {
  set CandidateInputArray MuonMomentumSmearing/muons

  # isolation collection
  set IsolationInputArray EFlowFilterPuppi/eflow

  set OutputArray muons

  set DeltaRMax 0.3
  set PTMin 0.0
  set PTRatioMax 9999.

}


##############
# Muon scale #
##############


module EnergyScale MuonScale {
  set InputArray MuonIsolation/muons
  set OutputArray muons

    ### muon looseIDISO momentum scale
  set ScaleFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 50.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 14000.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 50.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 200.0) * (1.001) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 500.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 500.0 && pt <= 14000.0) * (1.000)  
  }

}


##############
# Muon smear #
##############

module MomentumSmearing MuonSmear {

  set InputArray MuonScale/muons
  set OutputArray muons
  set UseMomentumVector true

    ### muon looseIDISO momentum resolution
  set ResolutionFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 50.0) * (0.005) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 100.0) * (0.005) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 200.0) * (0.013) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (0.025) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 14000.0) * (0.055) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 50.0) * (0.00) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 100.0) * (0.00) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 200.0) * (0.022) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 500.0) * (0.04) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 500.0 && pt <= 14000.0) * (0.08)  
  }
}




##################
# Muon Loose Id  #
##################

module Efficiency MuonLooseIdEfficiency {
    set InputArray MuonSmear/muons
    set OutputArray muons
    set UseMomentumVector true
    
      ### muon loose ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.8) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.9) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.81) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.9) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.78) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.96) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.96) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.98) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.97) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 4.0 && pt <= 6.0) * (0.7) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 6.0 && pt <= 8.0) * (0.85) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 8.0 && pt <= 10.0) * (0.92) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 10.0 && pt <= 13.0) * (0.93) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 13.0 && pt <= 16.0) * (0.97) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 16.0 && pt <= 20.0) * (0.98) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 20.0 && pt <= 30.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 30.0 && pt <= 40.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 40.0 && pt <= 50.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 50.0 && pt <= 66.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 83.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 100.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 133.0 && pt <= 166.0) * (0.98) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 200.0 && pt <= 300.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 300.0 && pt <= 400.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 400.0 && pt <= 500.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 500.0) * (0.94) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 4.0 && pt <= 6.0) * (0.83) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 6.0 && pt <= 8.0) * (0.89) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 8.0 && pt <= 10.0) * (0.92) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 10.0 && pt <= 13.0) * (0.96) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 13.0 && pt <= 16.0) * (0.97) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 16.0 && pt <= 20.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 20.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 30.0 && pt <= 40.0) * (1.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 40.0 && pt <= 50.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 50.0 && pt <= 66.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 100.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 133.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 200.0 && pt <= 300.0) * (0.98) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 300.0 && pt <= 400.0) * (0.98) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 400.0 && pt <= 500.0) * (0.96) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 500.0) * (0.9) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 4.0 && pt <= 6.0) * (0.77) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 6.0 && pt <= 8.0) * (0.87) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 8.0 && pt <= 10.0) * (0.94) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 10.0 && pt <= 13.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 13.0 && pt <= 16.0) * (0.98) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 16.0 && pt <= 20.0) * (0.98) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 30.0 && pt <= 40.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 40.0 && pt <= 50.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 66.0 && pt <= 83.0) * (1.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 133.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 166.0 && pt <= 200.0) * (0.97) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 300.0) * (0.98) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 300.0 && pt <= 400.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 400.0 && pt <= 500.0) * (0.94) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 500.0) * (0.95) +
   (abs(eta) > 2.8 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 500.0) * (0.0)  
  }
}

##################
# Muon Medium Id  #
##################

##FIXME!!! sourcing LooseId tcl file because medium does not exists (yet ...)
module Efficiency MuonMediumIdEfficiency {
    set InputArray MuonSmear/muons
    set OutputArray muons
    set UseMomentumVector true

      ### muon medium ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.69) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.8) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.85) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.69) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.75) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.85) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.94) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.98) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.68) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.79) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.83) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.93) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.96) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.98) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.97) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 4.0 && pt <= 6.0) * (0.62) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 6.0 && pt <= 8.0) * (0.71) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 8.0 && pt <= 10.0) * (0.86) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 10.0 && pt <= 13.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 13.0 && pt <= 16.0) * (0.91) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 16.0 && pt <= 20.0) * (0.94) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 20.0 && pt <= 30.0) * (0.97) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 30.0 && pt <= 40.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 40.0 && pt <= 50.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 50.0 && pt <= 66.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 83.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 100.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 133.0 && pt <= 166.0) * (0.98) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 200.0 && pt <= 300.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 300.0 && pt <= 400.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 400.0 && pt <= 500.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 500.0) * (0.94) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 4.0 && pt <= 6.0) * (0.69) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 6.0 && pt <= 8.0) * (0.79) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 8.0 && pt <= 10.0) * (0.86) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 10.0 && pt <= 13.0) * (0.87) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 13.0 && pt <= 16.0) * (0.93) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 16.0 && pt <= 20.0) * (0.97) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 20.0 && pt <= 30.0) * (0.98) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 30.0 && pt <= 40.0) * (1.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 40.0 && pt <= 50.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 50.0 && pt <= 66.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 100.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 133.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 200.0 && pt <= 300.0) * (0.98) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 300.0 && pt <= 400.0) * (0.97) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 400.0 && pt <= 500.0) * (0.96) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 500.0) * (0.9) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 4.0 && pt <= 6.0) * (0.65) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 6.0 && pt <= 8.0) * (0.75) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 8.0 && pt <= 10.0) * (0.81) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 10.0 && pt <= 13.0) * (0.94) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 13.0 && pt <= 16.0) * (0.93) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 16.0 && pt <= 20.0) * (0.95) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 30.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 30.0 && pt <= 40.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 40.0 && pt <= 50.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 133.0) * (0.98) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 133.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 166.0 && pt <= 200.0) * (0.97) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 300.0) * (0.98) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 300.0 && pt <= 400.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 400.0 && pt <= 500.0) * (0.94) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 500.0) * (0.94) +
   (abs(eta) > 2.8 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 500.0) * (0.0)  
  }
}

##################
# Muon Tight Id  #
##################

module Efficiency MuonTightIdEfficiency {
    set InputArray MuonSmear/muons
    set OutputArray muons
    set UseMomentumVector true

      ### muon tight ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.13) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.24) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.24) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.29) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.4) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.55) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.76) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.89) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.92) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.95) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.95) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.95) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.92) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.15) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.17) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.22) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.29) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.37) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.57) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.77) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.88) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.92) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.98) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.92) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.13) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.17) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.21) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.27) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.33) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.52) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.76) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.94) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.95) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.98) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.98) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.96) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.98) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.93) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 4.0 && pt <= 6.0) * (0.13) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 6.0 && pt <= 8.0) * (0.15) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 8.0 && pt <= 10.0) * (0.24) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 10.0 && pt <= 13.0) * (0.23) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 13.0 && pt <= 16.0) * (0.35) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 16.0 && pt <= 20.0) * (0.47) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 20.0 && pt <= 30.0) * (0.73) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 30.0 && pt <= 40.0) * (0.87) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 40.0 && pt <= 50.0) * (0.92) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 50.0 && pt <= 66.0) * (0.95) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 66.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 83.0 && pt <= 100.0) * (0.98) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 100.0 && pt <= 133.0) * (0.96) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 133.0 && pt <= 166.0) * (0.94) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 166.0 && pt <= 200.0) * (0.96) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 200.0 && pt <= 300.0) * (0.94) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 300.0 && pt <= 400.0) * (0.94) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 400.0 && pt <= 500.0) * (0.95) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 500.0) * (0.89) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 4.0 && pt <= 6.0) * (0.14) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 6.0 && pt <= 8.0) * (0.23) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 8.0 && pt <= 10.0) * (0.25) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 10.0 && pt <= 13.0) * (0.27) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 13.0 && pt <= 16.0) * (0.35) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 16.0 && pt <= 20.0) * (0.49) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 20.0 && pt <= 30.0) * (0.72) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 30.0 && pt <= 40.0) * (0.86) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 40.0 && pt <= 50.0) * (0.92) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 50.0 && pt <= 66.0) * (0.92) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 66.0 && pt <= 83.0) * (0.94) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 83.0 && pt <= 100.0) * (0.97) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 100.0 && pt <= 133.0) * (0.94) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 133.0 && pt <= 166.0) * (0.93) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 166.0 && pt <= 200.0) * (0.93) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 200.0 && pt <= 300.0) * (0.95) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 300.0 && pt <= 400.0) * (0.92) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 400.0 && pt <= 500.0) * (0.93) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 500.0) * (0.89) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 4.0 && pt <= 6.0) * (0.16) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 6.0 && pt <= 8.0) * (0.15) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 8.0 && pt <= 10.0) * (0.2) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 10.0 && pt <= 13.0) * (0.31) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 13.0 && pt <= 16.0) * (0.37) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 16.0 && pt <= 20.0) * (0.49) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 30.0) * (0.75) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 30.0 && pt <= 40.0) * (0.9) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 40.0 && pt <= 50.0) * (0.94) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 66.0) * (0.96) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 66.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 133.0) * (0.97) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 133.0 && pt <= 166.0) * (0.98) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 166.0 && pt <= 200.0) * (0.96) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 300.0) * (0.97) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 300.0 && pt <= 400.0) * (0.98) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 400.0 && pt <= 500.0) * (0.94) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 500.0) * (0.94) +
   (abs(eta) > 2.8 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 500.0) * (0.0)  
  }
}



module JetFlavorAssociation JetFlavorAssociationPUPPI {

  set PartonInputArray Delphes/partons
  set ParticleInputArray Delphes/allParticles
  set ParticleLHEFInputArray Delphes/allParticlesLHEF
  set JetInputArray JetSmearPUPPI/jets

  set DeltaR 0.5
  set PartonPTMin 10.0
  set PartonEtaMax 4.0

}

module JetFlavorAssociation JetFlavorAssociationPUPPIAK8 {

  set PartonInputArray Delphes/partons
  set ParticleInputArray Delphes/allParticles
  set ParticleLHEFInputArray Delphes/allParticlesLHEF
  set JetInputArray JetSmearPUPPIAK8/jets

  set DeltaR 0.8
  set PartonPTMin 100.0
  set PartonEtaMax 4.0

}




module BTagging BTaggingPUPPILoose {

  set JetInputArray JetSmearPUPPI/jets

  set BitNumber 0

    add EfficiencyFormula {0} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.2) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.14) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.12) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.11) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.085) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.088) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.085) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.11) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.14) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.46) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.21) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.15) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.13) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.11) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.093) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.1) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.096) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.11) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.16) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.45) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.24) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.18) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.14) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.12) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.1) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.1) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.09) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.1) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.15) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.43) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.2) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.13) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.099) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.088) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.076) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.071) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.072) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.1) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.23) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.52) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.21) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.14) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.12) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.1) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.096) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.076) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.081) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.14) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.28) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (0.79) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.25) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.17) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.14) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.11) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.11) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.081) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.11) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.17) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.31) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.75) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.34) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.27) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.22) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.18) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.17) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.15) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.15) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.3) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.71) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (1.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.38) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.31) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.29) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.26) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.23) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.25) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.25) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.29) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.74) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.73) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.67) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.66) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.66) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.69) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.81) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.68) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.97) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.99) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

    add EfficiencyFormula {5} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.85) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.89) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.9) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.92) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.93) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.93) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.93) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.94) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.93) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.95) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.86) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.89) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.9) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.91) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.92) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.93) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.94) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.92) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.91) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.95) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.85) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.88) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.9) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.91) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.92) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.92) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.93) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.92) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.89) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.91) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.89) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.88) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.91) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.92) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.92) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.94) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.92) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.9) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.88) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (1.0) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.88) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.88) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.89) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.93) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.94) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.92) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.92) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.9) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (1.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.87) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.88) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.9) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.92) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.91) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.89) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.87) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.89) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.9) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.89) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.88) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.9) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.87) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.9) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.87) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (1.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.87) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.87) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.89) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.96) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.8) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.8) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.67) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.91) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.95) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (1.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.86) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (1.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.81) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

    add EfficiencyFormula {4} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.59) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.58) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.62) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.59) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.6) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.59) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.57) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.58) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.57) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.76) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.6) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.61) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.59) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.62) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.62) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.59) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.61) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.59) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.67) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.73) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.61) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.61) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.62) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.61) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.59) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.59) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.58) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.53) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.6) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.76) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.57) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.61) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.57) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.59) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.63) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.53) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.6) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.55) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.77) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.57) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.61) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.56) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.55) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.57) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.54) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.52) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.5) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.51) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.64) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (0.75) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.62) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.56) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.56) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.6) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.54) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.59) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.54) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.73) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.67) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (1.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.62) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.66) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.6) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.52) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.54) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.55) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.56) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.75) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.67) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.61) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.59) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.73) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.4) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.5) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.6) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.79) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.87) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.82) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.82) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (1.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.8) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
}

module BTagging BTaggingPUPPIMedium {

  set JetInputArray JetSmearPUPPI/jets

  set BitNumber 1

    add EfficiencyFormula {0} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.024) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.017) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.0069) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0082) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.018) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.023) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.098) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.025) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.018) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.013) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.015) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.0088) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.017) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.031) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.092) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.028) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.021) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.013) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.01) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.013) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.011) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.017) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.028) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.087) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.022) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.014) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.01) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.0088) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.011) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.012) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.0082) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.0076) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.028) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.067) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.022) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.017) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.01) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.012) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.013) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.0097) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.011) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.021) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.037) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (0.064) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.022) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.017) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.018) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.014) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.017) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.018) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.018) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.025) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.037) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.083) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.037) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.031) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.023) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.024) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.018) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.011) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.0083) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0081) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.14) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.03) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.023) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.027) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.021) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.016) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.0098) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.0051) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.14) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.059) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.072) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.067) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.063) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.057) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.066) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.065) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0014) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.00061) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0038) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0097) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.021) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.044) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.077) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

    add EfficiencyFormula {5} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.72) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.79) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.81) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.84) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.84) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.85) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.87) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.84) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.84) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.83) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.74) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.78) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.81) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.83) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.85) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.86) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.87) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.84) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.82) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.82) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.71) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.77) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.8) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.81) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.83) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.83) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.84) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.81) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.79) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.8) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.76) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.78) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.82) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.83) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.83) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.86) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.85) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.81) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.75) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.78) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.74) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.78) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.77) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.83) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.8) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.83) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.83) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.71) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.86) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (1.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.69) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.72) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.76) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.76) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.74) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.75) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.72) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.78) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.67) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.71) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.71) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.69) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.72) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.74) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.67) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.62) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.62) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.73) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.75) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.8) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.2) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.67) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.48) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.3) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.25) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.14) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

    add EfficiencyFormula {4} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.28) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.24) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.24) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.21) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.21) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.22) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.21) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.3) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.3) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.39) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.29) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.28) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.24) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.25) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.24) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.25) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.24) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.3) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.38) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.4) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.27) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.28) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.28) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.24) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.21) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.21) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.26) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.29) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.38) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.38) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.25) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.24) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.2) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.21) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.24) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.17) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.23) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.31) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.34) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.21) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.23) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.21) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.2) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.2) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.15) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.17) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.22) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.22) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.27) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (0.5) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.26) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.21) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.22) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.23) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.2) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.27) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.25) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.27) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.25) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.21) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.23) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.21) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.19) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.26) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.22) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.75) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.21) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.17) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.2) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.12) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.2) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.17) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.4) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.13) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.2) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.14) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.028) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.023) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
}

module BTagging BTaggingPUPPITight {

  set JetInputArray JetSmearPUPPI/jets

  set BitNumber 2

    add EfficiencyFormula {0} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.0038) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.0012) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0015) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.002) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.00091) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.00027) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.0013) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.003) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.004) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.018) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.0029) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.0022) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.0009) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.0015) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.0025) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.0012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.0016) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.002) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.0024) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.013) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.0018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.003) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.0012) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.0014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.0019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.0018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.0013) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.00082) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.0049) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.018) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.0031) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.00087) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.002) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.00076) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.00057) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.0017) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.0016) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.0035) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.012) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.0022) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.0035) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.0015) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.0024) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.00075) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.00087) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.0021) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.0061) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (0.021) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0015) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.0018) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.0032) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.0019) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0015) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.0019) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.0042) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.019) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.0061) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.0019) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.00061) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.0024) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.0031) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.0032) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.0034) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.0023) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.0023) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0046) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0035) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.003) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0064) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

    add EfficiencyFormula {5} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.54) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.63) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.65) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.7) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.71) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.73) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.75) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.68) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.69) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.66) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.55) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.62) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.66) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.68) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.71) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.74) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.74) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.7) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.64) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.65) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.53) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.6) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.62) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.65) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.68) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.68) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.7) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.63) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.61) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.6) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.58) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.59) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.64) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.66) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.68) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.71) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.7) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.66) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.56) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.56) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.56) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.6) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.58) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.66) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.64) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.71) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.66) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.62) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.71) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (1.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.5) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.51) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.57) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.55) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.56) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.57) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.55) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.78) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.44) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.5) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.55) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.51) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.51) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.57) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.49) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.37) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.37) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.54) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.46) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.6) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.2) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.33) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.23) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.16) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.14) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

    add EfficiencyFormula {4} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.055) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.044) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.039) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.035) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.035) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.055) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.059) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.082) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.087) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.14) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.059) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.044) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.045) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.056) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.029) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.038) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.055) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.096) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.08) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.16) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.055) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.064) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.057) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.057) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.037) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.048) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.068) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.098) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.13) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.097) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.043) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.058) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.042) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.039) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.036) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.035) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.071) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.094) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.14) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.071) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.056) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.027) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.064) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.046) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.035) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.034) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.041) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.02) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (0.25) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.058) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.04) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.057) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.068) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.031) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.048) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.045) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.27) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.076) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.058) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.054) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.049) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.041) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.045) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.064) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.042) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.015) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.022) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.038) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.13) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.2) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.021) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.022) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.045) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

}


module BTagging BTaggingPUPPIAK8Loose {

  set JetInputArray JetSmearPUPPIAK8/jets

  set BitNumber 0

  add EfficiencyFormula {0}      {0.1}

  add EfficiencyFormula {5}      {1.0}

  add EfficiencyFormula {4}      {1.0}
}

module BTagging BTaggingPUPPIAK8Medium {

  set JetInputArray JetSmearPUPPIAK8/jets

  set BitNumber 1

  add EfficiencyFormula {0}      {0.01}

  add EfficiencyFormula {5}      {1.0}

  add EfficiencyFormula {4}      {1.0}
}

module BTagging BTaggingPUPPIAK8Tight {

  set JetInputArray JetSmearPUPPIAK8/jets

  set BitNumber 2

  add EfficiencyFormula {0}      {0.001}

  add EfficiencyFormula {5}      {1.0}

  add EfficiencyFormula {4}      {1.0}

}




#############
# tau-tagging
#############


module TauTagging TauTaggingPUPPILoose {

  set ParticleInputArray Delphes/allParticles
  set PartonInputArray Delphes/partons
  set JetInputArray JetSmearPUPPI/jets

  set DeltaR 0.5
  set TauPTMin 20.0
  set TauEtaMax 4.0
  set BitNumber 0

    add EfficiencyFormula {0} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.01) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.016) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.015) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.014) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.013) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0091) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.0037) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.001) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.00073) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.0018) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.017) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.015) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.014) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.0071) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.005) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.00074) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0011) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.023) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.016) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.016) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.012) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.0051) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.013) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.016) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.017) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.019) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.011) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.011) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 233.0) * (0.0073) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 233.0 && pt <= 366.0) * (0.0025) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 366.0 && pt <= 500.0) * (0.012) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0085) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.012) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.017) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.013) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.012) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.013) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.016) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.013) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.011) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.012) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.021) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.02) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.023) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.013) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.012) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.013) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0086) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.031) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 30.0) * (0.00065) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 40.0) * (0.00047) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 40.0 && pt <= 50.0) * (0.00064) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 66.0) * (0.00058) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 83.0) * (0.00085) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 233.0) * (0.00098) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

  ## DUMMY_TAUTAG_ELECMISTAG_LOOSEID_DUMP
  add EfficiencyFormula {11}      {0.01}
  ## ENDDUMMY_TAUTAG_ELECMISTAG_LOOSEID_DUMP

  ## DUMMY_TAUTAG_MUONMISTAG_LOOSEID_DUMP
  add EfficiencyFormula {13}      {0.01}
  ## ENDDUMMY_TAUTAG_MUONMISTAG_LOOSEID_DUMP

    add EfficiencyFormula {15} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.54) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.66) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.68) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.71) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.73) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.74) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.72) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.71) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.65) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.25) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.53) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.64) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.67) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.7) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.72) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.74) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.72) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.7) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.83) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.5) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.5) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.64) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.68) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.7) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.74) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.72) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.71) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.66) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.5) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.51) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.63) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.65) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.66) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.66) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.67) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 233.0) * (0.68) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 233.0 && pt <= 366.0) * (0.62) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.48) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.58) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.6) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.61) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.61) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.6) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.58) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.73) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.45) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.54) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.58) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.56) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.59) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.62) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.58) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.75) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 40.0) * (0.0059) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 66.0) * (0.0034) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 83.0) * (0.0081) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 233.0) * (0.039) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

}

module TauTagging TauTaggingPUPPIMedium {

  set ParticleInputArray Delphes/allParticles
  set PartonInputArray Delphes/partons
  set JetInputArray JetSmearPUPPI/jets

  set DeltaR 0.5
  set TauPTMin 20.0
  set TauEtaMax 4.0

  set BitNumber 1

    add EfficiencyFormula {0} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.0061) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.0079) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0071) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.0065) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.0069) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0046) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.0016) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.00067) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.00073) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.0014) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.0069) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.0093) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.0068) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.006) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.0045) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.0029) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.0024) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.00037) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0011) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.0098) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.015) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.011) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.008) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.0064) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.0056) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.0021) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.0084) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.009) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.0096) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.01) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.007) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.0047) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 233.0) * (0.0034) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 366.0 && pt <= 500.0) * (0.0025) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0028) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0073) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.0089) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.007) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.0069) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.0062) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0098) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.0064) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.0032) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.0073) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.011) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.01) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.011) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.0065) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.009) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.0058) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0086) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 30.0) * (0.00065) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 40.0 && pt <= 50.0) * (0.00064) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 66.0) * (0.00058) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 233.0) * (0.00098) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

  ## DUMMY_TAUTAG_ELECMISTAG_MEDIUMID_DUMP
  add EfficiencyFormula {11}      {0.002}
  ## ENDDUMMY_TAUTAG_ELECMISTAG_MEDIUMID_DUMP

  ## DUMMY_TAUTAG_MUONMISTAG_MEDIUMID_DUMP
  add EfficiencyFormula {13}      {0.002}
  ## ENDDUMMY_TAUTAG_MUONMISTAG_MEDIUMID_DUMP


    add EfficiencyFormula {15} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.45) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.54) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.57) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.59) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.61) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.63) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.61) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.58) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.62) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.25) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.44) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.53) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.55) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.59) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.61) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.63) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.61) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.58) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.67) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.42) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.51) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.56) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.59) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.61) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.62) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.61) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.63) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.71) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.42) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.52) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.53) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.55) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.56) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.58) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 233.0) * (0.57) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 233.0 && pt <= 366.0) * (0.54) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.38) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.46) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.5) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.49) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.51) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.49) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.5) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.55) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.34) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.41) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.45) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.42) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.43) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.51) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.51) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.5) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 40.0) * (0.0059) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 66.0) * (0.0034) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 233.0) * (0.039) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
}

module TauTagging TauTaggingPUPPITight {

  set ParticleInputArray Delphes/allParticles
  set PartonInputArray Delphes/partons
  set JetInputArray JetSmearPUPPI/jets

  set DeltaR 0.5
  set TauPTMin 20.0
  set TauEtaMax 4.0

  set BitNumber 2

    add EfficiencyFormula {0} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.0038) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.0044) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0037) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.0029) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.0035) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0018) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.00064) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.00067) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.00073) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.00046) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.0047) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.0056) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.0037) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.0026) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.0021) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.0012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.00085) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0011) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.0067) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.0086) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.0061) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.0041) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.0024) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.0025) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.0015) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.0058) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.0051) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.0051) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.0063) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.0039) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.0022) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 233.0) * (0.0021) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 366.0 && pt <= 500.0) * (0.0025) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0028) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0045) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.0053) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.0028) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.0036) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.0034) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0051) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.004) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.0032) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.0043) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.0059) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.0052) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.0046) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.004) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.006) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.0024) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0043) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 30.0) * (0.00065) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 40.0 && pt <= 50.0) * (0.00064) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 233.0) * (0.00098) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

  ## DUMMY_TAUTAG_ELECMISTAG_TIGHTID_DUMP
  add EfficiencyFormula {11}      {0.001}
  ## ENDDUMMY_TAUTAG_ELECMISTAG_TIGHTID_DUMP

  ## DUMMY_TAUTAG_MUONMISTAG_TIGHTID_DUMP
  add EfficiencyFormula {13}      {0.001}
  ## ENDDUMMY_TAUTAG_MUONMISTAG_TIGHTID_DUMP

    add EfficiencyFormula {15} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.36) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.43) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.47) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.48) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.51) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.52) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.49) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.5) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.54) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.25) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.35) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.43) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.44) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.48) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.49) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.52) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.5) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.44) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.61) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.34) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.41) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.45) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.48) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.5) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.51) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.5) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.53) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.71) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.33) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.4) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.43) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.45) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.46) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.48) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 233.0) * (0.46) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 233.0 && pt <= 366.0) * (0.43) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 366.0 && pt <= 500.0) * (0.5) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.3) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.35) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.39) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.39) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.41) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.39) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.42) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.45) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.24) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.31) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.32) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.3) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.32) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.41) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.36) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.5) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 40.0) * (0.0029) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 66.0) * (0.0034) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 233.0) * (0.02) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

}



#################################
# Jet Fake Particle Maker Loose #
#################################

module JetFakeParticle JetFakeMakerLoose {

  set InputArray JetSmearPUPPI/jets
  set PhotonOutputArray photons
  set MuonOutputArray muons
  set ElectronOutputArray electrons
  set JetOutputArray jets

  set EfficiencyFormula {
    {11} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.00032) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.00059) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.0008) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.00093) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.00092) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0012) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.0025) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0026) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.0055) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.0049) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.012) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.00025) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.00052) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.00097) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.0012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.001) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.0011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.0014) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.00074) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.00089) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.0014) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.0036) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.0059) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.007) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.013) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.00042) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.00066) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.0014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.0019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.0018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.0019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.0028) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.0029) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.0026) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.005) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.0059) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.0076) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.014) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.019) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.0048) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.0071) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.0086) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.0087) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.0056) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.0044) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.0022) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.0024) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.0027) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.00065) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.00029) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.00016) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0036) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.008) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.013) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.012) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.01) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0073) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.005) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.0064) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.0021) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.0026) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.002) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.00093) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.00055) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.0015) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.0021) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.0043) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.0094) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.014) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.017) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.022) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.03) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.039) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.049) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.058) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.047) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.029) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.00098) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0017) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0047) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.013) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.024) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.034) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.031) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.059) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.039) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.048) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.25) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
    {13} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.0067) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.0068) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.01) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0093) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.0089) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.0084) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0093) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.0099) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.0096) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.0069) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0071) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.0068) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.0043) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.0052) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.01) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.013) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.013) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.013) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.015) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.013) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.0076) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.007) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0082) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.016) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.02) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.022) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.02) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.022) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.024) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.017) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.017) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.015) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.013) +
          (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 20.0 && pt <= 30.0) * (0.014) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 30.0 && pt <= 40.0) * (0.017) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 40.0 && pt <= 50.0) * (0.025) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 50.0 && pt <= 66.0) * (0.027) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 66.0 && pt <= 83.0) * (0.027) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 83.0 && pt <= 100.0) * (0.035) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 100.0 && pt <= 133.0) * (0.039) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 133.0 && pt <= 166.0) * (0.032) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 166.0 && pt <= 200.0) * (0.024) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 200.0 && pt <= 300.0) * (0.024) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 300.0 && pt <= 400.0) * (0.017) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 400.0 && pt <= 500.0) * (0.014) +
          (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 500.0) * (0.012) +
          (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 20.0 && pt <= 30.0) * (0.0092) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 30.0 && pt <= 40.0) * (0.009) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 40.0 && pt <= 50.0) * (0.0098) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 50.0 && pt <= 66.0) * (0.011) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 66.0 && pt <= 83.0) * (0.013) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 83.0 && pt <= 100.0) * (0.014) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 100.0 && pt <= 133.0) * (0.014) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 133.0 && pt <= 166.0) * (0.018) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 166.0 && pt <= 200.0) * (0.013) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 200.0 && pt <= 300.0) * (0.011) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 300.0 && pt <= 400.0) * (0.0046) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 400.0 && pt <= 500.0) * (0.0072) +
          (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 500.0) * (0.0066) +
          (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 30.0) * (0.0039) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 30.0 && pt <= 40.0) * (0.0035) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 40.0 && pt <= 50.0) * (0.0035) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 66.0) * (0.0039) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 66.0 && pt <= 83.0) * (0.0046) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 83.0 && pt <= 100.0) * (0.0041) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0044) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 133.0 && pt <= 166.0) * (0.0036) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0035) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0054) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0085) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 400.0 && pt <= 500.0) * (0.014) +
          (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.8 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 20.0 && pt <= 30.0) * (0.00066) +
          (abs(eta) > 2.8) * (pt > 30.0 && pt <= 40.0) * (0.0005) +
          (abs(eta) > 2.8) * (pt > 40.0 && pt <= 50.0) * (0.00054) +
          (abs(eta) > 2.8) * (pt > 50.0 && pt <= 66.0) * (0.0005) +
          (abs(eta) > 2.8) * (pt > 66.0 && pt <= 83.0) * (0.00063) +
          (abs(eta) > 2.8) * (pt > 83.0 && pt <= 100.0) * (0.00057) +
          (abs(eta) > 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0015) +
          (abs(eta) > 2.8) * (pt > 133.0 && pt <= 166.0) * (0.00041) +
          (abs(eta) > 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0008) +
          (abs(eta) > 2.8) * (pt > 200.0 && pt <= 300.0) * (0.001) +
          (abs(eta) > 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0039) +
          (abs(eta) > 2.8) * (pt > 400.0 && pt <= 500.0) * (0.045) +
          (abs(eta) > 2.8) * (pt > 500.0) * (0.0)  
  }
    {22} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.00063) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.00093) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.0012) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0013) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.0013) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.0012) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.0012) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.00073) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.00059) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.00056) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.00077) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.00099) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.0016) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.0017) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.0014) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.0016) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.00075) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.0015) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.0012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.001) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.0011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.001) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.0022) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0009) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.00092) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.0012) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.0019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.0021) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.0018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.0016) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.0012) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.0018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.0012) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.0011) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.0016) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.00087) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.0022) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0012) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.0077) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.01) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.012) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.011) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.012) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.0092) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.0062) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.0037) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.0031) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.0013) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.0012) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.00047) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.00016) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0051) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.011) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.016) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.018) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.016) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.013) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.011) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.012) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.0093) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.012) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.013) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.014) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0088) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.0016) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.0022) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.004) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.0082) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.014) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.018) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.023) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.035) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.056) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.067) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.11) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.098) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.053) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.00076) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0013) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0034) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.008) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.015) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.024) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.022) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.047) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.037) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.037) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.25) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
  }

}


#################################
# Jet Fake Particle Maker Medium #
#################################

module JetFakeParticle JetFakeMakerMedium {

  set InputArray JetSmearPUPPI/jets
  set PhotonOutputArray photons
  set MuonOutputArray muons
  set ElectronOutputArray electrons
  set JetOutputArray jets

  set EfficiencyFormula {
    {11} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.00015) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.00025) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.00039) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0005) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.00046) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.00027) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.00055) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.00045) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.00027) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.001) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.0013) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.0014) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.0043) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.00012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.00023) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.00053) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.00045) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.00048) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.0006) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.0005) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.00046) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.00044) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.0004) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.0011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.0016) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.0028) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0047) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.00028) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.00023) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.00064) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.00072) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.00089) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.00087) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.0013) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.0014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.0012) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.002) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.0016) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.0028) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.0036) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0091) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.0013) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.0022) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.0024) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.0024) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.002) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.0019) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.0015) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.00079) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.0017) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.00022) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.00029) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0015) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.0037) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.0058) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.0045) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.0041) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0025) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.0026) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.002) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.0013) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.0012) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.00067) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.00095) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.0022) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.0043) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.0063) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.0074) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.0097) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.013) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.015) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.019) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.03) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.019) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.00061) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0012) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0033) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0081) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.015) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.018) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.016) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.034) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.03) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.027) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.25) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
    {13} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.0059) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.006) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.0095) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0087) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.0082) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.008) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0086) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.009) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.0085) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.0062) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0067) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.0063) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.0039) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.0048) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.01) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.0087) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.01) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.014) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.01) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.01) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.0069) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.0066) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0072) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.015) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.02) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.017) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.02) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.022) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.017) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.017) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.013) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.011) +
          (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 20.0 && pt <= 30.0) * (0.012) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 30.0 && pt <= 40.0) * (0.015) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 40.0 && pt <= 50.0) * (0.024) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 50.0 && pt <= 66.0) * (0.025) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 66.0 && pt <= 83.0) * (0.026) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 83.0 && pt <= 100.0) * (0.034) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 100.0 && pt <= 133.0) * (0.038) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 133.0 && pt <= 166.0) * (0.03) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 166.0 && pt <= 200.0) * (0.023) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 200.0 && pt <= 300.0) * (0.023) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 300.0 && pt <= 400.0) * (0.016) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 400.0 && pt <= 500.0) * (0.012) +
          (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 500.0) * (0.011) +
          (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 20.0 && pt <= 30.0) * (0.0078) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 30.0 && pt <= 40.0) * (0.0078) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 40.0 && pt <= 50.0) * (0.0087) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 50.0 && pt <= 66.0) * (0.0098) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 66.0 && pt <= 83.0) * (0.011) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 83.0 && pt <= 100.0) * (0.014) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 100.0 && pt <= 133.0) * (0.013) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 133.0 && pt <= 166.0) * (0.017) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 166.0 && pt <= 200.0) * (0.013) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 200.0 && pt <= 300.0) * (0.011) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 300.0 && pt <= 400.0) * (0.0041) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 400.0 && pt <= 500.0) * (0.0072) +
          (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 500.0) * (0.0066) +
          (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 30.0) * (0.0033) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 30.0 && pt <= 40.0) * (0.0028) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 40.0 && pt <= 50.0) * (0.0029) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 66.0) * (0.0032) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 66.0 && pt <= 83.0) * (0.0035) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 83.0 && pt <= 100.0) * (0.0041) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0042) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 133.0 && pt <= 166.0) * (0.0036) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0023) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0041) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0063) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 400.0 && pt <= 500.0) * (0.0028) +
          (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.8 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 20.0 && pt <= 30.0) * (0.00052) +
          (abs(eta) > 2.8) * (pt > 30.0 && pt <= 40.0) * (0.0004) +
          (abs(eta) > 2.8) * (pt > 40.0 && pt <= 50.0) * (0.00041) +
          (abs(eta) > 2.8) * (pt > 50.0 && pt <= 66.0) * (0.00039) +
          (abs(eta) > 2.8) * (pt > 66.0 && pt <= 83.0) * (0.0005) +
          (abs(eta) > 2.8) * (pt > 83.0 && pt <= 100.0) * (0.00048) +
          (abs(eta) > 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0011) +
          (abs(eta) > 2.8) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0039) +
          (abs(eta) > 2.8) * (pt > 400.0 && pt <= 500.0) * (0.023) +
          (abs(eta) > 2.8) * (pt > 500.0) * (0.0)  
  }
    {22} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (9.8e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.00042) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.00064) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0006) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.00079) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.00062) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.00055) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.0008) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.00068) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.00055) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0007) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.00079) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.00059) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.00042) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.00032) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.00045) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.00074) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.00093) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.00063) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.00099) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.00033) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.0012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.00074) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.0006) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.00098) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.00087) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.0013) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.00064) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.00023) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.00041) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.00099) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.00087) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.00093) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.0007) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.00046) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.001) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.00083) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.00091) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.0012) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.00065) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.00082) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.00063) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.0043) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.0054) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.0062) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.0051) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.005) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.0046) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.0037) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.0018) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.0024) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.00022) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.00088) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0031) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.0065) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.0097) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.0097) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.0094) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0064) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.0072) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.0073) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.0047) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.0055) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.006) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.0065) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0033) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.00097) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.0013) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.0025) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.0047) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.0078) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.01) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.015) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.024) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.042) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.053) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.084) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.074) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.029) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.00051) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0009) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0023) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0056) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.01) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.017) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.016) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.035) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.025) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.037) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
  }

}

#################################
# Jet Fake Particle Maker Tight #
#################################

module JetFakeParticle JetFakeMakerTight {

  set InputArray JetSmearPUPPI/jets
  set PhotonOutputArray photons
  set MuonOutputArray muons
  set ElectronOutputArray electrons
  set JetOutputArray jets

  set EfficiencyFormula {
    {11} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (2.4e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (4.4e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.00013) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.00014) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.0002) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (7.7e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.00031) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (8.9e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.00014) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.00036) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0001) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.00016) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.0002) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.0014) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (7.4e-05) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (5.4e-05) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.00019) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.0001) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.0002) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.00024) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.00025) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (9.2e-05) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.0003) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.0002) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.00055) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.0018) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0019) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.00014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (5.3e-05) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.00023) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.0003) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.00046) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.00026) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.00055) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.00084) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.0005) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.0014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.00092) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.0015) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.0019) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0041) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.00044) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.00056) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.00065) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.00077) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.0011) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.00088) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.00075) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.00026) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.00034) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0007) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.0017) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.003) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.0022) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.0018) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0011) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.00095) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.00087) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.00042) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.00029) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.00033) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.00046) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.0011) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.002) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.0033) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.0036) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.0039) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.0055) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.0071) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.0095) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.005) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.019) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0004) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.00086) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0025) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0055) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.01) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.011) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0075) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.025) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.014) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.027) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
    {13} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.00012) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.00015) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.00012) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (9.9e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.00018) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (7.7e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (7.9e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.00018) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0001) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.00016) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (9.3e-05) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.00015) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.00021) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.00013) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.00023) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.00015) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.00016) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.00025) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.0003) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.0002) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.00055) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.00017) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.00022) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.00016) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.00042) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.00031) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.00019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.00019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.00018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.00039) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.00031) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.00017) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.00043) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.00027) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (7.9e-05) +
          (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 20.0 && pt <= 30.0) * (0.0003) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 30.0 && pt <= 40.0) * (0.00043) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 40.0 && pt <= 50.0) * (0.00019) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 50.0 && pt <= 66.0) * (0.00031) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 66.0 && pt <= 83.0) * (0.00052) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 83.0 && pt <= 100.0) * (0.0012) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 100.0 && pt <= 133.0) * (0.00056) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 133.0 && pt <= 166.0) * (0.00059) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 166.0 && pt <= 200.0) * (0.00038) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 200.0 && pt <= 300.0) * (0.00024) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 400.0 && pt <= 500.0) * (0.00052) +
          (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 500.0) * (0.00034) +
          (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 20.0 && pt <= 30.0) * (0.00028) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 30.0 && pt <= 40.0) * (0.00026) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 40.0 && pt <= 50.0) * (0.00025) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 50.0 && pt <= 66.0) * (0.00037) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 66.0 && pt <= 83.0) * (0.00039) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 83.0 && pt <= 100.0) * (0.00017) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 100.0 && pt <= 133.0) * (0.00028) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 133.0 && pt <= 166.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 166.0 && pt <= 200.0) * (0.00047) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 200.0 && pt <= 300.0) * (0.00031) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 300.0 && pt <= 400.0) * (0.00051) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 30.0) * (0.00017) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 30.0 && pt <= 40.0) * (0.00014) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 40.0 && pt <= 50.0) * (0.00022) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 66.0) * (0.00015) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 66.0 && pt <= 83.0) * (0.00038) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 83.0 && pt <= 100.0) * (0.0004) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 133.0) * (0.00024) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 133.0 && pt <= 166.0) * (0.00036) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 166.0 && pt <= 200.0) * (0.00059) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0018) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.8 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 20.0 && pt <= 30.0) * (2.7e-05) +
          (abs(eta) > 2.8) * (pt > 30.0 && pt <= 40.0) * (1.3e-05) +
          (abs(eta) > 2.8) * (pt > 40.0 && pt <= 50.0) * (2e-05) +
          (abs(eta) > 2.8) * (pt > 50.0 && pt <= 66.0) * (8.6e-06) +
          (abs(eta) > 2.8) * (pt > 66.0 && pt <= 83.0) * (2.5e-05) +
          (abs(eta) > 2.8) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 500.0) * (0.0)  
  }
    {22} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (2.4e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.00018) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.00023) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.00032) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.00036) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.00035) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.00031) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.00045) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.00027) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.00036) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0005) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.00031) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.00039) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.00023) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.00022) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.00016) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.00031) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.00045) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.00041) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.00056) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.00025) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.00074) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.00059) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.0002) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.00066) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.00069) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.0013) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.00048) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (4.6e-05) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.00015) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.00039) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.00032) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.00037) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.00026) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (9.2e-05) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.00073) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.0005) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.00091) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.00065) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.00043) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.00055) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.00032) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.0023) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.0029) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.0029) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.0024) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.0033) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.0026) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.002) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.00026) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.0014) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.00022) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.00029) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0022) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.0044) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.0064) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.0062) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.0062) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0038) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.0052) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.0032) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.0034) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.0029) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.004) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.0037) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.00055) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.00065) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.00084) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.0018) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.0032) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.0051) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.0067) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.01) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.017) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.031) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.041) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.064) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.047) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.012) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.00037) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.00068) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0018) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0044) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0081) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.011) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.011) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.028) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.021) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.027) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

}



############################
# Photon fake merger loose
############################

module Merger PhotonFakeMergerLoose {
# add InputArray InputArray
  add InputArray PhotonLooseID/photons
  add InputArray JetFakeMakerLoose/photons
  set OutputArray photons
}

############################
# Photon fake merger medium
############################

module Merger PhotonFakeMergerMedium {
# add InputArray InputArray
  add InputArray PhotonMediumID/photons
  add InputArray JetFakeMakerMedium/photons
  set OutputArray photons
}

############################
# Photon fake merger tight
############################

module Merger PhotonFakeMergerTight {
# add InputArray InputArray
  add InputArray PhotonTightID/photons
  add InputArray JetFakeMakerTight/photons
  set OutputArray photons
}

############################
# Electron fake merger loose
############################

module Merger ElectronFakeMergerLoose {
# add InputArray InputArray
  add InputArray ElectronLooseEfficiency/electrons
  add InputArray JetFakeMakerLoose/electrons
  set OutputArray electrons
}

############################
# Electron fake merger medium
############################

module Merger ElectronFakeMergerMedium {
# add InputArray InputArray
  add InputArray ElectronMediumEfficiency/electrons
  add InputArray JetFakeMakerMedium/electrons
  set OutputArray electrons
}

############################
# Electron fake merger tight
############################

module Merger ElectronFakeMergerTight {
# add InputArray InputArray
  add InputArray ElectronTightEfficiency/electrons
  add InputArray JetFakeMakerTight/electrons
  set OutputArray electrons
}


############################
# Muon fake merger loose
############################

module Merger MuonFakeMergerLoose {
# add InputArray InputArray
  add InputArray MuonLooseIdEfficiency/muons
  add InputArray JetFakeMakerLoose/muons
  set OutputArray muons
}

############################
# Muon fake merger medium
############################

module Merger MuonFakeMergerMedium {
# add InputArray InputArray
  add InputArray MuonMediumIdEfficiency/muons
  add InputArray JetFakeMakerMedium/muons
  set OutputArray muons
}

############################
# Muon fake merger tight
############################

module Merger MuonFakeMergerTight {
# add InputArray InputArray
  add InputArray MuonTightIdEfficiency/muons
  add InputArray JetFakeMakerTight/muons
  set OutputArray muons
}




###############################################################################################################
# StatusPidFilter: this module removes all generated particles except electrons, muons, taus, and status == 3 #
###############################################################################################################

}
module StatusPidFilter GenParticleFilter {

    set InputArray Delphes/allParticles
    set OutputArray filteredParticles
    set PTMin 0.0

}


####################################
# Charged hadron tracking efficiency
####################################

module Efficiency L1TChargedHadronTrackingEfficiency {
  ## particles after propagation
  set InputArray  DenseTrackFilter/chargedHadrons
  set OutputArray chargedHadrons
  # tracking efficiency formula for charged hadrons
  set UseMomentumVector true

  set EfficiencyFormula {
      (pt <= 2.0) * (0.00) + \
          (abs(eta) <= 2.4) * (pt > 2 && pt <= 3) * (0.59) + \
          (abs(eta) <= 2.4) * (pt > 3 && pt <= 4) * (0.71) + \
          (abs(eta) <= 2.4) * (pt > 4 && pt <= 5) * (0.76) + \
          (abs(eta) <= 2.4) * (pt > 5 && pt <= 8) * (0.82) + \
          (abs(eta) <= 2.4) * (pt > 8 && pt <= 15) * (0.90) + \
          (abs(eta) <= 2.4) * (pt > 15 && pt <= 25) * (0.92) + \
          (abs(eta) <= 2.4) * (pt > 25) * (0.93) + \
          (abs(eta) > 2.4) * (0.00)
  }
  #custom L1T
}


#####################################
# Electron tracking efficiency - ID
####################################

module Efficiency L1TElectronTrackingEfficiency {
  set InputArray  DenseTrackFilter/electrons
  set OutputArray electrons
  set UseMomentumVector true

  # tracking efficiency formula for electrons
  set EfficiencyFormula {
      (pt <= 2.0) * (0.00) + \
          (abs(eta) <= 2.4) * (pt > 2 && pt <= 3) * (0.42) + \
          (abs(eta) <= 2.4) * (pt > 3 && pt <= 4) * (0.58) + \
          (abs(eta) <= 2.4) * (pt > 4 && pt <= 5) * (0.63) + \
          (abs(eta) <= 2.4) * (pt > 5 && pt <= 8) * (0.71) + \
          (abs(eta) <= 2.4) * (pt > 8 && pt <= 15) * (0.80) + \
          (abs(eta) <= 2.4) * (pt > 15 && pt <= 25) * (0.86) + \
          (abs(eta) <= 2.4) * (pt > 25) * (0.89) + \
          (abs(eta) > 2.4) * (0.00)
  }
  # custom L1T
}

##########################
# Muon tracking efficiency
##########################

module Efficiency L1TMuonTrackingEfficiency {
  set InputArray DenseTrackFilter/muons
  set OutputArray muons
  set UseMomentumVector true
  # tracking efficiency formula for muons
  set EfficiencyFormula {
      (pt <= 2.0) * (0.00) + \
          (abs(eta) <= 2.4) * (pt > 2 && pt <= 3) * (0.93) + \
          (abs(eta) <= 2.4) * (pt > 3 && pt <= 4) * (0.96) + \
          (abs(eta) <= 2.4) * (pt > 4 && pt <= 5) * (0.97) + \
          (abs(eta) <= 2.4) * (pt > 5 && pt <= 10) * (0.98) + \
          (abs(eta) <= 2.4) * (pt > 10) * (1.00) + \
          (abs(eta) > 2.4) * (0.00)
  }
  # custom L1T
}


########################################
# Momentum resolution for charged tracks
########################################

module MomentumSmearing L1TChargedHadronMomentumSmearing {
  ## hadrons after having applied the tracking efficiency
  set InputArray  L1TChargedHadronTrackingEfficiency/chargedHadrons
  set OutputArray chargedHadrons
  # resolution formula for charged hadrons ,

  #
  # Automatically generated tracker resolution formula for layout: OT612IT4025
  #
  #  By Unknown author on: 2017-06-30.17:03:00
  #
  set ResolutionFormula {    
    2 * ( \
     (abs(eta) >= 0.0000 && abs(eta) < 0.2000) * (pt >= 0.0000 && pt < 1.0000) * (0.00457888) + \
     (abs(eta) >= 0.0000 && abs(eta) < 0.2000) * (pt >= 1.0000 && pt < 10.0000) * (0.004579 + (pt-1.000000)* 0.000045) + \
     (abs(eta) >= 0.0000 && abs(eta) < 0.2000) * (pt >= 10.0000 && pt < 100.0000) * (0.004983 + (pt-10.000000)* 0.000047) + \
     (abs(eta) >= 0.0000 && abs(eta) < 0.2000) * (pt >= 100.0000) * (0.009244*pt/100.000000) + \
     (abs(eta) >= 0.2000 && abs(eta) < 0.4000) * (pt >= 0.0000 && pt < 1.0000) * (0.00505011) + \
     (abs(eta) >= 0.2000 && abs(eta) < 0.4000) * (pt >= 1.0000 && pt < 10.0000) * (0.005050 + (pt-1.000000)* 0.000033) + \
     (abs(eta) >= 0.2000 && abs(eta) < 0.4000) * (pt >= 10.0000 && pt < 100.0000) * (0.005343 + (pt-10.000000)* 0.000043) + \
     (abs(eta) >= 0.2000 && abs(eta) < 0.4000) * (pt >= 100.0000) * (0.009172*pt/100.000000) + \
     (abs(eta) >= 0.4000 && abs(eta) < 0.6000) * (pt >= 0.0000 && pt < 1.0000) * (0.00510573) + \
     (abs(eta) >= 0.4000 && abs(eta) < 0.6000) * (pt >= 1.0000 && pt < 10.0000) * (0.005106 + (pt-1.000000)* 0.000023) + \
     (abs(eta) >= 0.4000 && abs(eta) < 0.6000) * (pt >= 10.0000 && pt < 100.0000) * (0.005317 + (pt-10.000000)* 0.000042) + \
     (abs(eta) >= 0.4000 && abs(eta) < 0.6000) * (pt >= 100.0000) * (0.009077*pt/100.000000) + \
     (abs(eta) >= 0.6000 && abs(eta) < 0.8000) * (pt >= 0.0000 && pt < 1.0000) * (0.00578020) + \
     (abs(eta) >= 0.6000 && abs(eta) < 0.8000) * (pt >= 1.0000 && pt < 10.0000) * (0.005780 + (pt-1.000000)* -0.000000) + \
     (abs(eta) >= 0.6000 && abs(eta) < 0.8000) * (pt >= 10.0000 && pt < 100.0000) * (0.005779 + (pt-10.000000)* 0.000038) + \
     (abs(eta) >= 0.6000 && abs(eta) < 0.8000) * (pt >= 100.0000) * (0.009177*pt/100.000000) + \
     (abs(eta) >= 0.8000 && abs(eta) < 1.0000) * (pt >= 0.0000 && pt < 1.0000) * (0.00728723) + \
     (abs(eta) >= 0.8000 && abs(eta) < 1.0000) * (pt >= 1.0000 && pt < 10.0000) * (0.007287 + (pt-1.000000)* -0.000031) + \
     (abs(eta) >= 0.8000 && abs(eta) < 1.0000) * (pt >= 10.0000 && pt < 100.0000) * (0.007011 + (pt-10.000000)* 0.000038) + \
     (abs(eta) >= 0.8000 && abs(eta) < 1.0000) * (pt >= 100.0000) * (0.010429*pt/100.000000) + \
     (abs(eta) >= 1.0000 && abs(eta) < 1.2000) * (pt >= 0.0000 && pt < 1.0000) * (0.01045117) + \
     (abs(eta) >= 1.0000 && abs(eta) < 1.2000) * (pt >= 1.0000 && pt < 10.0000) * (0.010451 + (pt-1.000000)* -0.000051) + \
     (abs(eta) >= 1.0000 && abs(eta) < 1.2000) * (pt >= 10.0000 && pt < 100.0000) * (0.009989 + (pt-10.000000)* 0.000043) + \
     (abs(eta) >= 1.0000 && abs(eta) < 1.2000) * (pt >= 100.0000) * (0.013867*pt/100.000000) + \
     (abs(eta) >= 1.2000 && abs(eta) < 1.4000) * (pt >= 0.0000 && pt < 1.0000) * (0.01477199) + \
     (abs(eta) >= 1.2000 && abs(eta) < 1.4000) * (pt >= 1.0000 && pt < 10.0000) * (0.014772 + (pt-1.000000)* -0.000128) + \
     (abs(eta) >= 1.2000 && abs(eta) < 1.4000) * (pt >= 10.0000 && pt < 100.0000) * (0.013616 + (pt-10.000000)* 0.000035) + \
     (abs(eta) >= 1.2000 && abs(eta) < 1.4000) * (pt >= 100.0000) * (0.016800*pt/100.000000) + \
     (abs(eta) >= 1.4000 && abs(eta) < 1.6000) * (pt >= 0.0000 && pt < 1.0000) * (0.01731474) + \
     (abs(eta) >= 1.4000 && abs(eta) < 1.6000) * (pt >= 1.0000 && pt < 10.0000) * (0.017315 + (pt-1.000000)* -0.000208) + \
     (abs(eta) >= 1.4000 && abs(eta) < 1.6000) * (pt >= 10.0000 && pt < 100.0000) * (0.015439 + (pt-10.000000)* 0.000030) + \
     (abs(eta) >= 1.4000 && abs(eta) < 1.6000) * (pt >= 100.0000) * (0.018161*pt/100.000000) + \
     (abs(eta) >= 1.6000 && abs(eta) < 1.8000) * (pt >= 0.0000 && pt < 1.0000) * (0.01942025) + \
     (abs(eta) >= 1.6000 && abs(eta) < 1.8000) * (pt >= 1.0000 && pt < 10.0000) * (0.019420 + (pt-1.000000)* -0.000417) + \
     (abs(eta) >= 1.6000 && abs(eta) < 1.8000) * (pt >= 10.0000 && pt < 100.0000) * (0.015669 + (pt-10.000000)* 0.000026) + \
     (abs(eta) >= 1.6000 && abs(eta) < 1.8000) * (pt >= 100.0000) * (0.018039*pt/100.000000) + \
     (abs(eta) >= 1.8000 && abs(eta) < 2.0000) * (pt >= 0.0000 && pt < 1.0000) * (0.02201432) + \
     (abs(eta) >= 1.8000 && abs(eta) < 2.0000) * (pt >= 1.0000 && pt < 10.0000) * (0.022014 + (pt-1.000000)* -0.000667) + \
     (abs(eta) >= 1.8000 && abs(eta) < 2.0000) * (pt >= 10.0000 && pt < 100.0000) * (0.016012 + (pt-10.000000)* 0.000045) + \
     (abs(eta) >= 1.8000 && abs(eta) < 2.0000) * (pt >= 100.0000) * (0.020098*pt/100.000000) + \
     (abs(eta) >= 2.0000 && abs(eta) < 2.2000) * (pt >= 0.0000 && pt < 1.0000) * (0.02574300) + \
     (abs(eta) >= 2.0000 && abs(eta) < 2.2000) * (pt >= 1.0000 && pt < 10.0000) * (0.025743 + (pt-1.000000)* -0.001118) + \
     (abs(eta) >= 2.0000 && abs(eta) < 2.2000) * (pt >= 10.0000 && pt < 100.0000) * (0.015681 + (pt-10.000000)* 0.000051) + \
     (abs(eta) >= 2.0000 && abs(eta) < 2.2000) * (pt >= 100.0000) * (0.020289*pt/100.000000) + \
     (abs(eta) >= 2.2000 && abs(eta) < 2.4000) * (pt >= 0.0000 && pt < 1.0000) * (0.02885821) + \
     (abs(eta) >= 2.2000 && abs(eta) < 2.4000) * (pt >= 1.0000 && pt < 10.0000) * (0.028858 + (pt-1.000000)* -0.001345) + \
     (abs(eta) >= 2.2000 && abs(eta) < 2.4000) * (pt >= 10.0000 && pt < 100.0000) * (0.016753 + (pt-10.000000)* 0.000053) + \
     (abs(eta) >= 2.2000 && abs(eta) < 2.4000) * (pt >= 100.0000) * (0.021524*pt/100.000000) + \
     (abs(eta) >= 2.4000 && abs(eta) < 2.6000) * (pt >= 0.0000 && pt < 1.0000) * (0.03204812) + \
     (abs(eta) >= 2.4000 && abs(eta) < 2.6000) * (pt >= 1.0000 && pt < 10.0000) * (0.032048 + (pt-1.000000)* -0.001212) + \
     (abs(eta) >= 2.4000 && abs(eta) < 2.6000) * (pt >= 10.0000 && pt < 100.0000) * (0.021138 + (pt-10.000000)* 0.000037) + \
     (abs(eta) >= 2.4000 && abs(eta) < 2.6000) * (pt >= 100.0000) * (0.024477*pt/100.000000) + \
     (abs(eta) >= 2.6000 && abs(eta) < 2.8000) * (pt >= 0.0000 && pt < 1.0000) * (0.03950405) + \
     (abs(eta) >= 2.6000 && abs(eta) < 2.8000) * (pt >= 1.0000 && pt < 10.0000) * (0.039504 + (pt-1.000000)* -0.001386) + \
     (abs(eta) >= 2.6000 && abs(eta) < 2.8000) * (pt >= 10.0000 && pt < 100.0000) * (0.027026 + (pt-10.000000)* 0.000037) + \
     (abs(eta) >= 2.6000 && abs(eta) < 2.8000) * (pt >= 100.0000) * (0.030392*pt/100.000000) + \
     (abs(eta) >= 2.8000 && abs(eta) < 3.0000) * (pt >= 0.0000 && pt < 1.0000) * (0.04084751) + \
     (abs(eta) >= 2.8000 && abs(eta) < 3.0000) * (pt >= 1.0000 && pt < 10.0000) * (0.040848 + (pt-1.000000)* -0.001780) + \
     (abs(eta) >= 2.8000 && abs(eta) < 3.0000) * (pt >= 10.0000 && pt < 100.0000) * (0.024824 + (pt-10.000000)* 0.000029) + \
     (abs(eta) >= 2.8000 && abs(eta) < 3.0000) * (pt >= 100.0000) * (0.027445*pt/100.000000) + \
     (abs(eta) >= 3.0000 && abs(eta) < 3.2000) * (pt >= 0.0000 && pt < 1.0000) * (0.04532425) + \
     (abs(eta) >= 3.0000 && abs(eta) < 3.2000) * (pt >= 1.0000 && pt < 10.0000) * (0.045324 + (pt-1.000000)* -0.002497) + \
     (abs(eta) >= 3.0000 && abs(eta) < 3.2000) * (pt >= 10.0000 && pt < 100.0000) * (0.022851 + (pt-10.000000)* 0.000024) + \
     (abs(eta) >= 3.0000 && abs(eta) < 3.2000) * (pt >= 100.0000) * (0.025053*pt/100.000000) + \
     (abs(eta) >= 3.2000 && abs(eta) < 3.4000) * (pt >= 0.0000 && pt < 1.0000) * (0.06418925) + \
     (abs(eta) >= 3.2000 && abs(eta) < 3.4000) * (pt >= 1.0000 && pt < 10.0000) * (0.064189 + (pt-1.000000)* -0.004055) + \
     (abs(eta) >= 3.2000 && abs(eta) < 3.4000) * (pt >= 10.0000 && pt < 100.0000) * (0.027691 + (pt-10.000000)* 0.000034) + \
     (abs(eta) >= 3.2000 && abs(eta) < 3.4000) * (pt >= 100.0000) * (0.030710*pt/100.000000) + \
     (abs(eta) >= 3.4000 && abs(eta) < 3.6000) * (pt >= 0.0000 && pt < 1.0000) * (0.07682500) + \
     (abs(eta) >= 3.4000 && abs(eta) < 3.6000) * (pt >= 1.0000 && pt < 10.0000) * (0.076825 + (pt-1.000000)* -0.004510) + \
     (abs(eta) >= 3.4000 && abs(eta) < 3.6000) * (pt >= 10.0000 && pt < 100.0000) * (0.036234 + (pt-10.000000)* 0.000049) + \
     (abs(eta) >= 3.4000 && abs(eta) < 3.6000) * (pt >= 100.0000) * (0.040629*pt/100.000000) + \
     (abs(eta) >= 3.6000 && abs(eta) < 3.8000) * (pt >= 0.0000 && pt < 1.0000) * (0.09796358) + \
     (abs(eta) >= 3.6000 && abs(eta) < 3.8000) * (pt >= 1.0000 && pt < 10.0000) * (0.097964 + (pt-1.000000)* -0.005758) + \
     (abs(eta) >= 3.6000 && abs(eta) < 3.8000) * (pt >= 10.0000 && pt < 100.0000) * (0.046145 + (pt-10.000000)* 0.000069) + \
     (abs(eta) >= 3.6000 && abs(eta) < 3.8000) * (pt >= 100.0000) * (0.052345*pt/100.000000) + \
     (abs(eta) >= 3.8000 && abs(eta) < 4.0000) * (pt >= 0.0000 && pt < 1.0000) * (0.13415929) + \
     (abs(eta) >= 3.8000 && abs(eta) < 4.0000) * (pt >= 1.0000 && pt < 10.0000) * (0.134159 + (pt-1.000000)* -0.008283) + \
     (abs(eta) >= 3.8000 && abs(eta) < 4.0000) * (pt >= 10.0000 && pt < 100.0000) * (0.059612 + (pt-10.000000)* 0.000111) + \
     (abs(eta) >= 3.8000 && abs(eta) < 4.0000) * (pt >= 100.0000) * (0.069617*pt/100.000000) \
    )
  }
  # custom L1T
}


#################################
# Energy resolution for electrons
#################################

module EnergySmearing L1TElectronEnergySmearing {
  set InputArray L1TElectronTrackingEfficiency/electrons
  set OutputArray electrons

  # set ResolutionFormula {resolution formula as a function of eta and energy}

  # resolution formula for electrons

  # taking something flat in energy for now, ECAL will take over at high energy anyway.
  # inferred from hep-ex/1306.2016 and 1502.02701
  set ResolutionFormula {
                        (abs(eta) <= 5.0)  * (1e-10)
  }
}

###############################
# Momentum resolution for muons
###############################

module MomentumSmearing L1TMuonMomentumSmearing {
  set InputArray L1TMuonTrackingEfficiency/muons
  set OutputArray muons
  # resolution formula for muons

  # up to |eta| < 2.8 take measurement from tracking + muon chambers
  # for |eta| > 2.8 and pT < 5.0 take measurement from tracking alone taken from
  # http://mersi.web.cern.ch/mersi/layouts/.private/Baseline_tilted_200_Pixel_1_1_1/index.html
  source muonMomentumResolution.tcl
}



##############
# Track merger
##############

module Merger L1TTrackMerger {
# add InputArray InputArray
  add InputArray L1TChargedHadronMomentumSmearing/chargedHadrons
  add InputArray L1TElectronEnergySmearing/electrons
  add InputArray L1TMuonMomentumSmearing/muons
  set OutputArray tracks
}


#############
#   ECAL
#############

module SimpleCalorimeter L1TECal {
  set ParticleInputArray ParticlePropagator/stableParticles
  set TrackInputArray L1TTrackMerger/tracks

  set TowerOutputArray ecalTowers
  set EFlowTrackOutputArray eflowTracks
  set EFlowTowerOutputArray eflowPhotons

  set IsEcal true

  set EnergyMin 0.5
  set EnergySignificanceMin 1.0

  set SmearTowerCenter true

  set pi [expr {acos(-1)}]

  # lists of the edges of each tower in eta and phi
  # each list starts with the lower edge of the first tower
  # the list ends with the higher edged of the last tower

  # assume 0.02 x 0.02 resolution in eta,phi in the barrel |eta| < 1.5

  set PhiBins {}
  for {set i -180} {$i <= 180} {incr i} {
    add PhiBins [expr {$i * $pi/180.0}]
  }

  # 0.02 unit in eta up to eta = 1.5 (barrel)
  for {set i -85} {$i <= 86} {incr i} {
    set eta [expr {$i * 0.0174}]
    add EtaPhiBins $eta $PhiBins
  }

  # assume 0.02 x 0.02 resolution in eta,phi in the endcaps 1.5 < |eta| < 3.0 (HGCAL- ECAL)

  set PhiBins {}
  for {set i -180} {$i <= 180} {incr i} {
    add PhiBins [expr {$i * $pi/180.0}]
  }

  # 0.02 unit in eta up to eta = 3
  for {set i 1} {$i <= 84} {incr i} {
    set eta [expr { -2.958 + $i * 0.0174}]
    add EtaPhiBins $eta $PhiBins
  }

  for {set i 1} {$i <= 84} {incr i} {
    set eta [expr { 1.4964 + $i * 0.0174}]
    add EtaPhiBins $eta $PhiBins
  }

  # take present CMS granularity for HF

  # 0.175 x (0.175 - 0.35) resolution in eta,phi in the HF 3.0 < |eta| < 5.0
  set PhiBins {}
  for {set i -18} {$i <= 18} {incr i} {
    add PhiBins [expr {$i * $pi/18.0}]
  }

  foreach eta {-5 -4.7 -4.525 -4.35 -4.175 -4 -3.825 -3.65 -3.475 -3.3 -3.125 -2.958 3.125 3.3 3.475 3.65 3.825 4 4.175 4.35 4.525 4.7 5} {
    add EtaPhiBins $eta $PhiBins
  }


  add EnergyFraction {0} {0.0}
  # energy fractions for e, gamma and pi0
  add EnergyFraction {11} {1.0}
  add EnergyFraction {22} {1.0}
  add EnergyFraction {111} {1.0}
  # energy fractions for muon, neutrinos and neutralinos
  add EnergyFraction {12} {0.0}
  add EnergyFraction {13} {0.0}
  add EnergyFraction {14} {0.0}
  add EnergyFraction {16} {0.0}
  add EnergyFraction {1000022} {0.0}
  add EnergyFraction {1000023} {0.0}
  add EnergyFraction {1000025} {0.0}
  add EnergyFraction {1000035} {0.0}
  add EnergyFraction {1000045} {0.0}
  # energy fractions for K0short and Lambda
  add EnergyFraction {310} {0.3}
  add EnergyFraction {3122} {0.3}

  # set ResolutionFormula {resolution formula as a function of eta and energy}

  # for the ECAL barrel (|eta| < 1.5), see hep-ex/1306.2016 and 1502.02701
  # for the endcaps (1.5 < |eta| < 3.0), we take HGCAL  see LHCC-P-008, Fig. 3.39, p.117

  ## add 0.5 factor now since this resolution seems to be worse than fullsim, will smear later to correct for
  set ResolutionFormula {  0.5*( 0.5*(abs(eta) <= 1.50)          * sqrt(energy^2*0.009^2 + energy*0.12^2 + 0.45^2) +
                           (abs(eta) > 1.50 && abs(eta) <= 1.75) * sqrt(energy^2*0.006^2 + energy*0.20^2) + \
                           (abs(eta) > 1.75 && abs(eta) <= 2.15) * sqrt(energy^2*0.007^2 + energy*0.21^2) + \
                           (abs(eta) > 2.15 && abs(eta) <= 3.00) * sqrt(energy^2*0.008^2 + energy*0.24^2) + \
                           (abs(eta) >= 3.0 && abs(eta) <= 5.0)  * sqrt(energy^2*0.08^2 + energy*1.98^2))}

}

#############
#   HCAL
#############

module SimpleCalorimeter L1THCal {
  set ParticleInputArray ParticlePropagator/stableParticles
  set TrackInputArray L1TECal/eflowTracks

  set TowerOutputArray hcalTowers
  set EFlowTrackOutputArray eflowTracks
  set EFlowTowerOutputArray eflowNeutralHadrons

  set IsEcal false

  set EnergyMin 1.0
  set EnergySignificanceMin 1.0

  set SmearTowerCenter true

  set pi [expr {acos(-1)}]

  # lists of the edges of each tower in eta and phi
  # each list starts with the lower edge of the first tower
  # the list ends with the higher edged of the last tower

  # assume 0.087 x 0.087 resolution in eta,phi in the barrel |eta| < 1.5

  set PhiBins {}
  for {set i -36} {$i <= 36} {incr i} {
    add PhiBins [expr {$i * $pi/36.0}]
  }
  foreach eta {-1.566 -1.479 -1.392 -1.305 -1.218 -1.131 -1.044 -0.957 -0.87 -0.783 -0.696 -0.609 -0.522 -0.435 -0.348 -0.261 -0.174 -0.087 0 0.087 0.174 0.261 0.348 0.435 0.522 0.609 0.696 0.783 0.87 0.957 1.044 1.131 1.218 1.305 1.392 1.479 1.566 1.65} {
    add EtaPhiBins $eta $PhiBins
  }

  # assume 0.07 x 0.07 resolution in eta,phi in the endcaps 1.5 < |eta| < 3.0 (HGCAL- HCAL)

  set PhiBins {}
  for {set i -45} {$i <= 45} {incr i} {
    add PhiBins [expr {$i * $pi/45.0}]
  }

  # 0.07 unit in eta up to eta = 3
  for {set i 1} {$i <= 21} {incr i} {
    set eta [expr { -2.958 + $i * 0.0696}]
    add EtaPhiBins $eta $PhiBins
  }

  for {set i 1} {$i <= 21} {incr i} {
    set eta [expr { 1.4964 + $i * 0.0696}]
    add EtaPhiBins $eta $PhiBins
  }

  # take present CMS granularity for HF

  # 0.175 x (0.175 - 0.35) resolution in eta,phi in the HF 3.0 < |eta| < 5.0
  set PhiBins {}
  for {set i -18} {$i <= 18} {incr i} {
    add PhiBins [expr {$i * $pi/18.0}]
  }

  foreach eta {-5 -4.7 -4.525 -4.35 -4.175 -4 -3.825 -3.65 -3.475 -3.3 -3.125 -2.958 3.125 3.3 3.475 3.65 3.825 4 4.175 4.35 4.525 4.7 5} {
    add EtaPhiBins $eta $PhiBins
  }


  # default energy fractions {abs(PDG code)} {Fecal Fhcal}
  add EnergyFraction {0} {1.0}
  # energy fractions for e, gamma and pi0
  add EnergyFraction {11} {0.0}
  add EnergyFraction {22} {0.0}
  add EnergyFraction {111} {0.0}
  # energy fractions for muon, neutrinos and neutralinos
  add EnergyFraction {12} {0.0}
  add EnergyFraction {13} {0.0}
  add EnergyFraction {14} {0.0}
  add EnergyFraction {16} {0.0}
  add EnergyFraction {1000022} {0.0}
  add EnergyFraction {1000023} {0.0}
  add EnergyFraction {1000025} {0.0}
  add EnergyFraction {1000035} {0.0}
  add EnergyFraction {1000045} {0.0}
  # energy fractions for K0short and Lambda
  add EnergyFraction {310} {0.7}
  add EnergyFraction {3122} {0.7}

# set ResolutionFormula {resolution formula as a function of eta and energy}
  set ResolutionFormula {                    (abs(eta) <= 1.5) * sqrt(energy^2*0.05^2 + energy*1.00^2) + \
                                                   (abs(eta) > 1.5 && abs(eta) <= 3.0) * sqrt(energy^2*0.05^2 + energy*1.00^2) + \
                                                   (abs(eta) > 3.0 && abs(eta) <= 5.0) * sqrt(energy^2*0.11^2 + energy*2.80^2)}

}

#################################
# Energy resolution for electrons
#################################

module EnergySmearing L1TPhotonEnergySmearing {
  set InputArray L1TECal/eflowPhotons
  set OutputArray eflowPhotons

  # adding 1% extra photon smearing
  set ResolutionFormula {energy*0.001}

}



#################
# Electron filter
#################

module PdgCodeFilter L1TElectronFilter {
  set InputArray L1THCal/eflowTracks
  set OutputArray electrons
  set Invert true
  add PdgCode {11}
  add PdgCode {-11}
}



##########################
# Track pile-up subtractor
##########################

module TrackPileUpSubtractor L1TTrackPileUpSubtractor {
# add InputArray InputArray OutputArray
  add InputArray L1THCal/eflowTracks eflowTracks
  add InputArray L1TElectronFilter/electrons electrons
  add InputArray L1TMuonMomentumSmearing/muons muons

  set VertexInputArray PileUpMerger/vertices
  # assume perfect pile-up subtraction for tracks with |z| > fZVertexResolution
  # Z vertex resolution in m (naive guess from tkLayout, assumed flat in pt for now)
  
  set ZVertexResolution {
  
     (pt < 10. ) * ( ( -0.8*log10(pt) + 1. ) * (10^(0.5*abs(eta) + 1.5)) * 1e-06 )*10 +
     (pt >= 10. ) * ( ( 0.2 ) * (10^(0.5*abs(eta) + 1.5)) * 1e-06 )*10
     
     }
    #custom L1T 10x worse than FullReco
 }

########################
# Reco PU filter
########################

module RecoPuFilter L1TRecoPuFilter {
  set InputArray L1THCal/eflowTracks
  set OutputArray eflowTracks
}

###################################################
# Tower Merger (in case not using e-flow algorithm)
###################################################

module Merger L1TTowerMerger {
# add InputArray InputArray
  add InputArray L1TECal/ecalTowers
  add InputArray L1THCal/hcalTowers
  set OutputArray towers
}

####################
# Neutral eflow erger
####################

module Merger L1TNeutralEFlowMerger {
# add InputArray InputArray
  add InputArray L1TPhotonEnergySmearing/eflowPhotons
  add InputArray L1THCal/eflowNeutralHadrons
  set OutputArray eflowTowers
}

#####################
# Energy flow merger
#####################

module Merger L1TEFlowMerger {
# add InputArray InputArray
  add InputArray L1THCal/eflowTracks
  add InputArray L1TPhotonEnergySmearing/eflowPhotons
  add InputArray L1THCal/eflowNeutralHadrons
  set OutputArray eflow
}

############################
# Energy flow merger no PU
############################

module Merger L1TEFlowMergerCHS {
# add InputArray InputArray
  add InputArray L1TRecoPuFilter/eflowTracks
  add InputArray L1TPhotonEnergySmearing/eflowPhotons
  add InputArray L1THCal/eflowNeutralHadrons
  set OutputArray eflow
}

#########################################
### Run the puppi code (to be tuned) ###
#########################################

module PdgCodeFilter L1TLeptonFilterNoLep {
  set InputArray L1THCal/eflowTracks
  set OutputArray eflowTracksNoLeptons
  set Invert false
  add PdgCode {13}
  add PdgCode {-13}
  add PdgCode {11}
  add PdgCode {-11}
}

module PdgCodeFilter L1TLeptonFilterLep {
  set InputArray L1THCal/eflowTracks
  set OutputArray eflowTracksLeptons
  set Invert true
  add PdgCode {11}
  add PdgCode {-11}
  add PdgCode {13}
  add PdgCode {-13}
}

module RunPUPPI L1TRunPUPPIBase {
  ## input information
  set TrackInputArray   L1TLeptonFilterNoLep/eflowTracksNoLeptons
  set NeutralInputArray L1TNeutralEFlowMerger/eflowTowers
  set PVInputArray      PileUpMerger/vertices
  set MinPuppiWeight    0.05
  set UseExp            false
  set UseNoLep          false

  ## define puppi algorithm parameters (more than one for the same eta region is possible)
  add EtaMinBin           0.0   1.5   2.5   3.0
  add EtaMaxBin           1.5   2.5   3.0   10.0 
  add PtMinBin            0.0   0.0   0.0   0.0
  add ConeSizeBin         0.3   0.3   0.3   0.3
  add RMSPtMinBin         0.1   0.5   0.5   0.5
  add RMSScaleFactorBin   1.0   1.0   1.0   1.0
  add NeutralMinEBin      1.0   1.0   4.0   10.0
  add NeutralPtSlope      0.006 0.013 0.03  0.03
  add ApplyCHS            true  true  true  true
  add UseCharged          true  true  false false
  add ApplyLowPUCorr      true  true  true  true
  add MetricId            5     5     5     5
  add CombId              0     0     0     0 

  # custom L1T

  ## output name
  set OutputArray         PuppiParticles
  set OutputArrayTracks   puppiTracks
  set OutputArrayNeutrals puppiNeutrals
}

module Merger L1TRunPUPPIMerger {
  add InputArray L1TRunPUPPIBase/PuppiParticles
  add InputArray L1TLeptonFilterLep/eflowTracksLeptons
  set OutputArray PuppiParticles
}

# need this because of leptons that were added back
module RecoPuFilter L1TRunPUPPI {
  set InputArray L1TRunPUPPIMerger/PuppiParticles
  set OutputArray PuppiParticles
}

######################
# L1TEFlowFilterPuppi
######################

module PdgCodeFilter L1TEFlowFilterPuppi {
  set InputArray L1TRunPUPPI/PuppiParticles
  set OutputArray eflow

  add PdgCode {11}
  add PdgCode {-11}
  add PdgCode {13}
  add PdgCode {-13}
}

######################
# EFlowFilterCHS
######################

module PdgCodeFilter EFlowFilterCHS {
  set InputArray L1TEFlowMergerCHS/eflow
  set OutputArray eflow

  add PdgCode {11}
  add PdgCode {-11}
  add PdgCode {13}
  add PdgCode {-13}
}


###################
# Missing ET merger
###################

module Merger MissingET {
# add InputArray InputArray
#  add InputArray L1TRunPUPPI/PuppiParticles
  add InputArray L1TEFlowMerger/eflow
  set MomentumOutputArray momentum
}

module Merger L1TPuppiMissingET {
  #add InputArray InputArray
  add InputArray L1TRunPUPPI/PuppiParticles
  #add InputArray L1TEFlowMerger/eflow
  set MomentumOutputArray momentum
  set UsePUPPI 0
}

#########################
# Ger PileUp Missing ET
#########################

module Merger GenPileUpMissingET {
# add InputArray InputArray
#  add InputArray L1TRunPUPPI/PuppiParticles
  add InputArray ParticlePropagator/stableParticles
  set MomentumOutputArray momentum
}

##################
# Scalar HT merger
##################

module Merger L1TScalarHT {
# add InputArray InputArray
  add InputArray L1TRunPUPPI/PuppiParticles
  set EnergyOutputArray energy
}

#################
# Neutrino Filter
#################

module PdgCodeFilter NeutrinoFilter {

  set InputArray Delphes/stableParticles
  set OutputArray filteredParticles

  set PTMin 0.0

  add PdgCode {12}
  add PdgCode {14}
  add PdgCode {16}
  add PdgCode {-12}
  add PdgCode {-14}
  add PdgCode {-16}

}

#####################
# MC truth jet finder
#####################

module FastJetFinder GenJetFinder {
  set InputArray NeutrinoFilter/filteredParticles

  set OutputArray jets

  # algorithm: 1 CDFJetClu, 2 MidPoint, 3 SIScone, 4 kt, 5 Cambridge/Aachen, 6 antikt
  set JetAlgorithm 6
  set ParameterR 0.4

  set JetPTMin 15.0
}

module FastJetFinder GenJetFinderAK8 {
  set InputArray NeutrinoFilter/filteredParticles

  set OutputArray jetsAK8

  # algorithm: 1 CDFJetClu, 2 MidPoint, 3 SIScone, 4 kt, 5 Cambridge/Aachen, 6 antikt
  set JetAlgorithm 6
  set ParameterR 0.8

  set JetPTMin 200.0
}

#########################
# Gen Missing ET merger
########################

module Merger GenMissingET {

# add InputArray InputArray
  add InputArray NeutrinoFilter/filteredParticles
  set MomentumOutputArray momentum
}


#############
# Rho pile-up
#############

module FastJetGridMedianEstimator L1TRho {

  set InputArray L1TEFlowMergerCHS/eflow
  set RhoOutputArray rho

  # add GridRange rapmin rapmax drap dphi
  # rapmin - the minimum rapidity extent of the grid
  # rapmax - the maximum rapidity extent of the grid
  # drap - the grid spacing in rapidity
  # dphi - the grid spacing in azimuth

  add GridRange -5.0 -4.0 1.0 1.0
  add GridRange -4.0 -1.5 1.0 1.0
  add GridRange -1.5 1.5 1.0 1.0
  add GridRange 1.5 4.0 1.0 1.0
  add GridRange 4.0 5.0 1.0 1.0

}



module FastJetFinder L1TFastJetFinderPUPPI {
#  set InputArray L1TTowerMerger/towers
  set InputArray L1TRunPUPPI/PuppiParticles

  set OutputArray jets

  # algorithm: 1 CDFJetClu, 2 MidPoint, 3 SIScone, 4 kt, 5 Cambridge/Aachen, 6 antikt
  set JetAlgorithm 6
  set ParameterR 0.4
  set UsePUPPI 0

  set JetPTMin 15.0
}


module FastJetFinder L1TFastJetFinderPUPPIAK8 {
#  set InputArray L1TTowerMerger/towers
  set InputArray L1TRunPUPPI/PuppiParticles

  set OutputArray jets

  set JetAlgorithm 6
  set ParameterR 0.8

  set ComputeNsubjettiness 1
  set Beta 1.0
  set AxisMode 4

  set ComputeTrimming 1
  set RTrim 0.2
  set PtFracTrim 0.05

  set ComputePruning 1
  set ZcutPrun 0.1
  set RcutPrun 0.5
  set RPrun 0.8

  set ComputeSoftDrop 1
  set BetaSoftDrop 0.0
  set SymmetryCutSoftDrop 0.1
  set R0SoftDrop 0.8
  set UsePUPPI 0

  set JetPTMin 200.0
}

##################
# Jet Energy Scale
##################


module EnergyScale L1TJetScalePUPPI {
  set InputArray L1TFastJetFinderPUPPI/jets
  set OutputArray jets

 # scale formula for jets
    ### jetpuppi tightID momentum scale
  set ScaleFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 15.0 && pt <= 20.0) * (1.45) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.953) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 50.0) * (0.910) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 75.0) * (0.912) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 75.0 && pt <= 100.0) * (0.930) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 150.0) * (0.953) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 150.0 && pt <= 200.0) * (0.968) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (0.983) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 1000.0) * (0.988) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 1000.0 && pt <= 14000.0) * (0.992) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 15.0 && pt <= 20.0) * (1.200) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (1.103) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 50.0) * (1.037) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 75.0) * (1.007) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 75.0 && pt <= 100.0) * (1.002) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 150.0) * (1.005) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 150.0 && pt <= 200.0) * (1.004) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 500.0) * (1.003) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 1000.0) * (0.997) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 1000.0 && pt <= 14000.0) * (0.996) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 15.0 && pt <= 20.0) * (1.057) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.855) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 50.0) * (0.776) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 75.0) * (0.801) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 75.0 && pt <= 100.0) * (0.810) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 150.0) * (0.860) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 150.0 && pt <= 200.0) * (0.913) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 500.0) * (0.926) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 1000.0) * (0.963) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 1000.0 && pt <= 14000.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 15.0 && pt <= 20.0) * (1.971) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 30.0) * (1.465) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 30.0 && pt <= 50.0) * (1.213) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 75.0) * (1.054) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 75.0 && pt <= 100.0) * (0.986) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 150.0) * (0.957) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 150.0 && pt <= 200.0) * (1.010) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 500.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 1000.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 1000.0 && pt <= 14000.0) * (1.000)
  }

}
module EnergyScale L1TJetScalePUPPIAK8 {
  set InputArray L1TFastJetFinderPUPPIAK8/jets
  set OutputArray jets

 # scale formula for jets
  ## DUMMY_JETAK8_SCALE
  set ScaleFormula {1.00}
  ## ENDDUMMY_JETAK8_SCALE
}

####################
# Jet Energy Smear #
####################


module MomentumSmearing L1TJetSmearPUPPI {
  set InputArray L1TJetScalePUPPI/jets
  set OutputArray jets
  set UseMomentumVector true

 # scale formula for jets
   ### jetpuppi tightID momentum resolution
  set ResolutionFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 15.0 && pt <= 20.0) * (0.60) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.20) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 50.0) * (0.10) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 75.0) * (0.07) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 75.0 && pt <= 100.0) * (0.08) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 150.0) * (0.15) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 150.0 && pt <= 200.0) * (0.08) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (0.08) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 1000.0) * (0.065) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 1000.0 && pt <= 14000.0) * (0.04) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 15.0 && pt <= 20.0) * (0.70) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.70) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 50.0) * (0.35) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 75.0) * (0.27) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 75.0 && pt <= 100.0) * (0.30) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 150.0) * (0.28) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 150.0 && pt <= 200.0) * (0.22) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 500.0) * (0.16) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 1000.0) * (0.10) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 1000.0 && pt <= 14000.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 15.0 && pt <= 20.0) * (0.55) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.47) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 50.0) * (0.38) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 75.0) * (0.25) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 75.0 && pt <= 100.0) * (0.26) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 150.0) * (0.29) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 150.0 && pt <= 200.0) * (0.20) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 500.0) * (0.18) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 1000.0) * (0.11) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 1000.0 && pt <= 14000.0) * (0.05) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 15.0 && pt <= 20.0) * (0.50) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 30.0) * (0.25) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 30.0 && pt <= 50.0) * (0.19) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 75.0) * (0.19) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 75.0 && pt <= 100.0) * (0.08) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 150.0) * (0.04) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 150.0 && pt <= 200.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 500.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 1000.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 1000.0 && pt <= 14000.0) * (0.00)
  } 
}

module MomentumSmearing L1TJetSmearPUPPIAK8 {
  set InputArray L1TJetScalePUPPIAK8/jets
  set OutputArray jets
  set UseMomentumVector true

 ## DUMMY_JETPUPPIAK8_SMEAR
  set ResolutionFormula {1.00e-10}
 ## ENDDUMMY_JETPUPPIAK8_SMEAR
}



#####################
# Jet Id Loose     #
#####################

module Efficiency L1TJetLooseID {

  ## input particles
  set InputArray L1TJetSmearPUPPI/jets
  ## output particles
  set OutputArray jets
  # set EfficiencyFormula {efficiency formula as a function of eta and pt}
  # efficiency formula for jets

  set UseMomentumVector true

    ### jetpuppi loose ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 15.0 && pt <= 16.0) * (0.35) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 18.0) * (0.38) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 18.0 && pt <= 20.0) * (0.42) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 23.0) * (0.48) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 23.0 && pt <= 26.0) * (0.53) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 26.0 && pt <= 30.0) * (0.62) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 36.0) * (0.71) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 36.0 && pt <= 43.0) * (0.81) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 43.0 && pt <= 50.0) * (0.87) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 58.0) * (0.91) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 58.0 && pt <= 66.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 75.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 75.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 91.0) * (0.98) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 15.0 && pt <= 16.0) * (0.36) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 18.0) * (0.39) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 18.0 && pt <= 20.0) * (0.43) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 23.0) * (0.47) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 23.0 && pt <= 26.0) * (0.53) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 26.0 && pt <= 30.0) * (0.61) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 36.0) * (0.7) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 36.0 && pt <= 43.0) * (0.8) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 43.0 && pt <= 50.0) * (0.87) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 58.0) * (0.9) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 58.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 75.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 75.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 91.0) * (0.98) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 15.0 && pt <= 16.0) * (0.44) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 18.0) * (0.45) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 18.0 && pt <= 20.0) * (0.45) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 23.0) * (0.48) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 23.0 && pt <= 26.0) * (0.54) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 26.0 && pt <= 30.0) * (0.6) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 36.0) * (0.69) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 36.0 && pt <= 43.0) * (0.79) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 43.0 && pt <= 50.0) * (0.86) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 58.0) * (0.9) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 58.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 75.0) * (0.95) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 75.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 91.0) * (0.98) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 15.0 && pt <= 16.0) * (0.29) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 18.0) * (0.26) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 18.0 && pt <= 20.0) * (0.26) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 23.0) * (0.28) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 23.0 && pt <= 26.0) * (0.32) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 26.0 && pt <= 30.0) * (0.39) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 36.0) * (0.5) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 36.0 && pt <= 43.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 43.0 && pt <= 50.0) * (0.77) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 58.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 58.0 && pt <= 66.0) * (0.89) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 75.0) * (0.93) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 75.0 && pt <= 83.0) * (0.95) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 91.0) * (0.97) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 91.0 && pt <= 100.0) * (0.98) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 150.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 15.0 && pt <= 16.0) * (0.99) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 18.0) * (0.77) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 18.0 && pt <= 20.0) * (0.61) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 23.0) * (0.55) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 23.0 && pt <= 26.0) * (0.53) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 26.0 && pt <= 30.0) * (0.56) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 36.0) * (0.64) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 36.0 && pt <= 43.0) * (0.75) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 43.0 && pt <= 50.0) * (0.82) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 58.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 58.0 && pt <= 66.0) * (0.91) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 75.0) * (0.94) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 75.0 && pt <= 83.0) * (0.96) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 91.0) * (0.97) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 91.0 && pt <= 100.0) * (0.98) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 15.0 && pt <= 16.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 18.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 18.0 && pt <= 20.0) * (0.81) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 23.0) * (0.67) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 23.0 && pt <= 26.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 26.0 && pt <= 30.0) * (0.62) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 36.0) * (0.67) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 36.0 && pt <= 43.0) * (0.75) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 43.0 && pt <= 50.0) * (0.81) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 58.0) * (0.86) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 58.0 && pt <= 66.0) * (0.9) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 75.0) * (0.93) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 75.0 && pt <= 83.0) * (0.96) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 91.0) * (0.97) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 15.0 && pt <= 16.0) * (0.48) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 16.0 && pt <= 18.0) * (0.43) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 18.0 && pt <= 20.0) * (0.4) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 23.0) * (0.4) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 23.0 && pt <= 26.0) * (0.42) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 26.0 && pt <= 30.0) * (0.46) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 36.0) * (0.51) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 36.0 && pt <= 43.0) * (0.62) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 43.0 && pt <= 50.0) * (0.71) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 58.0) * (0.78) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 58.0 && pt <= 66.0) * (0.84) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 75.0) * (0.88) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 75.0 && pt <= 83.0) * (0.91) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 91.0) * (0.94) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 91.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 116.0) * (0.97) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 183.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 200.0 && pt <= 300.0) * (0.99) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 300.0 && pt <= 400.0) * (0.98) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 15.0 && pt <= 16.0) * (0.061) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 16.0 && pt <= 18.0) * (0.066) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 18.0 && pt <= 20.0) * (0.073) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 23.0) * (0.098) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 23.0 && pt <= 26.0) * (0.13) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 26.0 && pt <= 30.0) * (0.18) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 36.0) * (0.26) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 36.0 && pt <= 43.0) * (0.4) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 43.0 && pt <= 50.0) * (0.54) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 58.0) * (0.66) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 58.0 && pt <= 66.0) * (0.76) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 75.0) * (0.83) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 75.0 && pt <= 83.0) * (0.89) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 91.0) * (0.92) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 91.0 && pt <= 100.0) * (0.95) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 116.0) * (0.97) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 116.0 && pt <= 133.0) * (0.98) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 150.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 166.0 && pt <= 183.0) * (0.99) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 183.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 15.0 && pt <= 16.0) * (0.075) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 18.0) * (0.087) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 18.0 && pt <= 20.0) * (0.11) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 23.0) * (0.13) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 23.0 && pt <= 26.0) * (0.16) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 26.0 && pt <= 30.0) * (0.21) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 36.0) * (0.29) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 36.0 && pt <= 43.0) * (0.4) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 43.0 && pt <= 50.0) * (0.53) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 58.0) * (0.64) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 58.0 && pt <= 66.0) * (0.76) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 75.0) * (0.82) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 75.0 && pt <= 83.0) * (0.9) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 91.0) * (0.94) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 91.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 116.0) * (0.98) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 183.0 && pt <= 200.0) * (0.92) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 15.0 && pt <= 16.0) * (0.33) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 16.0 && pt <= 18.0) * (0.41) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 18.0 && pt <= 20.0) * (0.55) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 20.0 && pt <= 23.0) * (0.55) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 23.0 && pt <= 26.0) * (0.58) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 26.0 && pt <= 30.0) * (0.65) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 30.0 && pt <= 36.0) * (0.67) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 36.0 && pt <= 43.0) * (0.65) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 43.0 && pt <= 50.0) * (0.66) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 50.0 && pt <= 58.0) * (0.69) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 58.0 && pt <= 66.0) * (0.77) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 66.0 && pt <= 75.0) * (0.84) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 75.0 && pt <= 83.0) * (0.87) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 83.0 && pt <= 91.0) * (0.9) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 91.0 && pt <= 100.0) * (0.86) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 100.0 && pt <= 116.0) * (0.97) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 116.0 && pt <= 133.0) * (0.94) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 15.0 && pt <= 16.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 16.0 && pt <= 18.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 18.0 && pt <= 20.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 20.0 && pt <= 23.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 23.0 && pt <= 26.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 26.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 30.0 && pt <= 36.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 36.0 && pt <= 43.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 43.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 50.0 && pt <= 58.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 58.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 66.0 && pt <= 75.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 75.0 && pt <= 83.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 83.0 && pt <= 91.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 91.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 100.0 && pt <= 116.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 15.0 && pt <= 16.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 16.0 && pt <= 18.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 18.0 && pt <= 20.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 23.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 23.0 && pt <= 26.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 26.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 30.0 && pt <= 36.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 36.0 && pt <= 43.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 43.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 58.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 58.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 66.0 && pt <= 75.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 75.0 && pt <= 83.0) * (0.98) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 83.0 && pt <= 91.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 91.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 116.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 5.0 && abs(eta) <= 100000.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 15.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 16.0 && pt <= 18.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 18.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 20.0 && pt <= 23.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 23.0 && pt <= 26.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 26.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 30.0 && pt <= 36.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 36.0 && pt <= 43.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 43.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 50.0 && pt <= 58.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 58.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 66.0 && pt <= 75.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 75.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 83.0 && pt <= 91.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 91.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 100.0 && pt <= 116.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 116.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 133.0 && pt <= 150.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 150.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 166.0 && pt <= 183.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 183.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 500.0 && pt <= 666.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 666.0 && pt <= 833.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 833.0 && pt <= 1000.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 1000.0) * (0.0)  
  }

}



#####################
# Jet Id Tight      #
#####################

module Efficiency L1TJetTightID {

  ## input particles
  set InputArray L1TJetSmearPUPPI/jets
  ## output particles
  set OutputArray jets
  # set EfficiencyFormula {efficiency formula as a function of eta and pt}
  # efficiency formula for jets

  set UseMomentumVector true

    ### jetpuppi tight ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 15.0 && pt <= 16.0) * (0.35) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 18.0) * (0.38) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 18.0 && pt <= 20.0) * (0.42) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 23.0) * (0.48) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 23.0 && pt <= 26.0) * (0.53) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 26.0 && pt <= 30.0) * (0.62) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 36.0) * (0.71) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 36.0 && pt <= 43.0) * (0.81) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 43.0 && pt <= 50.0) * (0.87) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 58.0) * (0.91) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 58.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 75.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 75.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 91.0) * (0.98) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 15.0 && pt <= 16.0) * (0.36) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 18.0) * (0.39) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 18.0 && pt <= 20.0) * (0.43) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 23.0) * (0.47) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 23.0 && pt <= 26.0) * (0.53) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 26.0 && pt <= 30.0) * (0.61) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 36.0) * (0.7) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 36.0 && pt <= 43.0) * (0.8) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 43.0 && pt <= 50.0) * (0.87) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 58.0) * (0.9) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 58.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 75.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 75.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 91.0) * (0.98) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 150.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 15.0 && pt <= 16.0) * (0.44) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 18.0) * (0.45) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 18.0 && pt <= 20.0) * (0.45) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 23.0) * (0.48) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 23.0 && pt <= 26.0) * (0.54) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 26.0 && pt <= 30.0) * (0.6) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 36.0) * (0.69) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 36.0 && pt <= 43.0) * (0.79) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 43.0 && pt <= 50.0) * (0.85) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 58.0) * (0.9) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 58.0 && pt <= 66.0) * (0.92) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 75.0) * (0.95) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 75.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 91.0) * (0.98) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 15.0 && pt <= 16.0) * (0.29) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 18.0) * (0.26) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 18.0 && pt <= 20.0) * (0.26) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 23.0) * (0.28) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 23.0 && pt <= 26.0) * (0.32) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 26.0 && pt <= 30.0) * (0.39) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 36.0) * (0.5) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 36.0 && pt <= 43.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 43.0 && pt <= 50.0) * (0.76) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 58.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 58.0 && pt <= 66.0) * (0.89) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 75.0) * (0.93) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 75.0 && pt <= 83.0) * (0.95) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 91.0) * (0.96) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 91.0 && pt <= 100.0) * (0.98) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 150.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 183.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 15.0 && pt <= 16.0) * (0.99) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 18.0) * (0.76) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 18.0 && pt <= 20.0) * (0.61) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 23.0) * (0.55) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 23.0 && pt <= 26.0) * (0.53) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 26.0 && pt <= 30.0) * (0.56) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 36.0) * (0.64) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 36.0 && pt <= 43.0) * (0.75) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 43.0 && pt <= 50.0) * (0.82) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 58.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 58.0 && pt <= 66.0) * (0.91) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 75.0) * (0.93) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 75.0 && pt <= 83.0) * (0.95) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 91.0) * (0.97) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 91.0 && pt <= 100.0) * (0.98) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 150.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 15.0 && pt <= 16.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 18.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 18.0 && pt <= 20.0) * (0.81) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 23.0) * (0.67) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 23.0 && pt <= 26.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 26.0 && pt <= 30.0) * (0.62) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 36.0) * (0.67) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 36.0 && pt <= 43.0) * (0.75) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 43.0 && pt <= 50.0) * (0.81) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 58.0) * (0.86) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 58.0 && pt <= 66.0) * (0.89) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 75.0) * (0.93) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 75.0 && pt <= 83.0) * (0.96) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 91.0) * (0.97) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 91.0 && pt <= 100.0) * (0.98) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 116.0) * (0.99) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 150.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 15.0 && pt <= 16.0) * (0.48) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 16.0 && pt <= 18.0) * (0.43) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 18.0 && pt <= 20.0) * (0.4) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 23.0) * (0.4) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 23.0 && pt <= 26.0) * (0.42) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 26.0 && pt <= 30.0) * (0.45) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 36.0) * (0.51) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 36.0 && pt <= 43.0) * (0.62) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 43.0 && pt <= 50.0) * (0.71) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 58.0) * (0.77) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 58.0 && pt <= 66.0) * (0.84) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 75.0) * (0.88) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 75.0 && pt <= 83.0) * (0.91) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 91.0) * (0.94) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 91.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 116.0) * (0.97) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 166.0 && pt <= 183.0) * (0.99) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 183.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 200.0 && pt <= 300.0) * (0.99) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 300.0 && pt <= 400.0) * (0.98) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 15.0 && pt <= 16.0) * (0.06) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 16.0 && pt <= 18.0) * (0.065) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 18.0 && pt <= 20.0) * (0.073) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 23.0) * (0.096) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 23.0 && pt <= 26.0) * (0.13) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 26.0 && pt <= 30.0) * (0.18) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 36.0) * (0.26) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 36.0 && pt <= 43.0) * (0.39) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 43.0 && pt <= 50.0) * (0.52) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 58.0) * (0.65) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 58.0 && pt <= 66.0) * (0.75) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 75.0) * (0.82) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 75.0 && pt <= 83.0) * (0.88) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 91.0) * (0.91) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 91.0 && pt <= 100.0) * (0.94) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 116.0) * (0.96) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 116.0 && pt <= 133.0) * (0.97) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 150.0 && pt <= 166.0) * (0.98) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 166.0 && pt <= 183.0) * (0.99) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 183.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 15.0 && pt <= 16.0) * (0.073) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 18.0) * (0.085) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 18.0 && pt <= 20.0) * (0.11) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 23.0) * (0.12) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 23.0 && pt <= 26.0) * (0.15) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 26.0 && pt <= 30.0) * (0.2) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 36.0) * (0.27) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 36.0 && pt <= 43.0) * (0.38) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 43.0 && pt <= 50.0) * (0.5) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 58.0) * (0.62) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 58.0 && pt <= 66.0) * (0.72) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 75.0) * (0.79) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 75.0 && pt <= 83.0) * (0.89) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 91.0) * (0.93) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 91.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 116.0) * (0.97) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 116.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 183.0 && pt <= 200.0) * (0.92) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 15.0 && pt <= 16.0) * (0.32) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 16.0 && pt <= 18.0) * (0.41) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 18.0 && pt <= 20.0) * (0.54) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 20.0 && pt <= 23.0) * (0.54) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 23.0 && pt <= 26.0) * (0.57) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 26.0 && pt <= 30.0) * (0.63) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 30.0 && pt <= 36.0) * (0.66) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 36.0 && pt <= 43.0) * (0.64) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 43.0 && pt <= 50.0) * (0.64) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 50.0 && pt <= 58.0) * (0.67) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 58.0 && pt <= 66.0) * (0.74) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 66.0 && pt <= 75.0) * (0.82) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 75.0 && pt <= 83.0) * (0.84) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 83.0 && pt <= 91.0) * (0.87) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 91.0 && pt <= 100.0) * (0.85) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 100.0 && pt <= 116.0) * (0.96) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 116.0 && pt <= 133.0) * (0.94) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 4.33333333333) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 15.0 && pt <= 16.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 16.0 && pt <= 18.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 18.0 && pt <= 20.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 20.0 && pt <= 23.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 23.0 && pt <= 26.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 26.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 30.0 && pt <= 36.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 36.0 && pt <= 43.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 43.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 50.0 && pt <= 58.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 58.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 66.0 && pt <= 75.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 75.0 && pt <= 83.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 83.0 && pt <= 91.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 91.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 100.0 && pt <= 116.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 4.33333333333 && abs(eta) <= 4.66666666667) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 15.0 && pt <= 16.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 16.0 && pt <= 18.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 18.0 && pt <= 20.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 23.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 23.0 && pt <= 26.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 26.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 30.0 && pt <= 36.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 36.0 && pt <= 43.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 43.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 58.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 58.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 66.0 && pt <= 75.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 75.0 && pt <= 83.0) * (0.98) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 83.0 && pt <= 91.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 91.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 116.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 116.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 133.0 && pt <= 150.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 150.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 166.0 && pt <= 183.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 183.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 666.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 666.0 && pt <= 833.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 833.0 && pt <= 1000.0) * (1.0) +
   (abs(eta) > 4.66666666667 && abs(eta) <= 5.0) * (pt > 1000.0) * (1.0) +
   (abs(eta) > 5.0 && abs(eta) <= 100000.0) * (pt <= 15.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 15.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 16.0 && pt <= 18.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 18.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 20.0 && pt <= 23.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 23.0 && pt <= 26.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 26.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 30.0 && pt <= 36.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 36.0 && pt <= 43.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 43.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 50.0 && pt <= 58.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 58.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 66.0 && pt <= 75.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 75.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 83.0 && pt <= 91.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 91.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 100.0 && pt <= 116.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 116.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 133.0 && pt <= 150.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 150.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 166.0 && pt <= 183.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 183.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 500.0 && pt <= 666.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 666.0 && pt <= 833.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 833.0 && pt <= 1000.0) * (0.0) +
   (abs(eta) > 5.0) * (pt > 1000.0) * (0.0)  
  }

}




#################
# Photon filter
#################

module PdgCodeFilter L1TPhotonFilter {
  set InputArray L1TPhotonEnergySmearing/eflowPhotons
  set OutputArray photons
  set Invert true
  set PTMin 5.0
  add PdgCode {22}
}



####################
# Photon isolation #
####################

module Isolation L1TPhotonIsolation {

  # particle for which calculate the isolation
  set CandidateInputArray L1TPhotonFilter/photons

  # isolation collection
  set IsolationInputArray L1TEFlowFilterPuppi/eflow

  # output array
  set OutputArray photons

  # veto isolation cand. based on proximity to input cand.
  set DeltaRMin 0.01
  set UseMiniCone true

  # isolation cone
  set DeltaRMax 0.3

  # minimum pT
  set PTMin     0.0

  # iso ratio to cut
  set PTRatioMax 9999.

}

##################
# Photon scale #
##################


module EnergyScale L1TPhotonScale {
  set InputArray L1TPhotonIsolation/photons
  set OutputArray photons

    ### photon looseIDISO momentum scale
  set ScaleFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 10.0) * (1.002) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 20.0) * (1.001) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 50.0) * (1.001) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (0.999) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 14000.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 10.0) * (0.998) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 20.0) * (1.001) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 50.0) * (1.001) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 500.0) * (0.999) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 14000.0) * (1.278) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 10.0) * (0.843) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 20.0) * (0.908) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 50.0) * (0.975) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 100.0) * (0.971) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 200.0) * (0.992) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 500.0) * (0.860) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 14000.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 4.0 && pt <= 10.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 10.0 && pt <= 20.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 50.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 500.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 14000.0) * (1.000)  
  }

}


##################
# Photon smear #
##################

module MomentumSmearing L1TPhotonSmear {

  set InputArray L1TPhotonScale/photons
  set OutputArray photons
  set UseMomentumVector true

    ### photon looseIDISO momentum resolution
  set ResolutionFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 10.0) * (0.01) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 20.0) * (0.01) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 50.0) * (0.01) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (0.00) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 14000.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 10.0) * (0.07) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 20.0) * (0.07) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 50.0) * (0.03) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 100.0) * (0.02) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 200.0) * (0.00) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 500.0) * (0.00) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 14000.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 10.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 20.0) * (0.03) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 50.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 100.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 200.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 500.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 14000.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 4.0 && pt <= 10.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 10.0 && pt <= 20.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 50.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 100.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 200.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 500.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 14000.0) * (0.00)  
  }

}




#####################
# Photon Id Loose   #
#####################

module Efficiency L1TPhotonLooseID {

  ## input particles
  set InputArray L1TPhotonSmear/photons
  ## output particles
  set OutputArray photons
  # set EfficiencyFormula {efficiency formula as a function of eta and pt}
  # efficiency formula for photons

  set UseMomentumVector true

    ### photon loose ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.07) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.35) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.56) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.76) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.87) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.89) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.9) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.91) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.92) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.9) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.91) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.91) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.91) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.89) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.88) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.81) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.094) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.42) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.56) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.77) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.88) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.9) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.91) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.9) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.91) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.9) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.91) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.92) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.92) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.91) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.91) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.9) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.16) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.31) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.53) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.73) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.81) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.82) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.84) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.84) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.85) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.85) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.86) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.87) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.83) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.85) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.8) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.25) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.55) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.6) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.58) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.64) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.8) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.81) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.81) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.82) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.82) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.83) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.82) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.83) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0) * (0.83) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.013) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.23) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.67) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.7) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.83) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.93) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.94) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.95) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.95) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.95) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0) * (0.95) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.088) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.39) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.54) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.59) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.78) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.85) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.91) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.95) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.96) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.96) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.95) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.97) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.019) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.024) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.084) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.17) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.21) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.29) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.3) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.41) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.44) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.48) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.56) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.67) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.52) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

}


#####################
# Photon Id Medium   #
#####################

module Efficiency L1TPhotonMediumID {

  ## input particles
  set InputArray L1TPhotonSmear/photons
  ## output particles
  set OutputArray photons
  # set EfficiencyFormula {efficiency formula as a function of eta and pt}
  # efficiency formula for photons
  set UseMomentumVector true

    ### photon medium ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0066) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.093) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.3) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.56) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.75) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.81) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.82) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.82) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.83) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.81) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.81) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.81) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.82) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.78) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.75) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.71) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.017) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.13) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.33) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.61) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.78) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.8) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.8) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.8) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.82) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.81) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.81) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.83) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.84) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.81) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.8) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.82) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0063) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.1) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.33) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.57) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.67) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.67) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.7) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.7) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.73) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.72) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.72) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.76) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.76) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.73) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.79) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.59) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.2) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.44) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.47) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.42) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.5) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.68) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.69) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.71) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.72) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.72) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.72) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.72) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.72) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.722) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.72) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.72) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.72) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.013) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.16) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.54) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.62) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.67) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.76) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.84) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.89) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.89) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.89) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.91) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.9) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.068) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.31) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.47) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.53) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.7) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.79) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.86) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.9) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.91) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.93) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.92) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.86) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.89) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.9) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.9) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.9) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.9) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.012) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.086) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.16) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.2) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.27) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.3) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.41) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.43) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.48) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.56) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.66) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.53) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

}


#####################
# Photon Id Tight   #
#####################

module Efficiency L1TPhotonTightID {

  ## input particles
  set InputArray L1TPhotonSmear/photons
  ## output particles
  set OutputArray photons
  # set EfficiencyFormula {efficiency formula as a function of eta and pt}
  # efficiency formula for photons
  set UseMomentumVector true

  ### photon tight ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.012) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.095) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.34) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.61) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.71) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.71) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.7) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.72) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.72) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.72) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.72) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.722) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.72) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.722) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.72) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.028) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.1) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.43) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.66) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.68) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.69) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.68) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.69) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.68) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.67) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.68) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.69) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.69) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.69) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.69) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0089) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.14) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.4) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.51) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.51) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.54) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.52) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.56) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.54) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.53) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.55) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.54) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.52) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.57) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.57) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.14) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.3) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.34) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.32) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.35) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.63) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.64) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.64) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.64) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.64) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.65) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.65) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.12) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.5) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.55) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.61) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.72) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.82) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.85) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.85) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.84) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.038) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.26) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.46) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.48) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.65) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.81) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.86) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.88) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.88) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.88) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.88) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.88) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.88) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.88) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.88) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.014) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.079) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.14) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.21) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.29) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.31) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.43) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.45) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.48) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.56) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.63) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.63) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.63) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.63) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.63) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.63) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (0.63) +
   (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
}




######################
# Electron isolation #
######################

module Isolation L1TElectronIsolation {

  set CandidateInputArray L1TElectronFilter/electrons

  # isolation collection
  set IsolationInputArray L1TEFlowFilterPuppi/eflow

  set OutputArray electrons

  set DeltaRMax 0.3
  set PTMin 0.0
  set PTRatioMax 9999.

}


##################
# Electron scale #
##################


module EnergyScale L1TElectronScale {
  set InputArray L1TElectronIsolation/electrons
  set OutputArray electrons

    ### electron looseIDISO momentum scale
  set ScaleFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 10.0) * (1.00) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 20.0) * (1.00) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 50.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 14000.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 10.0) * (1.00) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 20.0) * (1.00) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 50.0) * (1.00) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 500.0) * (1.00) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 14000.0) * (1.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 10.0) * (1.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 20.0) * (1.000) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 50.0) * (1.000) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 500.0) * (1.000) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 14000.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 4.0 && pt <= 10.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 10.0 && pt <= 20.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 50.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 500.0) * (1.000) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 14000.0) * (1.000)  
  }

}

##################
# Electron smear #
##################

module MomentumSmearing L1TElectronSmear {

  set InputArray L1TElectronScale/electrons
  set OutputArray electrons
  set UseMomentumVector true

    ### electron looseIDISO momentum resolution
  set ResolutionFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 10.0) * (0.03) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 20.0) * (0.03) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 50.0) * (0.028) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 100.0) * (0.021) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 200.0) * (0.014) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (0.01) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 14000.0) * (0.01) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 10.0) * (0.09) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 20.0) * (0.09) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 50.0) * (0.05) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 100.0) * (0.035) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 200.0) * (0.021) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 500.0) * (0.02) +
   (abs(eta) > 1.5 && abs(eta) <= 3.0) * (pt > 500.0 && pt <= 14000.0) * (0.02) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 10.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 20.0) * (0.04) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 50.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 100.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 200.0) * (0.00) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0 && pt <= 14000.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 4.0 && pt <= 10.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 10.0 && pt <= 20.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 20.0 && pt <= 50.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 50.0 && pt <= 100.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 100.0 && pt <= 200.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 200.0 && pt <= 500.0) * (0.00) +
   (abs(eta) > 4.0 && abs(eta) <= 5.0) * (pt > 500.0 && pt <= 14000.0) * (0.00)  
  }

}



#######################
# Electron loose ID efficiency #
#######################

module Efficiency L1TElectronLooseEfficiency {

  set InputArray L1TElectronSmear/electrons
  set OutputArray electrons
  set UseMomentumVector true

    ### electron loose ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0059) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0079) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.039) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.38) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.54) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.71) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.86) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.93) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.98) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.98) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.98) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0029) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0054) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.032) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.37) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.55) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.69) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.84) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.98) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0034) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0097) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.042) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.26) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.41) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.5) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.71) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.82) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.85) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.85) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.89) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.84) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.87) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.89) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.9) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.92) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.9) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.91) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.01) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.02) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.1) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.37) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.49) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.58) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.66) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.78) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.8) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.85) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.83) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.83) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.84) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.038) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.04) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.2) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.59) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.7) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.72) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.8) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.87) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.9) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.9) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.042) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.07) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.13) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.39) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.49) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.6) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.69) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.8) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.85) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.87) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.87) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.015) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.017) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.061) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.061) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.1) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.12) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.15) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.18) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.18) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.2) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.22) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.17) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.22) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.29) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.3) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.43) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.35) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.44) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }


}

#######################
# Electron medium ID efficiency #
#######################

module Efficiency L1TElectronMediumEfficiency {

  set InputArray L1TElectronSmear/electrons
  set OutputArray electrons
  set UseMomentumVector true

    ### electron medium ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0031) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.019) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.26) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.4) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.58) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.77) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.88) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.93) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.95) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.95) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0031) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.017) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.25) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.37) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.55) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.72) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.86) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.91) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.92) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.96) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0036) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0033) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.026) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.17) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.28) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.41) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.61) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.75) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.8) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.81) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.86) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.85) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.83) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.86) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.87) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.89) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.89) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.007) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.044) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.16) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.28) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.29) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.4) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.63) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.7) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.75) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.75) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.74) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.76) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.76) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.76) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.76) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.76) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.76) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.041) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.024) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.026) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.15) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.42) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.57) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.58) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.69) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.81) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.8) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.81) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.78) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.78) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.021) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.047) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.074) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.29) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.39) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.5) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.58) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.69) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.74) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.016) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.017) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.046) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.055) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.097) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.11) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.15) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.18) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.18) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.19) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.21) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.16) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.21) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.28) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.3) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.39) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.31) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.22) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
}

#######################
# Electron tight ID efficiency #
#######################

module Efficiency L1TElectronTightEfficiency {

  set InputArray L1TElectronSmear/electrons
  set OutputArray electrons
  set UseMomentumVector true

    ### electron tight ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0057) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.1) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.2) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.39) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.65) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.81) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.88) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.91) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.93) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.92) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.93) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.009) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.12) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.22) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.39) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.6) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.79) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.85) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.88) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.89) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.94) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.92) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.95) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0084) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.096) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.18) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.31) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.53) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.69) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.73) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.78) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.81) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.84) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.8) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.84) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.86) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.87) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.87) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.89) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0038) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.02) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.067) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.1) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.14) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.21) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.42) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.53) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.59) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.61) +
   (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.61) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0096) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.024) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.097) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.3) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.45) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.45) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.59) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.71) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.75) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.72) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.74) +
   (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.74) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0059) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.029) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.042) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.21) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.31) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.41) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.5) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.59) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.63) +
   (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.63) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.019) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.016) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.041) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.049) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.098) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.11) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.15) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.18) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.17) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.18) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.19) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.17) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.19) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.26) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.28) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.34) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.17) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.22) +
   (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (1.0) +
   (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
}



##################
# Muon isolation #
##################

module Isolation L1TMuonIsolation {
  set CandidateInputArray L1TMuonMomentumSmearing/muons

  # isolation collection
  set IsolationInputArray L1TEFlowFilterPuppi/eflow

  set OutputArray muons

  set DeltaRMax 0.3
  set PTMin 0.0
  set PTRatioMax 9999.

}


##############
# Muon scale #
##############


module EnergyScale L1TMuonScale {
  set InputArray L1TMuonIsolation/muons
  set OutputArray muons

    ### muon looseIDISO momentum scale
  set ScaleFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 50.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 200.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (1.000) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 14000.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 50.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 100.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 200.0) * (1.001) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 500.0) * (1.000) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 500.0 && pt <= 14000.0) * (1.000)  
  }

}


##############
# Muon smear #
##############

module MomentumSmearing L1TMuonSmear {

  set InputArray L1TMuonScale/muons
  set OutputArray muons
  set UseMomentumVector true

    ### muon looseIDISO momentum resolution
  set ResolutionFormula {
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 50.0) * (0.005) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 100.0) * (0.005) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 200.0) * (0.013) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 500.0) * (0.025) +
   (abs(eta) > 0.0 && abs(eta) <= 1.5) * (pt > 500.0 && pt <= 14000.0) * (0.055) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 50.0) * (0.00) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 100.0) * (0.00) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 200.0) * (0.022) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 500.0) * (0.04) +
   (abs(eta) > 1.5 && abs(eta) <= 2.8) * (pt > 500.0 && pt <= 14000.0) * (0.08)  
  }
}




##################
# Muon Loose Id  #
##################

module Efficiency L1TMuonLooseIdEfficiency {
    set InputArray L1TMuonSmear/muons
    set OutputArray muons
    set UseMomentumVector true
    
      ### muon loose ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.8) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.9) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.81) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.9) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.78) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.96) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.96) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.98) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.97) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 4.0 && pt <= 6.0) * (0.7) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 6.0 && pt <= 8.0) * (0.85) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 8.0 && pt <= 10.0) * (0.92) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 10.0 && pt <= 13.0) * (0.93) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 13.0 && pt <= 16.0) * (0.97) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 16.0 && pt <= 20.0) * (0.98) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 20.0 && pt <= 30.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 30.0 && pt <= 40.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 40.0 && pt <= 50.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 50.0 && pt <= 66.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 83.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 100.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 133.0 && pt <= 166.0) * (0.98) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 200.0 && pt <= 300.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 300.0 && pt <= 400.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 400.0 && pt <= 500.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 500.0) * (0.94) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 4.0 && pt <= 6.0) * (0.83) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 6.0 && pt <= 8.0) * (0.89) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 8.0 && pt <= 10.0) * (0.92) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 10.0 && pt <= 13.0) * (0.96) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 13.0 && pt <= 16.0) * (0.97) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 16.0 && pt <= 20.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 20.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 30.0 && pt <= 40.0) * (1.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 40.0 && pt <= 50.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 50.0 && pt <= 66.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 100.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 133.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 200.0 && pt <= 300.0) * (0.98) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 300.0 && pt <= 400.0) * (0.98) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 400.0 && pt <= 500.0) * (0.96) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 500.0) * (0.9) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 4.0 && pt <= 6.0) * (0.77) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 6.0 && pt <= 8.0) * (0.87) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 8.0 && pt <= 10.0) * (0.94) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 10.0 && pt <= 13.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 13.0 && pt <= 16.0) * (0.98) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 16.0 && pt <= 20.0) * (0.98) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 30.0 && pt <= 40.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 40.0 && pt <= 50.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 66.0 && pt <= 83.0) * (1.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 133.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 166.0 && pt <= 200.0) * (0.97) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 300.0) * (0.98) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 300.0 && pt <= 400.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 400.0 && pt <= 500.0) * (0.94) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 500.0) * (0.95) +
   (abs(eta) > 2.8 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 500.0) * (0.0)  
  }
}

##################
# Muon Medium Id  #
##################

##FIXME!!! sourcing LooseId tcl file because medium does not exists (yet ...)
module Efficiency L1TMuonMediumIdEfficiency {
    set InputArray L1TMuonSmear/muons
    set OutputArray muons
    set UseMomentumVector true

      ### muon medium ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.69) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.8) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.85) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.94) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.97) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.99) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.69) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.75) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.85) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.94) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.98) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.99) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.68) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.79) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.83) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.93) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.96) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.98) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (1.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.99) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.97) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 4.0 && pt <= 6.0) * (0.62) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 6.0 && pt <= 8.0) * (0.71) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 8.0 && pt <= 10.0) * (0.86) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 10.0 && pt <= 13.0) * (0.84) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 13.0 && pt <= 16.0) * (0.91) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 16.0 && pt <= 20.0) * (0.94) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 20.0 && pt <= 30.0) * (0.97) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 30.0 && pt <= 40.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 40.0 && pt <= 50.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 50.0 && pt <= 66.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 83.0 && pt <= 100.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 100.0 && pt <= 133.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 133.0 && pt <= 166.0) * (0.98) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 200.0 && pt <= 300.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 300.0 && pt <= 400.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 400.0 && pt <= 500.0) * (0.99) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 500.0) * (0.94) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 4.0 && pt <= 6.0) * (0.69) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 6.0 && pt <= 8.0) * (0.79) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 8.0 && pt <= 10.0) * (0.86) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 10.0 && pt <= 13.0) * (0.87) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 13.0 && pt <= 16.0) * (0.93) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 16.0 && pt <= 20.0) * (0.97) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 20.0 && pt <= 30.0) * (0.98) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 30.0 && pt <= 40.0) * (1.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 40.0 && pt <= 50.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 50.0 && pt <= 66.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 100.0 && pt <= 133.0) * (1.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 133.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 166.0 && pt <= 200.0) * (0.99) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 200.0 && pt <= 300.0) * (0.98) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 300.0 && pt <= 400.0) * (0.97) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 400.0 && pt <= 500.0) * (0.96) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 500.0) * (0.9) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 4.0 && pt <= 6.0) * (0.65) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 6.0 && pt <= 8.0) * (0.75) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 8.0 && pt <= 10.0) * (0.81) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 10.0 && pt <= 13.0) * (0.94) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 13.0 && pt <= 16.0) * (0.93) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 16.0 && pt <= 20.0) * (0.95) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 30.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 30.0 && pt <= 40.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 40.0 && pt <= 50.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 66.0) * (1.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 66.0 && pt <= 83.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 133.0) * (0.98) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 133.0 && pt <= 166.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 166.0 && pt <= 200.0) * (0.97) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 300.0) * (0.98) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 300.0 && pt <= 400.0) * (0.99) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 400.0 && pt <= 500.0) * (0.94) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 500.0) * (0.94) +
   (abs(eta) > 2.8 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 500.0) * (0.0)  
  }
}

##################
# Muon Tight Id  #
##################

module Efficiency L1TMuonTightIdEfficiency {
    set InputArray L1TMuonSmear/muons
    set OutputArray muons
    set UseMomentumVector true

      ### muon tight ID 

  set EfficiencyFormula {

   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.13) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.24) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.24) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.29) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.4) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.55) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.76) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.89) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.92) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.95) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.95) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.95) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.96) +
   (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.92) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.15) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.17) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.22) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.29) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.37) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.57) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.77) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.88) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.92) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.93) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.98) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.96) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.97) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.95) +
   (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.92) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.13) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.17) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.21) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.27) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.33) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.52) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.76) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.88) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.94) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.95) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.98) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.98) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.96) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.98) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.97) +
   (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.93) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 4.0 && pt <= 6.0) * (0.13) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 6.0 && pt <= 8.0) * (0.15) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 8.0 && pt <= 10.0) * (0.24) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 10.0 && pt <= 13.0) * (0.23) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 13.0 && pt <= 16.0) * (0.35) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 16.0 && pt <= 20.0) * (0.47) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 20.0 && pt <= 30.0) * (0.73) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 30.0 && pt <= 40.0) * (0.87) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 40.0 && pt <= 50.0) * (0.92) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 50.0 && pt <= 66.0) * (0.95) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 66.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 83.0 && pt <= 100.0) * (0.98) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 100.0 && pt <= 133.0) * (0.96) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 133.0 && pt <= 166.0) * (0.94) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 166.0 && pt <= 200.0) * (0.96) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 200.0 && pt <= 300.0) * (0.94) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 300.0 && pt <= 400.0) * (0.94) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 400.0 && pt <= 500.0) * (0.95) +
   (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 500.0) * (0.89) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 4.0 && pt <= 6.0) * (0.14) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 6.0 && pt <= 8.0) * (0.23) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 8.0 && pt <= 10.0) * (0.25) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 10.0 && pt <= 13.0) * (0.27) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 13.0 && pt <= 16.0) * (0.35) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 16.0 && pt <= 20.0) * (0.49) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 20.0 && pt <= 30.0) * (0.72) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 30.0 && pt <= 40.0) * (0.86) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 40.0 && pt <= 50.0) * (0.92) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 50.0 && pt <= 66.0) * (0.92) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 66.0 && pt <= 83.0) * (0.94) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 83.0 && pt <= 100.0) * (0.97) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 100.0 && pt <= 133.0) * (0.94) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 133.0 && pt <= 166.0) * (0.93) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 166.0 && pt <= 200.0) * (0.93) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 200.0 && pt <= 300.0) * (0.95) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 300.0 && pt <= 400.0) * (0.92) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 400.0 && pt <= 500.0) * (0.93) +
   (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 500.0) * (0.89) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 4.0 && pt <= 6.0) * (0.16) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 6.0 && pt <= 8.0) * (0.15) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 8.0 && pt <= 10.0) * (0.2) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 10.0 && pt <= 13.0) * (0.31) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 13.0 && pt <= 16.0) * (0.37) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 16.0 && pt <= 20.0) * (0.49) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 30.0) * (0.75) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 30.0 && pt <= 40.0) * (0.9) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 40.0 && pt <= 50.0) * (0.94) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 66.0) * (0.96) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 66.0 && pt <= 83.0) * (0.97) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 83.0 && pt <= 100.0) * (1.0) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 133.0) * (0.97) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 133.0 && pt <= 166.0) * (0.98) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 166.0 && pt <= 200.0) * (0.96) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 300.0) * (0.97) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 300.0 && pt <= 400.0) * (0.98) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 400.0 && pt <= 500.0) * (0.94) +
   (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 500.0) * (0.94) +
   (abs(eta) > 2.8 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 20.0 && pt <= 30.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 30.0 && pt <= 40.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 40.0 && pt <= 50.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 50.0 && pt <= 66.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 66.0 && pt <= 83.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 83.0 && pt <= 100.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 133.0 && pt <= 166.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 400.0 && pt <= 500.0) * (0.0) +
   (abs(eta) > 2.8) * (pt > 500.0) * (0.0)  
  }
}



module JetFlavorAssociation L1TJetFlavorAssociationPUPPI {

  set PartonInputArray Delphes/partons
  set ParticleInputArray Delphes/allParticles
  set ParticleLHEFInputArray Delphes/allParticlesLHEF
  set JetInputArray L1TJetSmearPUPPI/jets

  set DeltaR 0.5
  set PartonPTMin 10.0
  set PartonEtaMax 4.0

}

module JetFlavorAssociation L1TJetFlavorAssociationPUPPIAK8 {

  set PartonInputArray Delphes/partons
  set ParticleInputArray Delphes/allParticles
  set ParticleLHEFInputArray Delphes/allParticlesLHEF
  set JetInputArray L1TJetSmearPUPPIAK8/jets

  set DeltaR 0.8
  set PartonPTMin 100.0
  set PartonEtaMax 4.0

}




module BTagging L1TBTaggingPUPPILoose {

  set JetInputArray L1TJetSmearPUPPI/jets

  set BitNumber 0

    add EfficiencyFormula {0} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.2) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.14) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.12) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.11) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.085) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.088) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.085) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.11) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.14) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.46) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.21) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.15) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.13) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.11) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.093) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.1) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.096) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.11) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.16) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.45) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.24) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.18) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.14) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.12) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.1) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.1) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.09) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.1) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.15) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.43) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.2) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.13) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.099) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.088) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.076) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.071) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.072) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.1) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.23) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.52) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.21) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.14) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.12) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.1) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.096) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.076) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.081) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.14) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.28) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (0.79) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.25) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.17) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.14) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.11) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.11) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.081) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.11) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.17) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.31) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.75) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.34) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.27) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.22) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.18) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.17) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.15) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.15) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.3) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.71) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (1.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.38) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.31) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.29) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.26) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.23) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.25) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.25) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.29) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.74) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.73) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.67) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.66) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.66) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.69) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.81) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.68) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.97) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.99) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

    add EfficiencyFormula {5} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.85) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.89) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.9) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.92) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.93) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.93) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.93) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.94) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.93) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.95) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.86) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.89) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.9) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.91) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.92) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.93) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.94) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.92) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.91) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.95) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.85) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.88) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.9) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.91) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.92) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.92) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.93) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.92) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.89) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.91) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.89) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.88) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.91) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.92) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.92) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.94) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.92) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.9) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.88) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (1.0) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.88) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.88) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.89) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.93) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.94) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.92) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.92) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.9) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (1.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.87) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.88) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.9) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.92) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.91) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.89) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.87) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.89) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.9) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.89) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.88) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.9) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.87) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.9) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.87) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (1.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.87) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.87) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.89) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.96) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.8) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.8) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.67) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.91) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.95) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (1.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.86) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (1.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.81) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

    add EfficiencyFormula {4} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.59) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.58) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.62) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.59) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.6) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.59) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.57) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.58) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.57) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.76) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.6) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.61) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.59) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.62) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.62) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.59) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.61) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.59) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.67) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.73) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.61) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.61) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.62) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.61) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.59) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.59) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.58) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.53) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.6) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.76) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.57) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.61) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.57) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.59) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.63) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.53) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.6) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.55) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.77) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.57) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.61) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.56) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.55) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.57) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.54) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.52) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.5) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.51) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.64) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (0.75) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.62) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.56) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.56) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.6) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.54) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.59) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.54) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.73) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.67) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (1.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.62) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.66) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.6) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.52) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.54) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.55) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.56) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.75) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.67) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.61) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.59) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.73) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.4) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.5) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.6) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.79) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.87) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.82) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.82) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (1.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.8) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (1.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
}

module BTagging L1TBTaggingPUPPIMedium {

  set JetInputArray L1TJetSmearPUPPI/jets

  set BitNumber 1

    add EfficiencyFormula {0} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.024) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.017) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.0069) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0082) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.018) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.023) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.098) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.025) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.018) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.013) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.015) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.0088) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.017) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.031) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.092) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.028) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.021) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.013) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.01) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.013) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.011) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.017) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.028) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.087) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.022) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.014) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.01) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.0088) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.011) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.012) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.0082) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.0076) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.028) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.067) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.022) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.017) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.01) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.012) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.013) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.0097) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.011) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.021) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.037) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (0.064) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.022) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.017) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.018) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.014) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.017) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.018) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.018) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.025) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.037) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.083) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.037) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.031) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.023) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.024) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.018) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.011) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.0083) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0081) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.14) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.03) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.023) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.027) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.021) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.016) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.0098) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.0051) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.14) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.059) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.072) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.067) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.063) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.057) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.066) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.065) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0014) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.00061) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0038) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0097) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.021) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.044) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.077) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

    add EfficiencyFormula {5} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.72) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.79) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.81) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.84) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.84) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.85) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.87) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.84) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.84) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.83) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.74) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.78) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.81) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.83) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.85) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.86) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.87) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.84) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.82) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.82) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.71) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.77) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.8) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.81) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.83) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.83) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.84) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.81) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.79) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.8) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.76) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.78) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.82) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.83) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.83) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.86) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.85) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.81) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.75) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.78) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.74) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.78) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.77) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.83) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.8) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.83) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.83) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.71) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.86) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (1.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.69) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.72) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.76) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.76) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.74) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.75) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.72) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.78) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.67) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.71) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.71) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.69) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.72) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.74) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.67) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.62) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.62) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.73) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.75) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.8) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.2) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.67) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.48) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.3) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.25) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.14) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

    add EfficiencyFormula {4} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.28) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.24) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.24) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.21) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.21) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.22) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.21) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.3) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.3) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.39) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.29) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.28) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.24) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.25) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.24) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.25) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.24) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.3) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.38) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.4) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.27) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.28) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.28) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.24) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.21) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.21) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.26) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.29) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.38) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.38) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.25) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.24) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.2) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.21) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.24) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.17) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.23) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.31) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.34) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.21) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.23) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.21) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.2) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.2) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.15) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.17) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.22) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.22) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.27) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (0.5) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.26) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.21) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.22) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.23) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.2) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.27) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.25) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.27) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.25) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.21) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.23) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.21) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.19) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.26) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.22) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.75) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.21) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.17) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.2) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.12) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.2) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.17) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.4) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.13) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.2) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.14) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.028) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.023) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
}

module BTagging L1TBTaggingPUPPITight {

  set JetInputArray L1TJetSmearPUPPI/jets

  set BitNumber 2

    add EfficiencyFormula {0} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.0038) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.0012) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0015) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.002) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.00091) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.00027) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.0013) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.003) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.004) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.018) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.0029) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.0022) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.0009) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.0015) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.0025) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.0012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.0016) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.002) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.0024) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.013) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.0018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.003) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.0012) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.0014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.0019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.0018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.0013) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.00082) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.0049) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.018) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.0031) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.00087) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.002) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.00076) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.00057) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.0017) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.0016) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.0035) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.012) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.0022) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.0035) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.0015) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.0024) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.00075) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.00087) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.0021) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.0061) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (0.021) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0015) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.0018) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.0032) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.0019) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0015) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.0019) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.0042) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.019) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.0061) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.0019) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.00061) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.0024) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.0031) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.0032) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.0034) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.0023) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.0023) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0046) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0035) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.003) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0064) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

    add EfficiencyFormula {5} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.54) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.63) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.65) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.7) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.71) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.73) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.75) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.68) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.69) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.66) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.55) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.62) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.66) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.68) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.71) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.74) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.74) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.7) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.64) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.65) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.53) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.6) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.62) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.65) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.68) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.68) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.7) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.63) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.61) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.6) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.58) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.59) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.64) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.66) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.68) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.71) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.7) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.66) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.56) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.56) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.56) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.6) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.58) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.66) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.64) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.71) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.66) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.62) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.71) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (1.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.5) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.51) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.57) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.55) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.56) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.57) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.55) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.78) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.44) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.5) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.55) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.51) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.51) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.57) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.49) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.37) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.37) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.54) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.46) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.6) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.2) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.33) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.23) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.16) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.14) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

    add EfficiencyFormula {4} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.055) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.044) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.039) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.035) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.035) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.055) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.059) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.082) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.087) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.14) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.059) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.044) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.045) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.056) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.029) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.038) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.055) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.096) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.08) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.16) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.055) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.064) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.057) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.057) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.037) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.048) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.068) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.098) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.13) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.097) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 20.0 && pt <= 30.0) * (0.043) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 30.0 && pt <= 40.0) * (0.058) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 40.0 && pt <= 50.0) * (0.042) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 50.0 && pt <= 66.0) * (0.039) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 66.0 && pt <= 83.0) * (0.036) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 83.0 && pt <= 100.0) * (0.035) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 100.0 && pt <= 233.0) * (0.071) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 233.0 && pt <= 366.0) * (0.094) +
         (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 366.0 && pt <= 500.0) * (0.14) +
          (abs(eta) > 1.5 && abs(eta) <= 1.83333333333) * (pt > 500.0) * (0.071) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 20.0 && pt <= 30.0) * (0.056) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 30.0 && pt <= 40.0) * (0.027) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 40.0 && pt <= 50.0) * (0.064) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 50.0 && pt <= 66.0) * (0.046) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 66.0 && pt <= 83.0) * (0.035) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 83.0 && pt <= 100.0) * (0.034) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 100.0 && pt <= 233.0) * (0.041) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 233.0 && pt <= 366.0) * (0.02) +
         (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.83333333333 && abs(eta) <= 2.16666666667) * (pt > 500.0) * (0.25) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.058) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.04) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.057) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.068) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.031) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.048) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.045) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.27) +
         (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.16666666667 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.076) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.058) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.054) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.049) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.041) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.045) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.064) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 20.0 && pt <= 30.0) * (0.042) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 30.0 && pt <= 40.0) * (0.015) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 40.0 && pt <= 50.0) * (0.022) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 50.0 && pt <= 66.0) * (0.038) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 66.0 && pt <= 83.0) * (0.13) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 100.0 && pt <= 233.0) * (0.2) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.021) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.022) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.045) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.5 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

}


module BTagging L1TBTaggingPUPPIAK8Loose {

  set JetInputArray L1TJetSmearPUPPIAK8/jets

  set BitNumber 0

  add EfficiencyFormula {0}      {0.1}

  add EfficiencyFormula {5}      {1.0}

  add EfficiencyFormula {4}      {1.0}
}

module BTagging L1TBTaggingPUPPIAK8Medium {

  set JetInputArray L1TJetSmearPUPPIAK8/jets

  set BitNumber 1

  add EfficiencyFormula {0}      {0.01}

  add EfficiencyFormula {5}      {1.0}

  add EfficiencyFormula {4}      {1.0}
}

module BTagging L1TBTaggingPUPPIAK8Tight {

  set JetInputArray L1TJetSmearPUPPIAK8/jets

  set BitNumber 2

  add EfficiencyFormula {0}      {0.001}

  add EfficiencyFormula {5}      {1.0}

  add EfficiencyFormula {4}      {1.0}

}




#############
# tau-tagging
#############


module TauTagging L1TTauTaggingPUPPILoose {

  set ParticleInputArray Delphes/allParticles
  set PartonInputArray Delphes/partons
  set JetInputArray L1TJetSmearPUPPI/jets

  set DeltaR 0.5
  set TauPTMin 20.0
  set TauEtaMax 4.0
  set BitNumber 0

    add EfficiencyFormula {0} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.01) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.016) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.015) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.014) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.013) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0091) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.0037) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.001) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.00073) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.0018) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.017) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.015) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.014) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.0071) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.005) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.00074) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0011) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.023) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.016) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.016) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.012) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.0051) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.013) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.016) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.017) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.019) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.011) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.011) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 233.0) * (0.0073) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 233.0 && pt <= 366.0) * (0.0025) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 366.0 && pt <= 500.0) * (0.012) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0085) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.012) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.017) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.013) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.012) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.013) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.016) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.013) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.011) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.012) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.021) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.02) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.023) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.013) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.012) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.013) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0086) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.031) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 30.0) * (0.00065) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 40.0) * (0.00047) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 40.0 && pt <= 50.0) * (0.00064) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 66.0) * (0.00058) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 83.0) * (0.00085) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 233.0) * (0.00098) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

  ## DUMMY_TAUTAG_ELECMISTAG_LOOSEID_DUMP
  add EfficiencyFormula {11}      {0.01}
  ## ENDDUMMY_TAUTAG_ELECMISTAG_LOOSEID_DUMP

  ## DUMMY_TAUTAG_MUONMISTAG_LOOSEID_DUMP
  add EfficiencyFormula {13}      {0.01}
  ## ENDDUMMY_TAUTAG_MUONMISTAG_LOOSEID_DUMP

    add EfficiencyFormula {15} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.54) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.66) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.68) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.71) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.73) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.74) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.72) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.71) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.65) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.25) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.53) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.64) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.67) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.7) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.72) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.74) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.72) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.7) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.83) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.5) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.5) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.64) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.68) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.7) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.74) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.72) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.71) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.66) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.5) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.51) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.63) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.65) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.66) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.66) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.67) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 233.0) * (0.68) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 233.0 && pt <= 366.0) * (0.62) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.48) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.58) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.6) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.61) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.61) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.6) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.58) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.73) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.45) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.54) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.58) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.56) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.59) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.62) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.58) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.75) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 40.0) * (0.0059) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 66.0) * (0.0034) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 83.0) * (0.0081) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 233.0) * (0.039) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

}

module TauTagging L1TTauTaggingPUPPIMedium {

  set ParticleInputArray Delphes/allParticles
  set PartonInputArray Delphes/partons
  set JetInputArray L1TJetSmearPUPPI/jets

  set DeltaR 0.5
  set TauPTMin 20.0
  set TauEtaMax 4.0

  set BitNumber 1

    add EfficiencyFormula {0} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.0061) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.0079) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0071) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.0065) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.0069) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0046) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.0016) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.00067) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.00073) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.0014) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.0069) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.0093) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.0068) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.006) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.0045) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.0029) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.0024) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.00037) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0011) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.0098) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.015) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.011) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.008) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.0064) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.0056) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.0021) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.0084) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.009) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.0096) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.01) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.007) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.0047) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 233.0) * (0.0034) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 366.0 && pt <= 500.0) * (0.0025) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0028) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0073) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.0089) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.007) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.0069) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.0062) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0098) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.0064) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.0032) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.0073) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.011) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.01) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.011) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.0065) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.009) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.0058) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0086) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 30.0) * (0.00065) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 40.0 && pt <= 50.0) * (0.00064) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 66.0) * (0.00058) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 233.0) * (0.00098) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

  ## DUMMY_TAUTAG_ELECMISTAG_MEDIUMID_DUMP
  add EfficiencyFormula {11}      {0.002}
  ## ENDDUMMY_TAUTAG_ELECMISTAG_MEDIUMID_DUMP

  ## DUMMY_TAUTAG_MUONMISTAG_MEDIUMID_DUMP
  add EfficiencyFormula {13}      {0.002}
  ## ENDDUMMY_TAUTAG_MUONMISTAG_MEDIUMID_DUMP


    add EfficiencyFormula {15} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.45) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.54) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.57) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.59) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.61) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.63) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.61) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.58) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.62) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.25) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.44) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.53) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.55) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.59) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.61) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.63) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.61) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.58) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.67) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.42) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.51) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.56) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.59) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.61) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.62) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.61) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.63) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.71) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.42) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.52) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.53) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.55) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.56) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.58) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 233.0) * (0.57) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 233.0 && pt <= 366.0) * (0.54) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 366.0 && pt <= 500.0) * (1.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.38) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.46) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.5) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.49) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.51) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.49) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.5) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.55) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.34) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.41) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.45) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.42) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.43) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.51) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.51) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.5) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 40.0) * (0.0059) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 66.0) * (0.0034) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 233.0) * (0.039) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
}

module TauTagging L1TTauTaggingPUPPITight {

  set ParticleInputArray Delphes/allParticles
  set PartonInputArray Delphes/partons
  set JetInputArray L1TJetSmearPUPPI/jets

  set DeltaR 0.5
  set TauPTMin 20.0
  set TauEtaMax 4.0

  set BitNumber 2

    add EfficiencyFormula {0} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.0038) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.0044) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0037) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.0029) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.0035) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0018) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.00064) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.00067) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.00073) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.00046) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.0047) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.0056) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.0037) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.0026) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.0021) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.0012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.00085) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0011) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.0067) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.0086) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.0061) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.0041) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.0024) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.0025) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.0015) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.0058) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.0051) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.0051) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.0063) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.0039) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.0022) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 233.0) * (0.0021) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 366.0 && pt <= 500.0) * (0.0025) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0028) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0045) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.0053) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.0028) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.0036) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.0034) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0051) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.004) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.0032) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.0043) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.0059) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.0052) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.0046) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.004) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.006) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.0024) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.0043) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 30.0) * (0.00065) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 40.0 && pt <= 50.0) * (0.00064) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 233.0) * (0.00098) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

  ## DUMMY_TAUTAG_ELECMISTAG_TIGHTID_DUMP
  add EfficiencyFormula {11}      {0.001}
  ## ENDDUMMY_TAUTAG_ELECMISTAG_TIGHTID_DUMP

  ## DUMMY_TAUTAG_MUONMISTAG_TIGHTID_DUMP
  add EfficiencyFormula {13}      {0.001}
  ## ENDDUMMY_TAUTAG_MUONMISTAG_TIGHTID_DUMP

    add EfficiencyFormula {15} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.36) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.43) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.47) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.48) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.51) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.52) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 233.0) * (0.49) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 233.0 && pt <= 366.0) * (0.5) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 366.0 && pt <= 500.0) * (0.54) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.25) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.35) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.43) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.44) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.48) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.49) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.52) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 233.0) * (0.5) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 233.0 && pt <= 366.0) * (0.44) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 366.0 && pt <= 500.0) * (0.61) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.34) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.41) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.45) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.48) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.5) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.51) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 233.0) * (0.5) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 233.0 && pt <= 366.0) * (0.53) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 366.0 && pt <= 500.0) * (0.71) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.33) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.4) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.43) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.45) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.46) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.48) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 233.0) * (0.46) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 233.0 && pt <= 366.0) * (0.43) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 366.0 && pt <= 500.0) * (0.5) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.3) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.35) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.39) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.39) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.41) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.39) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 233.0) * (0.42) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 233.0 && pt <= 366.0) * (0.45) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.24) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.31) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.32) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.3) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.32) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.41) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 233.0) * (0.36) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 233.0 && pt <= 366.0) * (0.5) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 30.0 && pt <= 40.0) * (0.0029) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 50.0 && pt <= 66.0) * (0.0034) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 100.0 && pt <= 233.0) * (0.02) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 3.33333333333) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.33333333333 && abs(eta) <= 3.66666666667) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt <= 20.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
         (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.66666666667 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 233.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 233.0 && pt <= 366.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 366.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }

}



#################################
# Jet Fake Particle Maker Loose #
#################################

module JetFakeParticle L1TJetFakeMakerLoose {

  set InputArray L1TJetSmearPUPPI/jets
  set PhotonOutputArray photons
  set MuonOutputArray muons
  set ElectronOutputArray electrons
  set JetOutputArray jets

  set EfficiencyFormula {
    {11} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.00032) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.00059) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.0008) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.00093) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.00092) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0012) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.0025) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0026) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.0055) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.0049) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.012) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.00025) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.00052) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.00097) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.0012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.001) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.0011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.0014) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.00074) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.00089) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.0014) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.0036) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.0059) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.007) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.013) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.00042) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.00066) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.0014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.0019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.0018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.0019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.0028) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.0029) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.0026) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.005) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.0059) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.0076) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.014) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.019) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.0048) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.0071) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.0086) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.0087) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.0056) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.0044) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.0022) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.0024) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.0027) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.00065) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.00029) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.00016) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0036) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.008) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.013) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.012) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.01) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0073) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.005) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.0064) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.0021) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.0026) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.002) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.00093) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.00055) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.0015) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.0021) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.0043) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.0094) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.014) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.017) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.022) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.03) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.039) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.049) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.058) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.047) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.029) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.00098) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0017) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0047) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.013) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.024) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.034) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.031) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.059) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.039) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.048) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.25) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
    {13} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.0067) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.0068) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.01) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0093) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.0089) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.0084) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0093) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.0099) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.0096) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.0069) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0071) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.0068) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.0043) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.0052) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.01) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.013) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.013) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.013) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.015) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.013) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.0076) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.007) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0082) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.016) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.02) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.022) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.02) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.022) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.024) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.017) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.017) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.015) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.013) +
          (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 20.0 && pt <= 30.0) * (0.014) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 30.0 && pt <= 40.0) * (0.017) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 40.0 && pt <= 50.0) * (0.025) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 50.0 && pt <= 66.0) * (0.027) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 66.0 && pt <= 83.0) * (0.027) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 83.0 && pt <= 100.0) * (0.035) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 100.0 && pt <= 133.0) * (0.039) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 133.0 && pt <= 166.0) * (0.032) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 166.0 && pt <= 200.0) * (0.024) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 200.0 && pt <= 300.0) * (0.024) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 300.0 && pt <= 400.0) * (0.017) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 400.0 && pt <= 500.0) * (0.014) +
          (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 500.0) * (0.012) +
          (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 20.0 && pt <= 30.0) * (0.0092) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 30.0 && pt <= 40.0) * (0.009) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 40.0 && pt <= 50.0) * (0.0098) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 50.0 && pt <= 66.0) * (0.011) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 66.0 && pt <= 83.0) * (0.013) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 83.0 && pt <= 100.0) * (0.014) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 100.0 && pt <= 133.0) * (0.014) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 133.0 && pt <= 166.0) * (0.018) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 166.0 && pt <= 200.0) * (0.013) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 200.0 && pt <= 300.0) * (0.011) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 300.0 && pt <= 400.0) * (0.0046) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 400.0 && pt <= 500.0) * (0.0072) +
          (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 500.0) * (0.0066) +
          (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 30.0) * (0.0039) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 30.0 && pt <= 40.0) * (0.0035) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 40.0 && pt <= 50.0) * (0.0035) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 66.0) * (0.0039) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 66.0 && pt <= 83.0) * (0.0046) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 83.0 && pt <= 100.0) * (0.0041) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0044) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 133.0 && pt <= 166.0) * (0.0036) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0035) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0054) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0085) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 400.0 && pt <= 500.0) * (0.014) +
          (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.8 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 20.0 && pt <= 30.0) * (0.00066) +
          (abs(eta) > 2.8) * (pt > 30.0 && pt <= 40.0) * (0.0005) +
          (abs(eta) > 2.8) * (pt > 40.0 && pt <= 50.0) * (0.00054) +
          (abs(eta) > 2.8) * (pt > 50.0 && pt <= 66.0) * (0.0005) +
          (abs(eta) > 2.8) * (pt > 66.0 && pt <= 83.0) * (0.00063) +
          (abs(eta) > 2.8) * (pt > 83.0 && pt <= 100.0) * (0.00057) +
          (abs(eta) > 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0015) +
          (abs(eta) > 2.8) * (pt > 133.0 && pt <= 166.0) * (0.00041) +
          (abs(eta) > 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0008) +
          (abs(eta) > 2.8) * (pt > 200.0 && pt <= 300.0) * (0.001) +
          (abs(eta) > 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0039) +
          (abs(eta) > 2.8) * (pt > 400.0 && pt <= 500.0) * (0.045) +
          (abs(eta) > 2.8) * (pt > 500.0) * (0.0)  
  }
    {22} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.00063) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.00093) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.0012) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0013) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.0013) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.0012) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.0012) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.00073) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.00059) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.00056) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.00077) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.00099) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.0016) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.0017) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.0014) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.0016) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.00075) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.0015) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.0012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.001) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.0011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.001) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.0022) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0009) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.00092) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.0012) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.0019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.0021) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.0018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.0016) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.0012) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.0018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.0012) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.0011) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.0016) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.00087) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.0022) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0012) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.0077) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.01) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.012) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.011) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.012) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.0092) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.0062) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.0037) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.0031) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.0013) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.0012) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.00047) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.00016) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0051) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.011) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.016) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.018) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.016) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.013) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.011) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.012) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.0093) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.012) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.013) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.014) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0088) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.0016) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.0022) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.004) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.0082) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.014) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.018) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.023) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.035) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.056) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.067) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.11) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.098) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.053) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.00076) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0013) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0034) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.008) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.015) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.024) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.022) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.047) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.037) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.037) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.25) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
  }

}


#################################
# Jet Fake Particle Maker Medium #
#################################

module JetFakeParticle L1TJetFakeMakerMedium {

  set InputArray L1TJetSmearPUPPI/jets
  set PhotonOutputArray photons
  set MuonOutputArray muons
  set ElectronOutputArray electrons
  set JetOutputArray jets

  set EfficiencyFormula {
    {11} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.00015) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.00025) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.00039) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0005) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.00046) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.00027) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.00055) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.00045) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.00027) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.0011) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.001) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.0013) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.0014) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.0043) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.00012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.00023) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.00053) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.00045) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.00048) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.0006) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.0005) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.00046) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.00044) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.0004) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.0011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.0016) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.0028) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0047) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.00028) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.00023) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.00064) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.00072) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.00089) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.00087) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.0013) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.0014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.0012) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.002) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.0016) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.0028) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.0036) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0091) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.0013) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.0022) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.0024) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.0024) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.002) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.0019) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.0015) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.00079) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.0017) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.00022) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.00029) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0015) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.0037) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.0058) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.0045) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.0041) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0025) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.0026) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.002) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.0013) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.0012) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.00067) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.00095) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.0022) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.0043) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.0063) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.0074) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.0097) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.013) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.015) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.019) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.03) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.019) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.00061) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0012) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0033) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0081) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.015) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.018) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.016) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.034) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.03) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.027) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.25) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
    {13} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.0059) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.006) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.0095) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0087) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.0082) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.008) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.0086) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.009) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.0085) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.0062) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0067) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.0063) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.0039) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.0048) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.01) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.0087) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.011) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.01) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.014) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.01) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.01) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.0069) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.0066) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0072) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.015) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.02) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.017) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.02) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.022) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.017) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.017) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.013) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.011) +
          (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 20.0 && pt <= 30.0) * (0.012) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 30.0 && pt <= 40.0) * (0.015) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 40.0 && pt <= 50.0) * (0.024) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 50.0 && pt <= 66.0) * (0.025) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 66.0 && pt <= 83.0) * (0.026) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 83.0 && pt <= 100.0) * (0.034) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 100.0 && pt <= 133.0) * (0.038) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 133.0 && pt <= 166.0) * (0.03) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 166.0 && pt <= 200.0) * (0.023) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 200.0 && pt <= 300.0) * (0.023) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 300.0 && pt <= 400.0) * (0.016) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 400.0 && pt <= 500.0) * (0.012) +
          (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 500.0) * (0.011) +
          (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 20.0 && pt <= 30.0) * (0.0078) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 30.0 && pt <= 40.0) * (0.0078) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 40.0 && pt <= 50.0) * (0.0087) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 50.0 && pt <= 66.0) * (0.0098) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 66.0 && pt <= 83.0) * (0.011) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 83.0 && pt <= 100.0) * (0.014) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 100.0 && pt <= 133.0) * (0.013) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 133.0 && pt <= 166.0) * (0.017) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 166.0 && pt <= 200.0) * (0.013) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 200.0 && pt <= 300.0) * (0.011) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 300.0 && pt <= 400.0) * (0.0041) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 400.0 && pt <= 500.0) * (0.0072) +
          (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 500.0) * (0.0066) +
          (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 30.0) * (0.0033) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 30.0 && pt <= 40.0) * (0.0028) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 40.0 && pt <= 50.0) * (0.0029) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 66.0) * (0.0032) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 66.0 && pt <= 83.0) * (0.0035) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 83.0 && pt <= 100.0) * (0.0041) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0042) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 133.0 && pt <= 166.0) * (0.0036) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0023) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0041) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0063) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 400.0 && pt <= 500.0) * (0.0028) +
          (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.8 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 20.0 && pt <= 30.0) * (0.00052) +
          (abs(eta) > 2.8) * (pt > 30.0 && pt <= 40.0) * (0.0004) +
          (abs(eta) > 2.8) * (pt > 40.0 && pt <= 50.0) * (0.00041) +
          (abs(eta) > 2.8) * (pt > 50.0 && pt <= 66.0) * (0.00039) +
          (abs(eta) > 2.8) * (pt > 66.0 && pt <= 83.0) * (0.0005) +
          (abs(eta) > 2.8) * (pt > 83.0 && pt <= 100.0) * (0.00048) +
          (abs(eta) > 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0011) +
          (abs(eta) > 2.8) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0039) +
          (abs(eta) > 2.8) * (pt > 400.0 && pt <= 500.0) * (0.023) +
          (abs(eta) > 2.8) * (pt > 500.0) * (0.0)  
  }
    {22} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (9.8e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.00042) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.00064) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.0006) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.00079) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.00062) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.00055) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.0008) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.00068) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.00055) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0007) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.00079) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.00059) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.00042) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.00032) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.00045) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.00074) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.00093) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.00063) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.00099) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.00033) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.0012) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.00074) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.0006) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.00098) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.00087) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.0013) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.00064) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.00023) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.00041) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.00099) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.00087) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.00093) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.0007) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.00046) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.001) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.00083) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.00091) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.0012) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.00065) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.00082) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.00063) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.0043) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.0054) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.0062) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.0051) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.005) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.0046) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.0037) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.0018) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.0024) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.00022) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.00088) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0031) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.0065) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.0097) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.0097) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.0094) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0064) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.0072) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.0073) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.0047) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.0055) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.006) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.0065) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0033) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.00097) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.0013) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.0025) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.0047) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.0078) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.01) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.015) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.024) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.042) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.053) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.084) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.074) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.029) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.00051) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0009) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0023) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0056) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.01) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.017) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.016) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.035) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.025) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.037) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
  }

}

#################################
# Jet Fake Particle Maker Tight #
#################################

module JetFakeParticle L1TJetFakeMakerTight {

  set InputArray L1TJetSmearPUPPI/jets
  set PhotonOutputArray photons
  set MuonOutputArray muons
  set ElectronOutputArray electrons
  set JetOutputArray jets

  set EfficiencyFormula {
    {11} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (2.4e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (4.4e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.00013) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.00014) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.0002) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (7.7e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.00031) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (8.9e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.00014) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.00036) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0001) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.00016) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.0002) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.0014) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (7.4e-05) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (5.4e-05) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.00019) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.0001) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.0002) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.00024) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.00025) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (9.2e-05) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.0003) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.0002) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.00055) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.0018) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.0019) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.00014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (5.3e-05) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.00023) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.0003) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.00046) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.00026) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.00055) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.00084) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.0005) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.0014) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.00092) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.0015) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.0019) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.0041) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.00044) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.00056) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.00065) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.00077) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.0011) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.00088) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.00075) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.00026) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.00034) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0007) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.0017) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.003) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.0022) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.0018) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0011) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.00095) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.00087) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.00042) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.00029) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.00033) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.00046) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.0011) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.002) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.0033) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.0036) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.0039) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.0055) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.0071) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.0095) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.005) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.019) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0004) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.00086) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0025) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0055) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.01) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.011) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0075) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.025) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.014) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.027) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
    {13} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (0.00012) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.00015) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.00012) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (9.9e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.00018) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (7.7e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (7.9e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.00018) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0001) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.00016) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (9.3e-05) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.00015) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.00021) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.00013) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.00023) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.00015) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.00016) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.00025) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.0003) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.0002) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.00055) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.00017) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.00022) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.00016) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (0.00042) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.00031) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.00019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.00019) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.00018) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.00039) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.00031) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.00017) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.00043) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.00027) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (7.9e-05) +
          (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 20.0 && pt <= 30.0) * (0.0003) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 30.0 && pt <= 40.0) * (0.00043) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 40.0 && pt <= 50.0) * (0.00019) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 50.0 && pt <= 66.0) * (0.00031) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 66.0 && pt <= 83.0) * (0.00052) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 83.0 && pt <= 100.0) * (0.0012) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 100.0 && pt <= 133.0) * (0.00056) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 133.0 && pt <= 166.0) * (0.00059) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 166.0 && pt <= 200.0) * (0.00038) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 200.0 && pt <= 300.0) * (0.00024) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 400.0 && pt <= 500.0) * (0.00052) +
          (abs(eta) > 1.5 && abs(eta) <= 1.93333333333) * (pt > 500.0) * (0.00034) +
          (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 20.0 && pt <= 30.0) * (0.00028) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 30.0 && pt <= 40.0) * (0.00026) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 40.0 && pt <= 50.0) * (0.00025) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 50.0 && pt <= 66.0) * (0.00037) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 66.0 && pt <= 83.0) * (0.00039) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 83.0 && pt <= 100.0) * (0.00017) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 100.0 && pt <= 133.0) * (0.00028) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 133.0 && pt <= 166.0) * (0.0) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 166.0 && pt <= 200.0) * (0.00047) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 200.0 && pt <= 300.0) * (0.00031) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 300.0 && pt <= 400.0) * (0.00051) +
         (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.93333333333 && abs(eta) <= 2.36666666667) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 20.0 && pt <= 30.0) * (0.00017) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 30.0 && pt <= 40.0) * (0.00014) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 40.0 && pt <= 50.0) * (0.00022) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 50.0 && pt <= 66.0) * (0.00015) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 66.0 && pt <= 83.0) * (0.00038) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 83.0 && pt <= 100.0) * (0.0004) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 100.0 && pt <= 133.0) * (0.00024) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 133.0 && pt <= 166.0) * (0.00036) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 166.0 && pt <= 200.0) * (0.00059) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0018) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.36666666667 && abs(eta) <= 2.8) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.8 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 20.0 && pt <= 30.0) * (2.7e-05) +
          (abs(eta) > 2.8) * (pt > 30.0 && pt <= 40.0) * (1.3e-05) +
          (abs(eta) > 2.8) * (pt > 40.0 && pt <= 50.0) * (2e-05) +
          (abs(eta) > 2.8) * (pt > 50.0 && pt <= 66.0) * (8.6e-06) +
          (abs(eta) > 2.8) * (pt > 66.0 && pt <= 83.0) * (2.5e-05) +
          (abs(eta) > 2.8) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 100.0 && pt <= 133.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 300.0 && pt <= 400.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 2.8) * (pt > 500.0) * (0.0)  
  }
    {22} {

          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 16.0 && pt <= 20.0) * (2.4e-05) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 20.0 && pt <= 30.0) * (0.00018) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 30.0 && pt <= 40.0) * (0.00023) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 40.0 && pt <= 50.0) * (0.00032) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 50.0 && pt <= 66.0) * (0.00036) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 66.0 && pt <= 83.0) * (0.00035) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 83.0 && pt <= 100.0) * (0.00031) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 100.0 && pt <= 133.0) * (0.00045) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 133.0 && pt <= 166.0) * (0.00027) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 166.0 && pt <= 200.0) * (0.00036) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 200.0 && pt <= 300.0) * (0.0005) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 300.0 && pt <= 400.0) * (0.00031) +
         (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 400.0 && pt <= 500.0) * (0.00039) +
          (abs(eta) > 0.0 && abs(eta) <= 0.5) * (pt > 500.0) * (0.00023) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 16.0 && pt <= 20.0) * (0.00022) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 20.0 && pt <= 30.0) * (0.00016) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 30.0 && pt <= 40.0) * (0.00031) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 40.0 && pt <= 50.0) * (0.00045) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 50.0 && pt <= 66.0) * (0.00041) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 66.0 && pt <= 83.0) * (0.00056) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 83.0 && pt <= 100.0) * (0.00025) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 100.0 && pt <= 133.0) * (0.00074) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 133.0 && pt <= 166.0) * (0.00059) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 166.0 && pt <= 200.0) * (0.0002) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 200.0 && pt <= 300.0) * (0.00066) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 300.0 && pt <= 400.0) * (0.00069) +
         (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 400.0 && pt <= 500.0) * (0.0013) +
          (abs(eta) > 0.5 && abs(eta) <= 1.0) * (pt > 500.0) * (0.00048) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 16.0 && pt <= 20.0) * (4.6e-05) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 20.0 && pt <= 30.0) * (0.00015) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 30.0 && pt <= 40.0) * (0.00039) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 40.0 && pt <= 50.0) * (0.00032) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 50.0 && pt <= 66.0) * (0.00037) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 66.0 && pt <= 83.0) * (0.00026) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 83.0 && pt <= 100.0) * (9.2e-05) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 100.0 && pt <= 133.0) * (0.00073) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 133.0 && pt <= 166.0) * (0.0005) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 166.0 && pt <= 200.0) * (0.00091) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 200.0 && pt <= 300.0) * (0.00065) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 300.0 && pt <= 400.0) * (0.00043) +
         (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 400.0 && pt <= 500.0) * (0.00055) +
          (abs(eta) > 1.0 && abs(eta) <= 1.5) * (pt > 500.0) * (0.00032) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 20.0 && pt <= 30.0) * (0.0023) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 30.0 && pt <= 40.0) * (0.0029) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 40.0 && pt <= 50.0) * (0.0029) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 50.0 && pt <= 66.0) * (0.0024) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 66.0 && pt <= 83.0) * (0.0033) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 83.0 && pt <= 100.0) * (0.0026) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 100.0 && pt <= 133.0) * (0.002) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 133.0 && pt <= 166.0) * (0.00026) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 166.0 && pt <= 200.0) * (0.0014) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 200.0 && pt <= 300.0) * (0.00022) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 300.0 && pt <= 400.0) * (0.00029) +
         (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 1.5 && abs(eta) <= 2.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 20.0 && pt <= 30.0) * (0.0022) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 30.0 && pt <= 40.0) * (0.0044) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 40.0 && pt <= 50.0) * (0.0064) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 50.0 && pt <= 66.0) * (0.0062) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 66.0 && pt <= 83.0) * (0.0062) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 83.0 && pt <= 100.0) * (0.0038) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 100.0 && pt <= 133.0) * (0.0052) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 133.0 && pt <= 166.0) * (0.0032) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 166.0 && pt <= 200.0) * (0.0034) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 200.0 && pt <= 300.0) * (0.0029) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 300.0 && pt <= 400.0) * (0.004) +
         (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 400.0 && pt <= 500.0) * (0.0037) +
          (abs(eta) > 2.0 && abs(eta) <= 2.5) * (pt > 500.0) * (0.00055) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 20.0 && pt <= 30.0) * (0.00065) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 30.0 && pt <= 40.0) * (0.00084) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 40.0 && pt <= 50.0) * (0.0018) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 50.0 && pt <= 66.0) * (0.0032) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 66.0 && pt <= 83.0) * (0.0051) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 83.0 && pt <= 100.0) * (0.0067) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 100.0 && pt <= 133.0) * (0.01) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 133.0 && pt <= 166.0) * (0.017) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 166.0 && pt <= 200.0) * (0.031) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 200.0 && pt <= 300.0) * (0.041) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 300.0 && pt <= 400.0) * (0.064) +
         (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 400.0 && pt <= 500.0) * (0.047) +
          (abs(eta) > 2.5 && abs(eta) <= 3.0) * (pt > 500.0) * (0.012) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt <= 4.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 20.0 && pt <= 30.0) * (0.00037) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 30.0 && pt <= 40.0) * (0.00068) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0018) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0044) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0081) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 83.0 && pt <= 100.0) * (0.011) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 100.0 && pt <= 133.0) * (0.011) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 133.0 && pt <= 166.0) * (0.028) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 166.0 && pt <= 200.0) * (0.021) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 200.0 && pt <= 300.0) * (0.027) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
         (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 3.0 && abs(eta) <= 4.0) * (pt > 500.0) * (0.0) +
          (abs(eta) > 4.0 && abs(eta) <= 100000.0) * (pt <= 4.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 4.0 && pt <= 6.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 6.0 && pt <= 8.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 8.0 && pt <= 10.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 10.0 && pt <= 13.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 13.0 && pt <= 16.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 16.0 && pt <= 20.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 20.0 && pt <= 30.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 30.0 && pt <= 40.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 40.0 && pt <= 50.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 50.0 && pt <= 66.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 66.0 && pt <= 83.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 83.0 && pt <= 100.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 100.0 && pt <= 133.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 133.0 && pt <= 166.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 166.0 && pt <= 200.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 200.0 && pt <= 300.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 300.0 && pt <= 400.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 400.0 && pt <= 500.0) * (0.0) +
          (abs(eta) > 4.0) * (pt > 500.0) * (0.0)  
  }
  }

}



############################
# Photon fake merger loose
############################

module Merger L1TPhotonFakeMergerLoose {
# add InputArray InputArray
  add InputArray L1TPhotonLooseID/photons
  add InputArray L1TJetFakeMakerLoose/photons
  set OutputArray photons
}

############################
# Photon fake merger medium
############################

module Merger L1TPhotonFakeMergerMedium {
# add InputArray InputArray
  add InputArray L1TPhotonMediumID/photons
  add InputArray L1TJetFakeMakerMedium/photons
  set OutputArray photons
}

############################
# Photon fake merger tight
############################

module Merger L1TPhotonFakeMergerTight {
# add InputArray InputArray
  add InputArray L1TPhotonTightID/photons
  add InputArray L1TJetFakeMakerTight/photons
  set OutputArray photons
}

############################
# Electron fake merger loose
############################

module Merger L1TElectronFakeMergerLoose {
# add InputArray InputArray
  add InputArray L1TElectronLooseEfficiency/electrons
  add InputArray L1TJetFakeMakerLoose/electrons
  set OutputArray electrons
}

############################
# Electron fake merger medium
############################

module Merger L1TElectronFakeMergerMedium {
# add InputArray InputArray
  add InputArray L1TElectronMediumEfficiency/electrons
  add InputArray L1TJetFakeMakerMedium/electrons
  set OutputArray electrons
}

############################
# Electron fake merger tight
############################

module Merger L1TElectronFakeMergerTight {
# add InputArray InputArray
  add InputArray L1TElectronTightEfficiency/electrons
  add InputArray L1TJetFakeMakerTight/electrons
  set OutputArray electrons
}


############################
# Muon fake merger loose
############################

module Merger L1TMuonFakeMergerLoose {
# add InputArray InputArray
  add InputArray L1TMuonLooseIdEfficiency/muons
  add InputArray L1TJetFakeMakerLoose/muons
  set OutputArray muons
}

############################
# Muon fake merger medium
############################

module Merger L1TMuonFakeMergerMedium {
# add InputArray InputArray
  add InputArray L1TMuonMediumIdEfficiency/muons
  add InputArray L1TJetFakeMakerMedium/muons
  set OutputArray muons
}

############################
# Muon fake merger tight
############################

module Merger L1TMuonFakeMergerTight {
# add InputArray InputArray
  add InputArray L1TMuonTightIdEfficiency/muons
  add InputArray L1TJetFakeMakerTight/muons
  set OutputArray muons
}

####################
# ROOT tree writer
####################

module TreeWriter TreeWriter {

# add Branch InputArray BranchName BranchClass
# add Branch GenParticleFilter/filteredParticles Particle GenParticle
# add Branch Delphes/allParticles Particle GenParticle
  add Branch GenParticleFilter/filteredParticles Particle GenParticle
  add Branch PileUpMerger/vertices Vertex Vertex

  add Branch GenJetFinder/jets GenJet Jet
  add Branch GenJetFinderAK8/jetsAK8 GenJetAK8 Jet
  add Branch GenMissingET/momentum GenMissingET MissingET

#  add Branch HCal/eflowTracks EFlowTrack Track
#  add Branch ECal/eflowPhotons EFlowPhoton Tower
#  add Branch HCal/eflowNeutralHadrons EFlowNeutralHadron Tower

  add Branch RunPUPPI/PuppiParticles ParticleFlowCandidate ParticleFlowCandidate

  add Branch PhotonSmear/photons Photon Photon
  add Branch PhotonFakeMergerLoose/photons PhotonLoose Photon
  add Branch PhotonFakeMergerMedium/photons PhotonMedium Photon
  add Branch PhotonFakeMergerTight/photons PhotonTight Photon

  add Branch ElectronSmear/electrons Electron Electron
  add Branch ElectronFakeMergerLoose/electrons ElectronLoose Electron
  add Branch ElectronFakeMergerMedium/electrons ElectronMedium Electron
  add Branch ElectronFakeMergerTight/electrons ElectronTight Electron

  add Branch MuonSmear/muons Muon Muon
  add Branch MuonFakeMergerLoose/muons MuonLoose Muon
  add Branch MuonFakeMergerMedium/muons MuonMedium Muon
  add Branch MuonFakeMergerTight/muons MuonTight Muon

  add Branch JetSmearPUPPI/jets JetPUPPI Jet
  add Branch JetSmearPUPPIAK8/jets JetPUPPIAK8 Jet

  add Branch JetLooseID/jets JetPUPPILoose Jet
  add Branch JetTightID/jets JetPUPPITight Jet

  add Branch Rho/rho Rho Rho
  add Branch PuppiMissingET/momentum PuppiMissingET MissingET
  add Branch GenPileUpMissingET/momentum GenPileUpMissingET MissingET
  add Branch ScalarHT/energy ScalarHT ScalarHT

#  add Branch L1THCal/eflowTracks L1TEFlowTrack Track
#  add Branch L1TECal/eflowPhotons L1TEFlowPhoton Tower
#  add Branch L1THCal/eflowNeutralHadrons L1TEFlowNeutralHadron Tower

  add Branch L1TRunPUPPI/PuppiParticles L1TParticleFlowCandidate ParticleFlowCandidate

  add Branch L1TPhotonSmear/photons L1TPhoton Photon
  add Branch L1TPhotonFakeMergerLoose/photons L1TPhotonLoose Photon
  add Branch L1TPhotonFakeMergerMedium/photons L1TPhotonMedium Photon
  add Branch L1TPhotonFakeMergerTight/photons L1TPhotonTight Photon

  add Branch L1TElectronSmear/electrons L1TElectron Electron
  add Branch L1TElectronFakeMergerLoose/electrons L1TElectronLoose Electron
  add Branch L1TElectronFakeMergerMedium/electrons L1TElectronMedium Electron
  add Branch L1TElectronFakeMergerTight/electrons L1TElectronTight Electron

  add Branch L1TMuonSmear/muons L1TMuon Muon
  add Branch L1TMuonFakeMergerLoose/muons L1TMuonLoose Muon
  add Branch L1TMuonFakeMergerMedium/muons L1TMuonMedium Muon
  add Branch L1TMuonFakeMergerTight/muons L1TMuonTight Muon

  add Branch L1TJetSmearPUPPI/jets L1TJetPUPPI Jet
  add Branch L1TJetSmearPUPPIAK8/jets L1TJetPUPPIAK8 Jet

  add Branch L1TJetLooseID/jets L1TJetPUPPILoose Jet
  add Branch L1TJetTightID/jets L1TJetPUPPITight Jet

  add Branch L1TRho/rho L1TRho Rho
  add Branch L1TPuppiMissingET/momentum L1TPuppiMissingET MissingET
  add Branch L1TScalarHT/energy L1TScalarHT ScalarHT  

}