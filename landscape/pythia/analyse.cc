// Benchmark-level analysis of a showered landscape LHE.
//
//   g++ -O2 analyse.cc -o analyse $(pythia8-config --cxxflags --ldflags)
//   ./analyse <card.cmnd> [label]
//
// Extends pythia/roundtrip.cc with the observables the benchmarks are actually
// judged on:
//
//   * anti-kT R = 0.4 jets, so HT and the leading jet pT can be compared with
//     the Phase-2 L1 floors (PuppiHT 450, single PuppiJet 230).  This is the
//     "invisible to the menu" claim, and it cannot be checked at parton level.
//   * charged multiplicity and sum pT, split into the part descending from the
//     hard process and the rest of the event.
//   * hidden-scalar decay vertices, which is where the displacement lives.
//
// Truth-level Pythia with NO pileup and NO detector.  The repo's Delphes path
// is what turns this into PUPPI candidates; these numbers are an upper bound on
// what any trigger could see, so a point that misses a seed here misses it for
// real, while a point that passes here may still fail after PU200.

#include "Pythia8/Pythia.h"
#include <iostream>
#include <iomanip>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace Pythia8;

namespace {

double quant(std::vector<double>& v, double f) {
  if (v.empty()) return 0.0;
  std::sort(v.begin(), v.end());
  size_t k = static_cast<size_t>(f * v.size());
  if (k >= v.size()) k = v.size() - 1;
  return v[k];
}

double mean(const std::vector<double>& v) {
  if (v.empty()) return 0.0;
  double s = 0.0;
  for (double x : v) s += x;
  return s / v.size();
}

double fracAbove(std::vector<double> v, double thr) {
  if (v.empty()) return 0.0;
  size_t n = 0;
  for (double x : v) if (x > thr) ++n;
  return 100.0 * n / v.size();
}

void row(const char* name, std::vector<double> v) {
  std::cout << "  " << std::left << std::setw(34) << name << std::right
            << std::setw(10) << std::fixed << std::setprecision(2) << mean(v)
            << std::setw(10) << quant(v, 0.5)
            << std::setw(10) << quant(v, 0.9)
            << std::setw(10) << quant(v, 0.99) << "\n";
}

}  // namespace

int main(int argc, char* argv[]) {
  if (argc < 2) { std::cout << "usage: analyse <card.cmnd> [label]\n"; return 1; }
  const std::string label = (argc > 2) ? argv[2] : "sample";

  Pythia pythia;
  pythia.readFile(argv[1]);
  if (!pythia.init()) { std::cout << "INIT FAILED\n"; return 2; }

  // anti-kT R = 0.4.  pTmin 30 matches the HT constituent requirement in the
  // Phase-2 menu; select = 2 keeps visible final particles (no neutrinos).
  SlowJet jets(-1, 0.4, 30.0, 4.0, 2, 1);
  SlowJet jetsCentral(-1, 0.4, 30.0, 2.4, 2, 1);

  int nOk = 0, nFail = 0;
  long nch = 0, nsig = 0, nsigDisp = 0, nbkgDisp = 0;
  std::vector<double> ht, leadJet, nJet, chMult, sigMult, sigPt, evPt;
  std::vector<double> rxySig, vtxScalar, mHiggs, partonE;

  const int nEvent = pythia.mode("Main:numberOfEvents");
  for (int i = 0; i < nEvent; ++i) {
    if (!pythia.next()) { ++nFail; continue; }
    ++nOk;

    int iRoot = -1;
    for (int j = 0; j < pythia.event.size(); ++j)
      if (std::abs(pythia.event[j].id()) == 9000006) { iRoot = j; break; }

    for (int j = 0; j < pythia.event.size(); ++j) {
      const Particle& p = pythia.event[j];
      if (std::abs(p.id()) == 9000006 && p.daughter1() > 0) {
        const Particle& d = pythia.event[p.daughter1()];
        vtxScalar.push_back(std::hypot(d.xProd(), d.yProd()));
      }
    }

    double sp = 0.0, ep = 0.0;
    int nchEv = 0, nsigEv = 0;
    for (int j = 0; j < pythia.event.size(); ++j) {
      const Particle& p = pythia.event[j];
      if (!p.isFinal()) continue;
      if (std::abs(p.eta()) < 4.0) ep += p.pT();
      if (!p.isCharged() || std::abs(p.eta()) > 4.0 || p.pT() < 0.1) continue;
      ++nch; ++nchEv;
      const double r = std::hypot(p.xProd(), p.yProd());
      const bool fromSignal = (iRoot >= 0) && p.isAncestor(iRoot);
      if (fromSignal) {
        ++nsig; ++nsigEv; sp += p.pT(); rxySig.push_back(r);
        if (r > 0.1) ++nsigDisp;
      } else if (r > 0.1) {
        ++nbkgDisp;
      }
    }
    chMult.push_back(nchEv);
    sigMult.push_back(nsigEv);
    sigPt.push_back(sp);
    evPt.push_back(ep);

    jetsCentral.analyze(pythia.event);
    double sumJet = 0.0, lead = 0.0;
    for (int k = 0; k < jetsCentral.sizeJet(); ++k) {
      const double pt = jetsCentral.pT(k);
      sumJet += pt;
      if (pt > lead) lead = pt;
    }
    ht.push_back(sumJet);
    leadJet.push_back(lead);
    nJet.push_back(jetsCentral.sizeJet());
  }
  pythia.stat();

  const long nbkg = nch - nsig;
  std::cout << "\n================ " << label << " ================\n";
  std::cout << "events showered " << nOk << " ok, " << nFail << " failed\n\n";

  std::cout << "  " << std::left << std::setw(34) << "observable" << std::right
            << std::setw(10) << "mean" << std::setw(10) << "median"
            << std::setw(10) << "90%" << std::setw(10) << "99%" << "\n";
  std::cout << "  " << std::string(74, '-') << "\n";
  row("charged mult |eta|<4 pT>0.1", chMult);
  row("  of which from hard process", sigMult);
  row("signal charged sum pT [GeV]", sigPt);
  row("whole-event sum pT [GeV]", evPt);
  row("anti-kT R=0.4 jets pT>30 |eta|<2.4", nJet);
  row("HT of those jets [GeV]", ht);
  row("leading jet pT [GeV]", leadJet);
  row("signal charged r_xy [mm]", rxySig);
  row("hidden-scalar decay r_xy [mm]", vtxScalar);

  std::cout << "\n  Phase-2 L1 floors, truth level, no pileup:\n";
  std::cout << "    events with HT > 450 GeV        : "
            << std::setprecision(2) << fracAbove(ht, 450.0) << "%\n";
  std::cout << "    events with a jet > 230 GeV     : "
            << fracAbove(leadJet, 230.0) << "%\n";
  std::cout << "    events with HT > 300 GeV        : "
            << fracAbove(ht, 300.0) << "%\n";
  std::cout << "    events with any jet > 30 GeV    : "
            << fracAbove(nJet, 0.5) << "%\n";

  std::cout << "\n  displaced fractions (r_xy > 0.1 mm):\n";
  std::cout << "    signal charged        : "
            << 100.0 * nsigDisp / std::max(1L, nsig) << "%  ("
            << nsig << " particles, " << 100.0 * nsig / std::max(1L, nch)
            << "% of all charged)\n";
  std::cout << "    rest of event         : "
            << 100.0 * nbkgDisp / std::max(1L, nbkg) << "%\n";
  return 0;
}
