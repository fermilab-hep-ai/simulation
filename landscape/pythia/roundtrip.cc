// Pythia round-trip check for an LHE written by landscape/lhe.py.
//
//   g++ -O2 roundtrip.cc -o roundtrip $(pythia8-config --cxxflags --ldflags)
//   ./roundtrip <card.cmnd>
//
// Reports the three things that can go wrong between the LHE and a showered
// event and that no Python-side test can see:
//
//   1. whether Pythia accepts the record at all (colour flow, masses,
//      mother/daughter structure);
//   2. whether the displaced vertices survive -- LesHouches:setLifetime must
//      be 1 (its default) for VTIMUP to be used; set it to 2 and every scalar
//      decay vertex collapses to the origin, which is the A/B that proves the
//      lifetimes are being honoured;
//   3. how much of the visible event is actually signal, as opposed to
//      initial-state radiation and the underlying event.
//
// Built as a standalone binary rather than wired into run.sh because it is a
// diagnostic, not part of sample production.

#include "Pythia8/Pythia.h"
#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>
#include <cmath>

using namespace Pythia8;

namespace {
double quantile(std::vector<double>& v, double f) {
  if (v.empty()) return 0.0;
  size_t k = static_cast<size_t>(f * v.size());
  if (k >= v.size()) k = v.size() - 1;
  return v[k];
}
}

int main(int argc, char* argv[]) {
  if (argc < 2) { std::cout << "usage: roundtrip <card.cmnd>\n"; return 1; }

  Pythia pythia;
  pythia.readFile(argv[1]);
  if (!pythia.init()) { std::cout << "INIT FAILED\n"; return 2; }

  long nch = 0, nsig = 0, nsigDisp = 0, nbkgDisp = 0;
  int nOk = 0, nFail = 0;
  std::vector<double> rxySig, rxyBkg, vtxScalar, sigPt, evPt, mult;

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
    int nchEv = 0;
    for (int j = 0; j < pythia.event.size(); ++j) {
      const Particle& p = pythia.event[j];
      if (!p.isFinal()) continue;
      if (std::abs(p.eta()) < 4.0) ep += p.pT();
      if (!p.isCharged() || std::abs(p.eta()) > 4.0 || p.pT() < 0.1) continue;
      ++nch; ++nchEv;
      const double r = std::hypot(p.xProd(), p.yProd());
      const bool fromSignal = (iRoot >= 0) && p.isAncestor(iRoot);
      if (fromSignal) {
        ++nsig; sp += p.pT(); rxySig.push_back(r);
        if (r > 0.1) ++nsigDisp;
      } else {
        rxyBkg.push_back(r);
        if (r > 0.1) ++nbkgDisp;
      }
    }
    sigPt.push_back(sp); evPt.push_back(ep); mult.push_back(nchEv);
  }
  pythia.stat();

  std::sort(rxySig.begin(), rxySig.end());
  std::sort(vtxScalar.begin(), vtxScalar.end());
  std::sort(sigPt.begin(), sigPt.end());
  std::sort(evPt.begin(), evPt.end());
  std::sort(mult.begin(), mult.end());

  const long nbkg = nch - nsig;
  std::cout << "\n=== ROUND TRIP SUMMARY ===\n";
  std::cout << "events showered ok " << nOk << ", failed " << nFail << "\n\n";

  std::cout << "charged particles, |eta| < 4 and pT > 0.1 GeV\n";
  std::cout << "  total " << nch << ", median per event " << quantile(mult, 0.5)
            << "\n";
  std::cout << "  from the hard process: " << nsig << " ("
            << 100.0 * nsig / std::max(1L, nch) << "%)\n";
  std::cout << "  displaced (r_xy > 0.1 mm), signal: "
            << 100.0 * nsigDisp / std::max(1L, nsig) << "%\n";
  std::cout << "  displaced (r_xy > 0.1 mm), rest of event: "
            << 100.0 * nbkgDisp / std::max(1L, nbkg) << "%\n\n";

  std::cout << "signal charged r_xy [mm]: median " << quantile(rxySig, 0.5)
            << "  90% " << quantile(rxySig, 0.9)
            << "  99% " << quantile(rxySig, 0.99) << "\n";
  std::cout << "hidden-scalar decay vertices r_xy [mm]: median "
            << quantile(vtxScalar, 0.5) << "  90% " << quantile(vtxScalar, 0.9)
            << "  max " << (vtxScalar.empty() ? 0.0 : vtxScalar.back()) << "\n\n";

  std::cout << "median sum pT (|eta| < 4): signal charged "
            << quantile(sigPt, 0.5) << " GeV, whole event "
            << quantile(evPt, 0.5) << " GeV\n";
  return 0;
}
