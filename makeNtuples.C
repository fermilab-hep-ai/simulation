// #include <iostream>
// #include <unordered_set>
// #include <utility>
// #include "TClonesArray.h"
// #include "Math/LorentzVector.h"
// #include "classes/DelphesClasses.h"
// #include "external/ExRootAnalysis/ExRootTreeReader.h"

#ifdef __CLING__
R__LOAD_LIBRARY(libDelphes)
#include "classes/DelphesClasses.h"
#include "external/ExRootAnalysis/ExRootTreeReader.h"
#else
class ExRootTreeReader;
#endif

//------------------------------------------------------------------------------

void makeNtuples(TString inputFile, TString outputFile, TString jetBranch = "FatJet") {
  gSystem->Load("libDelphes");

  TFile *fout = new TFile(outputFile, "RECREATE");
  TTree *tree = new TTree("tree", "tree");

  // define branches
  std::map<TString, float> floatVars;
  floatVars["is_signal"] = 0;

  floatVars["gen_match"] = 0;
  floatVars["genpart_pt"] = 0;
  floatVars["genpart_eta"] = 0;
  floatVars["genpart_phi"] = 0;
  floatVars["genpart_pid"] = 0;

  floatVars["jet_pt"] = 0;
  floatVars["jet_eta"] = 0;
  floatVars["jet_phi"] = 0;
  floatVars["jet_energy"] = 0;
  floatVars["jet_nparticles"] = 0;
  floatVars["jet_sdmass"] = 0;
  floatVars["jet_tau1"] = 0;
  floatVars["jet_tau2"] = 0;
  floatVars["jet_tau3"] = 0;
  floatVars["jet_tau4"] = 0;

  std::map<TString, std::vector<float>> arrayVars;
  arrayVars["part_px"];
  arrayVars["part_py"];
  arrayVars["part_pz"];
  arrayVars["part_energy"];
  arrayVars["part_pt"];
  arrayVars["part_deta"];
  arrayVars["part_dphi"];
  arrayVars["part_charge"];
  arrayVars["part_pid"];
  arrayVars["part_d0val"];
  arrayVars["part_d0err"];
  arrayVars["part_dzval"];
  arrayVars["part_dzerr"];

  // book
  for (auto &v : floatVars) {
    tree->Branch(v.first.Data(), &v.second);
  }

  for (auto &v : arrayVars) {
    tree->Branch(v.first.Data(), &v.second, /*bufsize=*/1024000);
  }

  // read input
  TChain *chain = new TChain("Delphes");
  chain->Add(inputFile);
  ExRootTreeReader *treeReader = new ExRootTreeReader(chain);
  Long64_t allEntries = treeReader->GetEntries();

  std::cerr << "** Input file: " << inputFile << std::endl;
  std::cerr << "** Jet branch: " << jetBranch << std::endl;
  std::cerr << "** Total events: " << allEntries << std::endl;

  // analyze
  TClonesArray *branchParticle = treeReader->UseBranch("Particle");
  TClonesArray *branchPFCand = treeReader->UseBranch("ParticleFlowCandidate");
  TClonesArray *branchJet = treeReader->UseBranch(jetBranch);

  FatJetMatching fjmatch(0.8);

  // Loop over all events
  int num_processed = 0;
  for (Long64_t entry = 0; entry < allEntries; ++entry) {
    if (entry % 1000 == 0) {
      std::cerr << "processing " << entry << " of " << allEntries << " events." << std::endl;
    }

    // Load selected branches with data from specified event
    treeReader->ReadEntry(entry);

    // Loop over all jets in event
    for (Int_t i = 0; i < branchJet->GetEntriesFast(); ++i) {
      const Jet *jet = (Jet *)branchJet->At(i);

      if (jet->PT < 500 || std::abs(jet->Eta) > 2)
        continue;

      for (auto &v : floatVars) {
        v.second = 0;
      }
      for (auto &v : arrayVars) {
        v.second.clear();
      }

      auto label = fjmatch.getLabel(jet, branchParticle);
      floatVars["gen_match"] = label.first;
      floatVars["is_signal"] = 0;

      if (fjmatch.event_type() == FatJetMatching::EventType::Top) {
        // only consider fully merged
        floatVars["is_signal"] = (label.first == FatJetMatching::Top_bcq || label.first == FatJetMatching::Top_bqq ||
                                  label.first == FatJetMatching::Top_ben || label.first == FatJetMatching::Top_bmn);
      } else if (fjmatch.event_type() == FatJetMatching::EventType::Higgs) {
        floatVars["is_signal"] = (label.first > FatJetMatching::H_all && label.first < FatJetMatching::QCD_all);
      } else if (fjmatch.event_type() == FatJetMatching::EventType::W) {
        floatVars["is_signal"] = (label.first > FatJetMatching::W_all && label.first < FatJetMatching::Z_all);
      } else if (fjmatch.event_type() == FatJetMatching::EventType::Z) {
        floatVars["is_signal"] = (label.first > FatJetMatching::Z_all && label.first < FatJetMatching::H_all);
      }

      if (fjmatch.event_type() != FatJetMatching::EventType::QCD && floatVars["is_signal"] == 0) {
        // reject un-matched jets in signal samples
        continue;
      }

      if (label.second) {
        floatVars["genpart_pt"] = label.second->PT;
        floatVars["genpart_eta"] = label.second->Eta;
        floatVars["genpart_phi"] = label.second->Phi;
        floatVars["genpart_pid"] = label.second->PID;
      }

      floatVars["jet_pt"] = jet->PT;
      floatVars["jet_eta"] = jet->Eta;
      floatVars["jet_phi"] = jet->Phi;
      floatVars["jet_energy"] = jet->P4().Energy();

      floatVars["jet_sdmass"] = jet->SoftDroppedP4[0].M();
      floatVars["jet_tau1"] = jet->Tau[0];
      floatVars["jet_tau2"] = jet->Tau[1];
      floatVars["jet_tau3"] = jet->Tau[2];
      floatVars["jet_tau4"] = jet->Tau[3];

      // Loop over all jet's constituents
      std::vector<ParticleInfo> particles;
      for (Int_t j = 0; j < jet->Constituents.GetEntriesFast(); ++j) {
        const TObject *object = jet->Constituents.At(j);

        // Check if the constituent is accessible
        if (!object)
          continue;

        if (object->IsA() == GenParticle::Class()) {
          particles.emplace_back((GenParticle *)object);
        } else if (object->IsA() == ParticleFlowCandidate::Class()) {
          particles.emplace_back((ParticleFlowCandidate *)object);
        }
        const auto &p = particles.back();
        if (std::abs(p.pz) > 10000 || std::abs(p.eta) > 5 || p.pt <= 0) {
          particles.pop_back();
        }
      }

      // sort particles by pt
      std::sort(particles.begin(), particles.end(), [](const auto &a, const auto &b) { return a.pt > b.pt; });
      floatVars["jet_nparticles"] = particles.size();
      for (const auto &p : particles) {
        arrayVars["part_px"].push_back(p.px);
        arrayVars["part_py"].push_back(p.py);
        arrayVars["part_pz"].push_back(p.pz);
        arrayVars["part_energy"].push_back(p.energy);
        arrayVars["part_pt"].push_back(p.pt);
        arrayVars["part_deta"].push_back((jet->Eta > 0 ? 1 : -1) * (p.eta - jet->Eta));
        arrayVars["part_dphi"].push_back(deltaPhi(p.phi, jet->Phi));
        arrayVars["part_charge"].push_back(p.charge);
        arrayVars["part_pid"].push_back(p.pid);
        arrayVars["part_d0val"].push_back(p.d0);
        arrayVars["part_d0err"].push_back(p.d0err);
        arrayVars["part_dzval"].push_back(p.dz);
        arrayVars["part_dzerr"].push_back(p.dzerr);
      }

      tree->Fill();
      ++num_processed;
    }
  }

  tree->Write();
  std::cerr << TString::Format("** Written %d jets to output %s", num_processed, outputFile.Data()) << std::endl;

  delete treeReader;
  delete chain;
  delete fout;
}

//------------------------------------------------------------------------------
