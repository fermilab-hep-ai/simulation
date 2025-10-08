#include "Pythia8/Pythia.h"
#include "Pythia8Plugins/HepMC2.h"
#include <string>
#include <vector>
#include <sstream>

using namespace Pythia8;

std::string toString(int i){
  std::stringstream ss;
  ss << i;
  return ss.str();
}


int main(int argc, char *argv[]) {

  if (argc<3) {
    std::cout<<"Usage: ./main43 Mode Seed"<<std::endl;
    std::cout<<"  Mode = PileUp_MC, TTBar, WJets, VBFHbb, DiJet_MC"<<std::endl;
    return false;
  }
  std::string m_mode = argv[1];
  int seed = atoi(argv[2]);
  //cout << seed << endl;
  std::string m_OutputName = "tmpdir/results/hepmcout_result.data";
  std::vector<std::string> vecPythiaCommands;

  string pdfSet = "LHAPDF6:NNPDF30_nnlo_as_0118";
 
  //vecPythiaCommands.push_back("PDF:pSet = " + pdfSet);
  vecPythiaCommands.push_back("Beams:eCM = 14000.");
  //vecPythiaCommands.push_back("Tune:pp = 5");
  vecPythiaCommands.push_back("Random:setSeed = on");
  vecPythiaCommands.push_back("Random:seed = "+toString(seed));

  // Common
  vecPythiaCommands.push_back("Main:timesAllowErrors = 10000");
  vecPythiaCommands.push_back("Check:epTolErr = 0.01");
  vecPythiaCommands.push_back("Beams:setProductionScalesFromLHEF = off");
  vecPythiaCommands.push_back("SLHA:minMassSM = 1000");
  vecPythiaCommands.push_back("ParticleDecays:limitTau0 = on");
  vecPythiaCommands.push_back("ParticleDecays:tau0Max = 10");
  vecPythiaCommands.push_back("ParticleDecays:allowPhotonRadiation = on");

  // CP5
  vecPythiaCommands.push_back("Tune:pp = 14");
  vecPythiaCommands.push_back("Tune:ee = 7");
  vecPythiaCommands.push_back("MultipartonInteractions:ecmPow = 0.03344");
  vecPythiaCommands.push_back("MultipartonInteractions:bProfile = 2");
  vecPythiaCommands.push_back("SigmaTotal:zeroAXB = off");
  vecPythiaCommands.push_back("SpaceShower:alphaSorder = 2");
  vecPythiaCommands.push_back("SpaceShower:alphaSvalue = 0.118");
  vecPythiaCommands.push_back("SigmaProcess:alphaSvalue = 0.118");
  vecPythiaCommands.push_back("SigmaProcess:alphaSorder = 2");
  vecPythiaCommands.push_back("MultipartonInteractions:alphaSvalue = 0.118");
  vecPythiaCommands.push_back("MultipartonInteractions:alphaSorder = 2");
  vecPythiaCommands.push_back("TimeShower:alphaSorder = 2");
  vecPythiaCommands.push_back("TimeShower:alphaSvalue = 0.118");
  vecPythiaCommands.push_back("SigmaTotal:mode = 0");
  vecPythiaCommands.push_back("SigmaTotal:sigmaEl = 21.89");
  vecPythiaCommands.push_back("SigmaTotal:sigmaTot = 100.309");
  vecPythiaCommands.push_back("PDF:pSet = 20");

  if (m_mode=="PileUp_MC") {
    m_OutputName = "tmpdir/QCD/results/hepmcout_SoftQCD_MC_"+toString(seed)+".data";
    vecPythiaCommands.push_back("SoftQCD:all = on");
  }

  // Interface for conversion from Pythia8::Event to HepMC event.
  HepMC::Pythia8ToHepMC ToHepMC;

  // Specify file where HepMC events will be stored.
  HepMC::IO_GenEvent ascii_io(m_OutputName.c_str(), std::ios::out);

  // Generator. Process selection. LHC initialization. Histogram.
  Pythia pythia;
  for (unsigned int n=0; n<vecPythiaCommands.size(); n++) {
    cout << vecPythiaCommands[n] << endl;
    pythia.readString(vecPythiaCommands[n]);
  }
  pythia.init();
  Hist mult("charged multiplicity", 100, -0.5, 799.5);

  // Begin event loop. Generate event. Skip if error.
  std::cout<<" Event loop start"<<std::endl;
  int counter = 0;
  std::cout<<counter<<std::endl;

  int numOfEvents = 30000;
  if (m_mode=="DiJet_MC" or m_mode=="DiJet_Data")
    numOfEvents = 20000;
  
  for (int iEvent = 0; iEvent < numOfEvents; ++iEvent) {
    counter+=1;
    if (counter%5000==0)
      std::cout<<counter<<std::endl;
    if (!pythia.next()) continue;
    // Find number of all final charged particles and fill histogram.
    int nCharged = 0;
    for (int i = 0; i < pythia.event.size(); ++i)
      if (pythia.event[i].isFinal() && pythia.event[i].isCharged())
	++nCharged;
    mult.fill( nCharged );

    // Construct new empty HepMC event and fill it.
    // Units will be as chosen for HepMC build; but can be changed
    // by arguments, e.g. GenEvt( HepMC::Units::GEV, HepMC::Units::MM)
    HepMC::GenEvent* hepmcevt = new HepMC::GenEvent();
    ToHepMC.fill_next_event( pythia, hepmcevt );

    // Write the HepMC event to file. Done with it.
    ascii_io << hepmcevt;

    delete hepmcevt;
    // End of event loop. Statistics. Histogram.
  }

  pythia.stat();
  //cout << mult;

  // Done.
  return 0;
}
