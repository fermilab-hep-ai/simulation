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

double deltaPhi(double phi1, double phi2) { return TVector2::Phi_mpi_pi(phi1 - phi2); }

double deltaR(double eta1, double phi1, double eta2, double phi2) {
  double deta = eta1 - eta2;
  double dphi = deltaPhi(phi1, phi2);
  return std::hypot(deta, dphi);
}

template <class T1, class T2>
double deltaR(const T1 &a, const T2 &b) {
  return deltaR(a->Eta, a->Phi, b->Eta, b->Phi);
}

namespace ParticleID {
  enum PdgId {
    p_unknown,
    p_d,
    p_u,
    p_s,
    p_c,
    p_b,
    p_t,
    p_bprime,
    p_tprime,
    p_eminus = 11,
    p_nu_e,
    p_muminus,
    p_nu_mu,
    p_tauminus,
    p_nu_tau,
    p_tauprimeminus,
    p_nu_tauprime,
    p_g = 21,
    p_gamma,
    p_Z0,
    p_Wplus,
    p_h0,
    p_Zprime0 = 32,
    p_Zpprime0,
    p_Wprimeplus,
    p_H0,
    p_A0,
    p_Hplus,
    p_G = 39,
    p_R0 = 41,
    p_H30 = 45,
    p_A20 = 46,
    p_LQ,
    p_cluster = 91,
    p_string,
    p_pi0 = 111,
    p_rho0 = 113,
    p_klong = 130,
    p_piplus = 211,
    p_rhoplus = 213,
    p_eta = 221,
    p_omega = 223,
    p_kshort = 310,
    p_k0,
    p_kstar0 = 313,
    p_kplus = 321,
    p_kstarplus = 323,
    p_phi = 333,
    p_dplus = 411,
    p_d0 = 421,
    p_dsplus = 431,
    p_b0 = 511,
    p_bplus = 521,
    p_bs0 = 531,
    p_bcplus = 541,
    p_neutron = 2112,
    p_proton = 2212,
    p_sigmaminus = 3112,
    p_lambda0 = 3122,
    p_sigma0 = 3212,
    p_sigmaplus = 3222,
    p_ximinus = 3312,
    p_xi0 = 3322,
    p_omegaminus = 3334,
    p_sigmac0 = 4112,
    p_lambdacplus = 4122,
    p_xic0 = 4132,
    p_sigmacplus = 4212,
    p_sigmacpp = 4222,
    p_xicplus = 4232,
    p_omegac0 = 4332,
    p_sigmabminus = 5112,
    p_lambdab0 = 5122,
    p_xibminus = 5132,
    p_sigmab0 = 5212,
    p_sigmabplus = 5222,
    p_xib0 = 5232,
    p_omegabminus = 5332,
  };
}

class FatJetMatching {
public:
  enum EventType {
    QCD = 0,
    Higgs,
    Top,
    W,
    Z,
  };

  enum FatJetLabel {
    Invalid = 0,
    Top_all = 10,
    Top_bcq,
    Top_bqq,
    Top_bc,
    Top_bq,
    Top_ben,
    Top_bmn,
    W_all = 20,
    W_cq,
    W_qq,
    Z_all = 30,
    Z_bb,
    Z_cc,
    Z_qq,
    H_all = 40,
    H_bb,
    H_cc,
    H_qq,
    H_gg,
    H_ww4q,
    H_ww2q1l,
    QCD_all = 50,
    QCD_bb,
    QCD_cc,
    QCD_b,
    QCD_c,
    QCD_others
  };

public:
  FatJetMatching() {}
  FatJetMatching(double jetR) : jetR_(jetR) {}

  virtual ~FatJetMatching() {}

  EventType event_type() const { return event_type_; }

  std::pair<FatJetLabel, const GenParticle *> getLabel(const Jet *jet, const TClonesArray *branchParticle) {
    genParticles_.clear();
    for (Int_t i = 0; i < branchParticle->GetEntriesFast(); ++i) {
      genParticles_.push_back((GenParticle *)branchParticle->At(i));
    }
    processed_.clear();
    event_type_ = EventType::QCD;

    if (debug_) {
      std::cout << "\n=======\nJet (energy, pT, eta, phi) = " << jet->P4().Energy() << ", " << jet->PT << ", "
                << jet->Eta << ", " << jet->Phi << std::endl
                << std::endl;
      printGenInfoHeader();
      for (unsigned ipart = 0; ipart < genParticles_.size(); ++ipart) {
        printGenParticleInfo(genParticles_[ipart], ipart);
      }
    }

    for (const auto *gp : genParticles_) {
      if (processed_.count(gp))
        continue;
      processed_.insert(gp);

      auto pdgid = std::abs(gp->PID);
      if (pdgid == ParticleID::p_t) {
        auto result = top_label(jet, gp);
        if (result.first != FatJetLabel::Invalid) {
          return result;
        }
      } else if (pdgid == ParticleID::p_h0) {
        auto result = higgs_label(jet, gp);
        if (result.first != FatJetLabel::Invalid) {
          return result;
        }
      } else if (pdgid == ParticleID::p_Wplus) {
        auto result = w_label(jet, gp);
        if (result.first != FatJetLabel::Invalid) {
          return result;
        }
      } else if (pdgid == ParticleID::p_Z0) {
        auto result = z_label(jet, gp);
        if (result.first != FatJetLabel::Invalid) {
          return result;
        }
      }
    }

    if (genParticles_.size() != processed_.size())
      throw std::logic_error("[FatJetMatching] Not all genParticles are processed!");

    return std::make_pair(FatJetLabel::QCD_all, nullptr);
  }

private:
  std::pair<FatJetLabel, const GenParticle *> top_label(const Jet *jet, const GenParticle *parton) {
    // top
    auto top = getFinal(parton);
    // find the W and test if it's hadronic
    const GenParticle *w_from_top = nullptr, *b_from_top = nullptr;
    for (const auto *dau : getDaughters(top)) {
      if (std::abs(dau->PID) == ParticleID::p_Wplus) {
        w_from_top = getFinal(dau);
      } else if (std::abs(dau->PID) <= ParticleID::p_b) {
        // ! use <= p_b ! -- can also have charms etc.
        b_from_top = dau;
      }
    }
    if (!w_from_top || !b_from_top)
      throw std::logic_error("[FatJetMatching::top_label] Cannot find b or W from top decay!");

    if (isHadronic(w_from_top)) {
      if (event_type_ == EventType::QCD) {
        event_type_ = EventType::Top;
      }
      if (debug_) {
        using namespace std;
        cout << "jet: (" << jet->PT << ", " << jet->Eta << ", " << jet->Phi << ", " << jet->P4().Energy() << ")"
             << endl;
        cout << "top: ";
        printGenParticleInfo(top, -1);
        cout << "b:   ";
        printGenParticleInfo(b_from_top, -1);
        cout << "W:   ";
        printGenParticleInfo(w_from_top, -1);
      }

      auto wdaus = getDaughterQuarks(w_from_top);
      if (wdaus.size() < 2)
        throw std::logic_error("[FatJetMatching::top_label] W decay has less than 2 quarks!");
      //    if (wdaus.size() >= 2)
      {
        double dr_b = deltaR(jet, b_from_top);
        double dr_q1 = deltaR(jet, wdaus.at(0));
        double dr_q2 = deltaR(jet, wdaus.at(1));
        if (dr_q1 > dr_q2) {
          // swap q1 and q2 so that dr_q1<=dr_q2
          std::swap(dr_q1, dr_q2);
          std::swap(wdaus.at(0), wdaus.at(1));
        }

        if (debug_) {
          using namespace std;
          cout << "deltaR(jet, b)     : " << dr_b << endl;
          cout << "deltaR(jet, q1)    : " << dr_q1 << endl;
          cout << "deltaR(jet, q2)    : " << dr_q2 << endl;
        }

        if (dr_b < jetR_) {
          auto pdgid_q1 = std::abs(wdaus.at(0)->PID);
          auto pdgid_q2 = std::abs(wdaus.at(1)->PID);
          if (debug_) {
            using namespace std;
            cout << "pdgid(q1)        : " << pdgid_q1 << endl;
            cout << "pdgid(q2)        : " << pdgid_q2 << endl;
          }

          if (dr_q1 < jetR_ && dr_q2 < jetR_) {
            if (pdgid_q1 >= ParticleID::p_c || pdgid_q2 >= ParticleID::p_c) {
              return std::make_pair(FatJetLabel::Top_bcq, top);
            } else {
              return std::make_pair(FatJetLabel::Top_bqq, top);
            }
          } else if (dr_q1 < jetR_ && dr_q2 >= jetR_) {
            if (pdgid_q1 >= ParticleID::p_c) {
              return std::make_pair(FatJetLabel::Top_bc, top);
            } else {
              return std::make_pair(FatJetLabel::Top_bq, top);
            }
          }
        } else {
          // test for W if dr(b, jet) > jetR_
          return w_label(jet, w_from_top);
        }
      }
    } else {
      // leptonic W
      if (event_type_ == EventType::QCD) {
        event_type_ = EventType::Top;
      }
      if (debug_) {
        using namespace std;
        cout << "jet: (" << jet->PT << ", " << jet->Eta << ", " << jet->Phi << ", " << jet->P4().Energy() << ")"
             << endl;
        cout << "top: ";
        printGenParticleInfo(top, -1);
        cout << "b:   ";
        printGenParticleInfo(b_from_top, -1);
        cout << "W:   ";
        printGenParticleInfo(w_from_top, -1);
      }

      const GenParticle *lep = nullptr;
      for (int idau = w_from_top->D1; idau <= w_from_top->D2; ++idau) {
        const auto *dau = genParticles_.at(idau);
        auto pdgid = std::abs(dau->PID);
        if (pdgid == ParticleID::p_eminus || pdgid == ParticleID::p_muminus) {
          // use final version here!
          lep = getFinal(dau);
          break;
        }
      }
      if (!lep)
        throw std::logic_error("[FatJetMatching::top_label] Cannot find charged lepton from leptonic W decay!");

      double dr_b = deltaR(jet, b_from_top);
      double dr_l = deltaR(jet, lep);
      if (debug_) {
        using namespace std;
        cout << "deltaR(jet, b)     : " << dr_b << endl;
        cout << "deltaR(jet, l)     : " << dr_l << endl;
        cout << "pdgid(l)           : " << lep->PID << endl;
      }

      if (dr_b < jetR_ && dr_l < jetR_) {
        auto pdgid = std::abs(lep->PID);
        if (pdgid == ParticleID::p_eminus) {
          return std::make_pair(FatJetLabel::Top_ben, top);
        } else if (pdgid == ParticleID::p_muminus) {
          return std::make_pair(FatJetLabel::Top_bmn, top);
        }
      }
    }

    return std::make_pair(FatJetLabel::Invalid, nullptr);
  }

  std::pair<FatJetLabel, const GenParticle *> w_label(const Jet *jet, const GenParticle *parton) {
    auto w = getFinal(parton);
    if (isHadronic(w)) {
      if (event_type_ == EventType::QCD) {
        event_type_ = EventType::W;
      }

      if (debug_) {
        using namespace std;
        cout << "jet: (" << jet->PT << ", " << jet->Eta << ", " << jet->Phi << ", " << jet->P4().Energy() << ")"
             << endl;
        cout << "W:   ";
        printGenParticleInfo(w, -1);
      }

      auto wdaus = getDaughterQuarks(w);
      if (wdaus.size() < 2)
        throw std::logic_error("[FatJetMatching::w_label] W decay has less than 2 quarks!");
      //    if (wdaus.size() >= 2)
      {
        double dr_q1 = deltaR(jet, wdaus.at(0));
        double dr_q2 = deltaR(jet, wdaus.at(1));
        if (dr_q1 > dr_q2) {
          // swap q1 and q2 so that dr_q1<=dr_q2
          std::swap(dr_q1, dr_q2);
          std::swap(wdaus.at(0), wdaus.at(1));
        }
        auto pdgid_q1 = std::abs(wdaus.at(0)->PID);
        auto pdgid_q2 = std::abs(wdaus.at(1)->PID);

        if (debug_) {
          using namespace std;
          cout << "deltaR(jet, q1)    : " << dr_q1 << endl;
          cout << "deltaR(jet, q2)    : " << dr_q2 << endl;
          cout << "pdgid(q1)        : " << pdgid_q1 << endl;
          cout << "pdgid(q2)        : " << pdgid_q2 << endl;
        }

        if (dr_q1 < jetR_ && dr_q2 < jetR_) {
          if (pdgid_q1 >= ParticleID::p_c || pdgid_q2 >= ParticleID::p_c) {
            return std::make_pair(FatJetLabel::W_cq, w);
          } else {
            return std::make_pair(FatJetLabel::W_qq, w);
          }
        }
      }
    }

    return std::make_pair(FatJetLabel::Invalid, nullptr);
  }

  std::pair<FatJetLabel, const GenParticle *> z_label(const Jet *jet, const GenParticle *parton) {
    auto z = getFinal(parton);
    if (isHadronic(z)) {
      if (event_type_ == EventType::QCD) {
        event_type_ = EventType::Z;
      }

      if (debug_) {
        using namespace std;
        cout << "jet: (" << jet->PT << ", " << jet->Eta << ", " << jet->Phi << ", " << jet->P4().Energy() << ")"
             << endl;
        cout << "Z:   ";
        printGenParticleInfo(z, -1);
      }

      auto zdaus = getDaughterQuarks(z);
      if (zdaus.size() < 2)
        throw std::logic_error("[FatJetMatching::z_label] Z decay has less than 2 quarks!");
      //    if (zdaus.size() >= 2)
      {
        double dr_q1 = deltaR(jet, zdaus.at(0));
        double dr_q2 = deltaR(jet, zdaus.at(1));
        if (dr_q1 > dr_q2) {
          // swap q1 and q2 so that dr_q1<=dr_q2
          std::swap(dr_q1, dr_q2);
          std::swap(zdaus.at(0), zdaus.at(1));
        }
        auto pdgid_q1 = std::abs(zdaus.at(0)->PID);
        auto pdgid_q2 = std::abs(zdaus.at(1)->PID);

        if (debug_) {
          using namespace std;
          cout << "deltaR(jet, q1)    : " << dr_q1 << endl;
          cout << "deltaR(jet, q2)    : " << dr_q2 << endl;
          cout << "pdgid(q1)        : " << pdgid_q1 << endl;
          cout << "pdgid(q2)        : " << pdgid_q2 << endl;
        }

        if (dr_q1 < jetR_ && dr_q2 < jetR_) {
          if (pdgid_q1 == ParticleID::p_b && pdgid_q2 == ParticleID::p_b) {
            return std::make_pair(FatJetLabel::Z_bb, z);
          } else if (pdgid_q1 == ParticleID::p_c && pdgid_q2 == ParticleID::p_c) {
            return std::make_pair(FatJetLabel::Z_cc, z);
          } else {
            return std::make_pair(FatJetLabel::Z_qq, z);
          }
        }
      }
    }

    return std::make_pair(FatJetLabel::Invalid, nullptr);
  }

  std::pair<FatJetLabel, const GenParticle *> higgs_label(const Jet *jet, const GenParticle *parton) {
    auto higgs = getFinal(parton);
    auto daus = getDaughters(higgs);

    bool is_hvv = false;
    if (daus.size() > 2) {
      // e.g., h->Vqq or h->qqqq
      is_hvv = true;
    } else {
      // e.g., h->VV*
      for (const auto *p : daus) {
        auto pdgid = std::abs(p->PID);
        if (pdgid == ParticleID::p_Wplus || pdgid == ParticleID::p_Z0) {
          is_hvv = true;
          break;
        }
      }
    }

    if (is_hvv) {
      if (event_type_ == EventType::QCD) {
        event_type_ = EventType::Higgs;
      }

      // h->WW or h->ZZ
      std::vector<const GenParticle *> hvv_quarks;
      std::vector<const GenParticle *> hvv_leptons;
      for (const auto *p : daus) {
        auto pdgid = std::abs(p->PID);
        if (pdgid >= ParticleID::p_d && pdgid <= ParticleID::p_b) {
          hvv_quarks.push_back(p);
        } else if (pdgid == ParticleID::p_eminus || pdgid == ParticleID::p_muminus) {
          hvv_leptons.push_back(getFinal(p));
        } else if (pdgid == ParticleID::p_Wplus || pdgid == ParticleID::p_Z0) {
          auto v_daus = getDaughters(getFinal(p));
          for (const auto *vdau : v_daus) {
            auto pdgid = std::abs(vdau->PID);
            if (pdgid >= ParticleID::p_d && pdgid <= ParticleID::p_b) {
              hvv_quarks.push_back(vdau);
            } else if (pdgid == ParticleID::p_eminus || pdgid == ParticleID::p_muminus) {
              hvv_leptons.push_back(getFinal(vdau));
            }
          }
        }
      }

      if (debug_) {
        using namespace std;
        cout << "Found " << hvv_quarks.size() << " quarks from Higgs decay" << endl;
        for (const auto *gp : hvv_quarks) {
          using namespace std;
          printGenParticleInfo(gp, -1);
          cout << " ... dR(q, jet) = " << deltaR(gp, jet) << endl;
        }
        cout << "Found " << hvv_leptons.size() << " leptons from Higgs decay" << endl;
        for (const auto *gp : hvv_leptons) {
          using namespace std;
          printGenParticleInfo(gp, -1);
          cout << " ... dR(lep, jet) = " << deltaR(gp, jet) << endl;
        }
      }

      unsigned n_quarks_in_jet = 0;
      for (const auto *gp : hvv_quarks) {
        auto dr = deltaR(gp, jet);
        if (dr < jetR_) {
          ++n_quarks_in_jet;
        }
      }
      unsigned n_leptons_in_jet = 0;
      for (const auto *gp : hvv_leptons) {
        auto dr = deltaR(gp, jet);
        if (dr < jetR_) {
          ++n_leptons_in_jet;
        }
      }

      if (n_quarks_in_jet >= 4) {
        return std::make_pair(FatJetLabel::H_ww4q, higgs);
      } else if (n_quarks_in_jet == 2 && n_leptons_in_jet == 1) {
        return std::make_pair(FatJetLabel::H_ww2q1l, higgs);
      }
    } else if (isHadronic(higgs, true)) {
      // direct h->qq
      if (event_type_ == EventType::QCD) {
        event_type_ = EventType::Higgs;
      }

      if (debug_) {
        using namespace std;
        cout << "jet: (" << jet->PT << ", " << jet->Eta << ", " << jet->Phi << ", " << jet->P4().Energy() << ")"
             << endl;
        cout << "H:   ";
        printGenParticleInfo(higgs, -1);
      }

      auto hdaus = getDaughterQuarks(higgs, true);
      if (hdaus.size() < 2)
        throw std::logic_error("[FatJetMatching::higgs_label] Higgs decay has less than 2 quarks!");
      //    if (zdaus.size() >= 2)
      {
        double dr_q1 = deltaR(jet, hdaus.at(0));
        double dr_q2 = deltaR(jet, hdaus.at(1));
        if (dr_q1 > dr_q2) {
          // swap q1 and q2 so that dr_q1<=dr_q2
          std::swap(dr_q1, dr_q2);
          std::swap(hdaus.at(0), hdaus.at(1));
        }
        auto pdgid_q1 = std::abs(hdaus.at(0)->PID);
        auto pdgid_q2 = std::abs(hdaus.at(1)->PID);

        if (debug_) {
          using namespace std;
          cout << "deltaR(jet, q1)    : " << dr_q1 << endl;
          cout << "deltaR(jet, q2)    : " << dr_q2 << endl;
          cout << "pdgid(q1)        : " << pdgid_q1 << endl;
          cout << "pdgid(q2)        : " << pdgid_q2 << endl;
        }

        if (dr_q1 < jetR_ && dr_q2 < jetR_) {
          if (pdgid_q1 == ParticleID::p_b && pdgid_q2 == ParticleID::p_b) {
            return std::make_pair(FatJetLabel::H_bb, higgs);
          } else if (pdgid_q1 == ParticleID::p_c && pdgid_q2 == ParticleID::p_c) {
            return std::make_pair(FatJetLabel::H_cc, higgs);
          } else if (pdgid_q1 == ParticleID::p_g && pdgid_q2 == ParticleID::p_g) {
            return std::make_pair(FatJetLabel::H_gg, higgs);
          } else {
            return std::make_pair(FatJetLabel::H_qq, higgs);
          }
        }
      }
    }

    return std::make_pair(FatJetLabel::Invalid, nullptr);
  }

private:
  void printGenInfoHeader() const {
    using namespace std;
    cout << right << setw(6) << "#"
         << " " << setw(10) << "pdgId"
         << "  "
         << "Chg"
         << "  " << setw(10) << "Mass"
         << "  " << setw(48) << " Momentum" << left << "  " << setw(10) << "Mothers"
         << " " << setw(30) << "Daughters" << endl;
  }

  void printGenParticleInfo(const GenParticle *genParticle, const int idx) const {
    using namespace std;
    cout << right << setw(3) << genParticle->Status;
    cout << right << setw(3) << idx << " " << setw(10) << genParticle->PID << "  ";
    cout << right << "  " << setw(3) << genParticle->Charge << "  "
         << TString::Format("%10.3g", genParticle->Mass < 1e-5 ? 0 : genParticle->Mass);
    cout << left << setw(50)
         << TString::Format("  (E=%6.4g pT=%6.4g eta=%7.3g phi=%7.3g)",
                            genParticle->P4().Energy(),
                            genParticle->PT,
                            genParticle->Eta,
                            genParticle->Phi);

    TString mothers;
    if (genParticle->M1 >= 0) {
      mothers += genParticle->M1;
    }
    if (genParticle->M2 >= 0) {
      mothers += ",";
      mothers += genParticle->M2;
    }
    cout << "  " << setw(10) << mothers;

    TString daughters;
    for (unsigned int iDau = genParticle->D1; iDau <= genParticle->D2; ++iDau) {
      if (daughters.Length())
        daughters += ",";
      daughters += iDau;
    }
    cout << " " << setw(30) << daughters << endl;
  }

  const GenParticle *getFinal(const GenParticle *particle) {
    // will mark intermediate particles as processed
    if (!particle)
      return nullptr;
    processed_.insert(particle);
    const GenParticle *final = particle;

    while (final->D1 >= 0) {
      const GenParticle *chain = nullptr;
      for (unsigned idau = final->D1; idau <= final->D2; ++idau) {
        if (genParticles_.at(idau)->PID == particle->PID) {
          chain = genParticles_.at(idau);
          processed_.insert(chain);
          break;
        }
      }
      if (!chain)
        break;
      final = chain;
    }
    return final;
  }

  bool isHadronic(const GenParticle *particle, bool allow_gluon = false) const {
    // particle needs to be the final version before decay
    if (!particle)
      throw std::invalid_argument("[FatJetMatching::isHadronic()] Null particle!");
    for (const auto *dau : getDaughters(particle)) {
      auto pdgid = std::abs(dau->PID);
      if (pdgid >= ParticleID::p_d && pdgid <= ParticleID::p_b)
        return true;
      if (allow_gluon && pdgid == ParticleID::p_g)
        return true;
    }
    return false;
  }

  std::vector<const GenParticle *> getDaughters(const GenParticle *particle) const {
    std::vector<const GenParticle *> daughters;
    for (int idau = particle->D1; idau <= particle->D2; ++idau) {
      daughters.push_back(genParticles_.at(idau));
    }
    return daughters;
  }

  std::vector<const GenParticle *> getDaughterQuarks(const GenParticle *particle, bool allow_gluon = false) {
    std::vector<const GenParticle *> daughters;
    for (int idau = particle->D1; idau <= particle->D2; ++idau) {
      const auto *dau = genParticles_.at(idau);
      auto pdgid = std::abs(dau->PID);
      if (pdgid >= ParticleID::p_d && pdgid <= ParticleID::p_b) {
        daughters.push_back(dau);
      }
      if (allow_gluon && pdgid == ParticleID::p_g) {
        daughters.push_back(dau);
      }
    }
    return daughters;
  }

private:
  double jetR_ = 0.8;
  bool debug_ = false;
  std::vector<const GenParticle *> genParticles_;
  std::unordered_set<const GenParticle *> processed_;
  EventType event_type_ = EventType::QCD;
};

struct ParticleInfo {
  ParticleInfo(const GenParticle *particle) {
    pt = particle->PT;
    eta = particle->Eta;
    phi = particle->Phi;
    mass = particle->Mass;
    p4 = ROOT::Math::PtEtaPhiMVector(pt, eta, phi, mass);
    px = p4.px();
    py = p4.py();
    pz = p4.pz();
    energy = p4.energy();
    charge = particle->Charge;
    pid = particle->PID;
  }

  ParticleInfo(const ParticleFlowCandidate *particle) {
    pt = particle->PT;
    eta = particle->Eta;
    phi = particle->Phi;
    mass = particle->Mass;
    p4 = ROOT::Math::PtEtaPhiMVector(pt, eta, phi, mass);
    px = p4.px();
    py = p4.py();
    pz = p4.pz();
    energy = p4.energy();
    charge = particle->Charge;
    pid = particle->PID;
    d0 = particle->D0;
    d0err = particle->ErrorD0;
    dz = particle->DZ;
    dzerr = particle->ErrorDZ;
  }

  double pt;
  double eta;
  double phi;
  double mass;
  double px;
  double py;
  double pz;
  double energy;
  ROOT::Math::PtEtaPhiMVector p4;

  int charge;
  int pid;

  float d0 = 0;
  float d0err = 0;
  float dz = 0;
  float dzerr = 0;
};

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
