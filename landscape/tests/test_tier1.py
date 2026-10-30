"""
Tier 1 -- deterministic functions, exact agreement with the Julia.

Every width and branching-ratio function is deterministic, so agreement should
be to floating-point round-off.  The tolerance is relative 1e-12, as specified.

The branching-ratio check compares the FULL output of
BranchingRatiosgeneralquartic -- the ratios and both daughter-mass arrays,
element by element and in order.  The cascade indexes into these by position,
so an ordering difference is a silent correctness bug that comparing widths
alone would not catch.

Regenerate the reference with:
    JULIA_DEPOT_PATH=<depot> julia landscape/julia_ref/dump_tier1.jl \
        landscape/julia_ref/fixtures
"""

import csv
import math
import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__)))))

from landscape.params import SMConstants, ModelParams          # noqa: E402
from landscape import widths as W                              # noqa: E402
from landscape import branching as B                           # noqa: E402
from landscape import production as P                          # noqa: E402

FIXTURES = os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "julia_ref", "fixtures")

RTOL = 1e-12

CONSTS = SMConstants()
MODEL = ModelParams(N=200, lam=1e-4, lam_prime=1e-4, M_star=10000.0,
                    vev_2=0.9 * 246.0)


def rel_close(a, b, rtol=RTOL):
    if a == b:
        return True
    if a == 0.0 or b == 0.0:
        return abs(a - b) <= 1e-300
    return abs(a - b) / abs(b) <= rtol


def read_csv(name):
    with open(os.path.join(FIXTURES, name)) as fh:
        return list(csv.DictReader(fh))


class TestWidths(unittest.TestCase):
    """Single-argument widths across every threshold."""

    def test_widths(self):
        rows = read_csv("widths.csv")
        self.assertGreater(len(rows), 50)
        worst = 0.0
        for r in rows:
            m = float(r["m"])
            checks = [
                ("photons", W.width_to_photons(m, CONSTS, MODEL)),
                ("pions", W.width_to_pions(m, CONSTS, MODEL)),
                ("gluons", W.width_to_gluons(m, CONSTS, MODEL)),
                ("WW", W.width_scalar_to_WW(m, CONSTS, MODEL)
                 if m > 2 * CONSTS.m_W else 0.0),
                ("ZZ", W.width_scalar_to_ZZ(m, CONSTS, MODEL)
                 if m > 2 * CONSTS.m_Z else 0.0),
                ("bb", W.width_scalar_to_fermions(m, CONSTS.m_b, CONSTS.y_b, 3,
                                                  CONSTS, MODEL)
                 if m > 2 * CONSTS.m_b else 0.0),
                ("cc", W.width_scalar_to_fermions(m, CONSTS.m_charm, CONSTS.y_c,
                                                  3, CONSTS, MODEL)
                 if m > 2 * CONSTS.m_charm else 0.0),
                ("tautau", W.width_scalar_to_fermions(m, CONSTS.m_tau,
                                                      CONSTS.y_tau, 1, CONSTS, MODEL)
                 if m > 2 * CONSTS.m_tau else 0.0),
                ("ss", W.width_scalar_to_fermions(m, CONSTS.m_strange, CONSTS.y_s,
                                                  3, CONSTS, MODEL)
                 if m > 2 * CONSTS.m_strange else 0.0),
                ("mumu", W.width_scalar_to_fermions(m, CONSTS.m_muon,
                                                    CONSTS.y_muon, 1, CONSTS, MODEL)
                 if m > 2 * CONSTS.m_muon else 0.0),
                ("ee", W.width_scalar_to_fermions(m, CONSTS.m_electron,
                                                  CONSTS.y_e, 1, CONSTS, MODEL)
                 if m > 2 * CONSTS.m_electron else 0.0),
                ("tt", W.width_scalar_to_fermions(m, CONSTS.m_top, CONSTS.y_t, 3,
                                                  CONSTS, MODEL)
                 if m > 2 * CONSTS.m_top else 0.0),
            ]
            for key, got in checks:
                want = float(r[key])
                if want != 0.0 and got != 0.0:
                    worst = max(worst, abs(got - want) / abs(want))
                self.assertTrue(
                    rel_close(got, want),
                    "m={0!r} channel={1}: python={2!r} julia={3!r}".format(
                        m, key, got, want))
        print("\n  Tier 1 widths: {0} mass points, worst relative "
              "deviation {1:.3e}".format(len(rows), worst))


class TestPairWidth(unittest.TestCase):
    """Hidden-sector two-body width, including below-threshold zeros."""

    def test_pair_width(self):
        rows = read_csv("pairwidth.csv")
        self.assertGreater(len(rows), 100)
        nzero = 0
        for r in rows:
            m, m1, m2 = float(r["m"]), float(r["m1"]), float(r["m2"])
            want = float(r["width"])
            got = W.width_scalar_to_scalar_general_quartic(m, m1, m2, MODEL)
            if want == 0.0:
                nzero += 1
            self.assertTrue(
                rel_close(got, want),
                "m={0} m1={1} m2={2}: python={3!r} julia={4!r}".format(
                    m, m1, m2, got, want))
        print("  Tier 1 pair width: {0} combinations "
              "({1} below threshold)".format(len(rows), nzero))


class TestBranchingOrdering(unittest.TestCase):
    """
    Full BranchingRatiosgeneralquartic output, element by element AND in order.
    """

    def test_branching(self):
        with open(os.path.join(FIXTURES, "spectrum.csv")) as fh:
            spectrum = [float(line.strip()) for line in fh if line.strip()]
        rows = read_csv("branching.csv")
        by_mass = {}
        for r in rows:
            by_mass.setdefault(r["m"], []).append(r)

        total_entries = 0
        for mkey, entries in sorted(by_mass.items(), key=lambda kv: float(kv[0])):
            m = float(mkey)
            br, m1, m2 = B.branching_ratios_general_quartic(
                m, spectrum, CONSTS, MODEL)
            self.assertEqual(
                len(br), len(entries),
                "m={0}: channel count python={1} julia={2}".format(
                    m, len(br), len(entries)))
            entries.sort(key=lambda r: int(r["index"]))
            for k, r in enumerate(entries):
                self.assertTrue(
                    rel_close(br[k], float(r["BR"])),
                    "m={0} k={1}: BR python={2!r} julia={3!r}".format(
                        m, k, br[k], float(r["BR"])))
                self.assertTrue(
                    rel_close(m1[k], float(r["mass1"])),
                    "m={0} k={1}: mass1 python={2!r} julia={3!r} "
                    "(ORDERING BUG)".format(m, k, m1[k], float(r["mass1"])))
                self.assertTrue(
                    rel_close(m2[k], float(r["mass2"])),
                    "m={0} k={1}: mass2 python={2!r} julia={3!r} "
                    "(ORDERING BUG)".format(m, k, m2[k], float(r["mass2"])))
            total_entries += len(br)
        print("  Tier 1 branching: {0} mass points, {1} channel entries "
              "compared in order".format(len(by_mass), total_entries))

    def test_br_sums_to_one(self):
        with open(os.path.join(FIXTURES, "spectrum.csv")) as fh:
            spectrum = [float(line.strip()) for line in fh if line.strip()]
        for m in (0.5, 2.5, 9.5, 200.0):
            br, _, _ = B.branching_ratios_general_quartic(
                m, spectrum, CONSTS, MODEL)
            self.assertAlmostEqual(sum(br), 1.0, places=12)


class TestProduction(unittest.TestCase):
    """Production probabilities and cross sections."""

    def setUp(self):
        with open(os.path.join(FIXTURES, "spectrum.csv")) as fh:
            self.spectrum = [float(l.strip()) for l in fh if l.strip()]

    def test_production(self):
        rows = read_csv("production.csv")
        pp, sig_pp = P.production_prob(self.spectrum, CONSTS, MODEL)
        xs, sig_xs = P.cross_sections(self.spectrum, CONSTS, MODEL)
        ho, _ = P.cross_sections_higgs_only(self.spectrum, CONSTS, MODEL)
        self.assertNotEqual(sig_pp, sig_xs, "the two sigma_h values must differ")
        for k, r in enumerate(rows):
            self.assertTrue(rel_close(pp[k], float(r["prodprob"])),
                            "prodprob[{0}]".format(k))
            self.assertTrue(rel_close(xs[k], float(r["crosssection"])),
                            "crosssection[{0}]".format(k))
            self.assertTrue(rel_close(ho[k], float(r["higgsonly"])),
                            "higgsonly[{0}]".format(k))
        print("  Tier 1 production: {0} scalars, sigma_h "
              "{1:g} (ProductionProb) vs {2:g} (Crosssections) barns".format(
                  len(rows), sig_pp, sig_xs))

    def test_higgs_pairs(self):
        rows = read_csv("higgspairs.csv")
        probs, m1, m2, brsum, _ = P.production_prob_higgs_pairs(
            self.spectrum, CONSTS, MODEL)
        julia_brsum = None
        k = 0
        for r in rows:
            if r["index"] == "BRSUM":
                julia_brsum = float(r["prob"])
                continue
            self.assertTrue(rel_close(probs[k], float(r["prob"])),
                            "pair prob[{0}]".format(k))
            self.assertTrue(rel_close(m1[k], float(r["mass1"])),
                            "pair mass1[{0}]".format(k))
            self.assertTrue(rel_close(m2[k], float(r["mass2"])),
                            "pair mass2[{0}]".format(k))
            k += 1
        self.assertIsNotNone(julia_brsum)
        self.assertTrue(rel_close(brsum, julia_brsum),
                        "summed BR(h->BSM): python={0!r} julia={1!r}".format(
                            brsum, julia_brsum))
        print("  Tier 1 higgs pairs: {0} pairs, summed BR(h->BSM) = "
              "{1:.4g}".format(k, brsum))


if __name__ == "__main__":
    unittest.main(verbosity=2)
