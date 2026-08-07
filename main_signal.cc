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

#include "Pythia8/Pythia.h"
#include "Pythia8Plugins/HepMC2.h"
#include <string>
#include <vector>
#include <iostream>

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

  int nAccepted = 0;
  for (int iEvent = 0; iEvent < nEvents; ++iEvent) {
    if (!pythia.next()) continue;

    HepMC::GenEvent* hepmcevt = new HepMC::GenEvent();
    ToHepMC.fill_next_event(pythia, hepmcevt);
    ascii_io << hepmcevt;
    delete hepmcevt;
    ++nAccepted;
  }

  pythia.stat();

  // Cross section in pb, for the normalisation deliverable (spec section 5.5).
  double sigma    = pythia.info.sigmaGen();
  double sigmaErr = pythia.info.sigmaErr();
  std::cout << "main_signal: wrote " << nAccepted << " events to "
            << outputName << std::endl;
  std::cout << "main_signal: sigmaGen = " << sigma << " +- " << sigmaErr
            << " mb" << std::endl;
  std::cout << "XSEC_PB " << sigma * 1.0e9 << " " << sigmaErr * 1.0e9
            << std::endl;

  if (nAccepted == 0) return 5;
  return 0;
}
