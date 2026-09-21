// main_signal.cc
//
// Standalone Pythia8 driver for processes that are generated entirely inside
// Pythia (no MadGraph hard process).  Writes HepMC2, which run.sh then feeds to
// DelphesHepMC2 using the same cards/delphes_card.dat (and the same on-the-fly
// PU200 file) as the MadGraph path.  This exists because the mapyde container
// ships DelphesHepMC2/3 but no DelphesPythia8 binary.
//
// Usage:  ./main_signal <pythia_card> <hepmc_output>
//
// The number of events and the random seed are taken from the card itself
// (Main:numberOfEvents / Random:seed); run.sh substitutes the NEVENTS and NSEED
// placeholders before calling this, which is the convention already used by
// processes/minbias and processes/upsilon_to_leptons.
//
// The CP5 tune block below is applied *before* the card is read, so any card can
// override any of it.
//
// GENERATOR-LEVEL JET FILTER (SignalFilter:*)
// -------------------------------------------
// The MadGraph-generated Standard Model samples in this repository carry a
// parton-level jet requirement in their run cards: htjmin = 50 for the two QCD
// samples, ptj1min = 10 for the hadronic ones.  Both are event-level cuts --
// MG5 counts every final-state parton with |pdg| <= maxjetflavor or 21 into
// njets, including resonance decay products, and rejects the event outright if
// njets < 1 while either cut is on (SubProcesses/cuts.f, "check existance of
// jets if jet cuts are on").  cut_decays only gates the per-particle pt/eta/dR
// cuts, not this one.
//
// Pythia-only signals have no parton-level jet to cut on -- for the Hidden
// Valley points the visible jets are produced by the dark shower, long after
// the hard process -- so the equivalent requirement is imposed here, on
// hadron-level anti-kT R = 0.4 jets clustered from the visible final state.
// That is the same object Delphes calls Gen_JetAK4, which is what the
// efficiencies quoted in processes/README_signals.md were measured on.
//
// The filter runs BEFORE the event is written to HepMC, and the event loop
// keeps generating until Main:numberOfEvents have been accepted, so a filtered
// sample still contains the number of events that was asked for -- the same
// contract MadGraph honours.  The cross section reported as XSEC_PB is
// multiplied by the measured filter efficiency; the unfiltered one and the
// efficiency itself are printed alongside it so nothing is lost.
//
// Settings (all registered below, so any card may set them):
//   SignalFilter:on            master switch                   (default off)
//   SignalFilter:leadJetPTmin  leading jet pT threshold  [GeV]  (default 10)
//   SignalFilter:HTmin         scalar jet HT threshold   [GeV]  (default 50)
//   SignalFilter:jetPTmin      pT floor of the jet definition   (default 10)
//   SignalFilter:jetR          jet radius                       (default 0.4)
//   SignalFilter:jetEtaMax     |eta| acceptance of the jets     (default 5.0)
//   SignalFilter:maxTrialFactor  give up after this many times
//                                Main:numberOfEvents attempts   (default 20)
// An event passes if it satisfies EITHER arm, matching the fact that the SM
// samples use one or the other and not both.  Note that with the default
// jetPTmin = leadJetPTmin = 10 the HT arm cannot fire on its own (an HT built
// from jets above 10 GeV is only non-zero when some jet is above 10 GeV); it is
// kept explicit, and separately configurable, so that a card which lowers
// jetPTmin gets the QCD-style htjmin = 50 behaviour it asks for.

#include "Pythia8/Pythia.h"
#include "Pythia8Plugins/HepMC2.h"
#include <string>
#include <vector>
#include <iostream>
#include <algorithm>

using namespace Pythia8;

int main(int argc, char *argv[]) {

  if (argc < 3) {
    std::cout << "Usage: ./main_signal <pythia_card> <hepmc_output>" << std::endl;
    return 1;
  }
  std::string cardFile   = argv[1];
  std::string outputName = argv[2];

  Pythia pythia;

  // ------------------------------------------------------------------
  // Common settings, kept in sync with main43.cc so that the signal and
  // the pileup it is overlaid with come from the same tune.
  // ------------------------------------------------------------------
  std::vector<std::string> defaults;

  defaults.push_back("Beams:idA = 2212");
  defaults.push_back("Beams:idB = 2212");
  defaults.push_back("Beams:eCM = 14000.");

  defaults.push_back("Main:timesAllowErrors = 10000");
  defaults.push_back("Check:epTolErr = 0.01");
  defaults.push_back("ParticleDecays:allowPhotonRadiation = on");

  // Unlike main43.cc we do NOT limit tau0.  Delphes has no decay-in-flight, so
  // anything Pythia declines to decay is handed to Delphes as a stable particle.
  // For the displaced samples (S3) leaving limitTau0 on would make the dark
  // pions permanently invisible.  Cards may switch it back on if wanted.
  defaults.push_back("ParticleDecays:limitTau0 = off");

  // CP5
  defaults.push_back("Tune:pp = 14");
  defaults.push_back("Tune:ee = 7");
  defaults.push_back("MultipartonInteractions:ecmPow = 0.03344");
  defaults.push_back("MultipartonInteractions:bProfile = 2");
  defaults.push_back("SigmaTotal:zeroAXB = off");
  defaults.push_back("SpaceShower:alphaSorder = 2");
  defaults.push_back("SpaceShower:alphaSvalue = 0.118");
  defaults.push_back("SigmaProcess:alphaSvalue = 0.118");
  defaults.push_back("SigmaProcess:alphaSorder = 2");
  defaults.push_back("MultipartonInteractions:alphaSvalue = 0.118");
  defaults.push_back("MultipartonInteractions:alphaSorder = 2");
  defaults.push_back("TimeShower:alphaSorder = 2");
  defaults.push_back("TimeShower:alphaSvalue = 0.118");
  defaults.push_back("SigmaTotal:mode = 0");
  defaults.push_back("SigmaTotal:sigmaEl = 21.89");
  defaults.push_back("SigmaTotal:sigmaTot = 100.309");
  defaults.push_back("PDF:pSet = 20");

  for (unsigned int n = 0; n < defaults.size(); ++n)
    pythia.readString(defaults[n]);

  // Register the filter settings before the card is read, otherwise Pythia
  // rejects them as unknown keys and readFile() fails.
  pythia.settings.addFlag("SignalFilter:on", false);
  pythia.settings.addParm("SignalFilter:leadJetPTmin", 10.0, true, false, 0.0, 0.0);
  pythia.settings.addParm("SignalFilter:HTmin",        50.0, true, false, 0.0, 0.0);
  pythia.settings.addParm("SignalFilter:jetPTmin",     10.0, true, false, 0.0, 0.0);
  pythia.settings.addParm("SignalFilter:jetR",          0.4, true, false, 0.0, 0.0);
  pythia.settings.addParm("SignalFilter:jetEtaMax",     5.0, true, false, 0.0, 0.0);
  pythia.settings.addParm("SignalFilter:maxTrialFactor", 20.0, true, false, 1.0, 0.0);

  // Process-specific settings; these win over the defaults above.
  if (!pythia.readFile(cardFile)) {
    std::cout << "main_signal: failed to read card " << cardFile << std::endl;
    return 2;
  }

  int nEvents = pythia.mode("Main:numberOfEvents");
  if (nEvents <= 0) {
    std::cout << "main_signal: Main:numberOfEvents not set in " << cardFile
              << std::endl;
    return 3;
  }

  HepMC::Pythia8ToHepMC ToHepMC;
  HepMC::IO_GenEvent ascii_io(outputName.c_str(), std::ios::out);

  if (!pythia.init()) {
    std::cout << "main_signal: Pythia initialisation failed" << std::endl;
    return 4;
  }

  // ------------------------------------------------------------------
  // Generator-level jet filter.  select = 2 clusters the visible final state
  // only, i.e. neutrinos (and anything else invisible) are excluded, matching
  // Delphes' NeutrinoFilter -> GenJetFinder chain.  power = -1 is anti-kT.
  // ------------------------------------------------------------------
  bool   filterOn   = pythia.flag("SignalFilter:on");
  double leadPTmin  = pythia.parm("SignalFilter:leadJetPTmin");
  double htMin      = pythia.parm("SignalFilter:HTmin");
  double jetPTmin   = pythia.parm("SignalFilter:jetPTmin");
  double jetR       = pythia.parm("SignalFilter:jetR");
  double jetEtaMax  = pythia.parm("SignalFilter:jetEtaMax");
  double trialFac   = pythia.parm("SignalFilter:maxTrialFactor");

  SlowJet slowJet(-1, jetR, jetPTmin, jetEtaMax, 2, 2);

  if (filterOn) {
    std::cout << "main_signal: generator-level filter ON -- keeping events with"
              << " (lead jet pT > " << leadPTmin << " GeV) OR (HT > " << htMin
              << " GeV), anti-kT R = " << jetR << ", jets above " << jetPTmin
              << " GeV within |eta| < " << jetEtaMax << std::endl;
  } else {
    std::cout << "main_signal: generator-level filter OFF" << std::endl;
  }

  // nGenerated counts events Pythia successfully produced, nAccepted those the
  // filter kept; their ratio is the efficiency the cross section needs.  The
  // loop runs until nAccepted reaches the requested number rather than for a
  // fixed number of attempts, so that a filtered sample is still the size that
  // was asked for.
  long nGenerated = 0;
  long nAccepted  = 0;
  long maxTrials  = static_cast<long>(trialFac * nEvents);

  for (long iTrial = 0; nAccepted < nEvents && iTrial < maxTrials; ++iTrial) {
    if (!pythia.next()) {
      // With Beams:frameType = 4 the hard process comes from an LHE file, so a
      // filtered event cannot simply be replaced -- once the file is exhausted
      // there is nothing left to draw.  Without this the loop would spin
      // maxTrials times on a dead file before giving up.  The caller must
      // generate the LHE with enough headroom for the filter; see
      // processes/README_signals.md.
      if (pythia.info.atEndOfFile()) {
        std::cout << "main_signal: end of LHE input after " << nGenerated
                  << " events generated, " << nAccepted << " accepted"
                  << std::endl;
        break;
      }
      continue;
    }
    ++nGenerated;

    if (filterOn) {
      double leadPT = 0.0;
      double ht     = 0.0;
      if (slowJet.analyze(pythia.event)) {
        for (int i = 0; i < slowJet.sizeJet(); ++i) {
          double pT = slowJet.pT(i);
          ht += pT;
          leadPT = std::max(leadPT, pT);
        }
      }
      if (!(leadPT > leadPTmin || ht > htMin)) continue;
    }

    HepMC::GenEvent* hepmcevt = new HepMC::GenEvent();
    ToHepMC.fill_next_event(pythia, hepmcevt);
    ascii_io << hepmcevt;
    delete hepmcevt;
    ++nAccepted;
  }

  pythia.stat();

  if (nAccepted < nEvents) {
    std::cout << "main_signal: WARNING -- only " << nAccepted << " of "
              << nEvents << " events accepted; "
              << (pythia.info.atEndOfFile()
                  ? "the LHE input ran out -- generate it with more headroom "
                    "for the filter"
                  : "raise SignalFilter:maxTrialFactor")
              << std::endl;
  }

  // Cross section in pb, for the normalisation deliverable (spec section 5.5).
  // sigmaGen is the cross section Pythia generated, which knows nothing about
  // the filter above, so it is scaled by the measured filter efficiency.  The
  // relative error on sigmaGen is carried over; the binomial error on the
  // efficiency itself is negligible next to it at these statistics.
  double eff      = (nGenerated > 0)
                  ? static_cast<double>(nAccepted) / static_cast<double>(nGenerated)
                  : 0.0;
  double sigma    = pythia.info.sigmaGen();
  double sigmaErr = pythia.info.sigmaErr();
  std::cout << "main_signal: wrote " << nAccepted << " events to "
            << outputName << std::endl;
  std::cout << "main_signal: sigmaGen = " << sigma << " +- " << sigmaErr
            << " mb" << std::endl;
  std::cout << "FILTER_EFF " << eff << " " << nAccepted << " " << nGenerated
            << std::endl;
  std::cout << "XSEC_PB_UNFILTERED " << sigma * 1.0e9 << " "
            << sigmaErr * 1.0e9 << std::endl;
  std::cout << "XSEC_PB " << sigma * eff * 1.0e9 << " "
            << sigmaErr * eff * 1.0e9 << std::endl;

  if (nAccepted == 0) return 5;
  return 0;
}
