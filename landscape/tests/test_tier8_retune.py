"""
Tier 8 -- the lambda retuning.

instructions section 10 asks for L-B with lambda retuned; the claim this tier
has to defend is not that the retuning is arithmetically right (it is a closed
form) but that it is SAFE -- that raising lambda by a factor 27 changes the
rate and the lifetimes and nothing else.  If it quietly changed the cascade,
L-B would no longer be the point the paper describes and the comparison with
L-B-displaced would not be controlled.

  * Gamma(h -> phi phi) is exactly quadratic in lambda, so lambda_for_br
    inverts it exactly in both BR conventions;
  * the two conventions differ by the factor deviation 7d predicts, and tuning
    the Julia's number to the bound would put the physical BR over it;
  * the hidden-sector fraction of every scalar's width is unchanged across the
    retuning, which is the only quantity lambda can move in the cascade;
  * the multiplicity distribution is therefore unchanged, checked directly;
  * ctau below the hidden-pair threshold goes as lambda^-2, which is the change
    the retuning DOES make and the reason L-B-displaced is kept.
"""

import math
import os
import random
import sys
import unittest
from dataclasses import replace

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__)))))

from landscape.params import (SMConstants, ModelParams, BENCHMARKS,   # noqa: E402
                              benchmark_entry, LAMBDA_RETUNED)
from landscape.generate import draw_spectrum                          # noqa: E402
from landscape import production as P                                 # noqa: E402
from landscape import branching as B                                  # noqa: E402
from landscape import cascade as CAS                                  # noqa: E402
from landscape import lifetimes as LT                                 # noqa: E402
from landscape import retune as RT                                    # noqa: E402

CONSTS = SMConstants()
SHIPPED = ModelParams()
SPECTRUM = draw_spectrum(SHIPPED, 424242)
RETUNED = replace(SHIPPED, lam=LAMBDA_RETUNED)


class TestClosedForm(unittest.TestCase):

    def test_width_is_quadratic_in_lambda(self):
        g0 = RT.hidden_width_gev(SPECTRUM, CONSTS, SHIPPED)
        for k in (2.0, 13.7, 1e3):
            g = RT.hidden_width_gev(SPECTRUM, CONSTS,
                                    replace(SHIPPED, lam=SHIPPED.lam * k))
            self.assertAlmostEqual(g / g0, k * k, delta=1e-9 * k * k)

    def test_lambda_for_br_inverts_physical(self):
        for target in (1e-3, 0.02, 0.1):
            lam = RT.lambda_for_br(target, SPECTRUM, CONSTS, SHIPPED)
            got = RT.br_h_to_bsm_physical(SPECTRUM, CONSTS,
                                          replace(SHIPPED, lam=lam))
            self.assertAlmostEqual(got, target, places=12)

    def test_lambda_for_br_inverts_code(self):
        for target in (1e-3, 0.02, 0.1):
            lam = RT.lambda_for_br(target, SPECTRUM, CONSTS, SHIPPED, "code")
            got = P.br_h_to_bsm(SPECTRUM, CONSTS, replace(SHIPPED, lam=lam))
            self.assertAlmostEqual(got, target, places=12)

    def test_lambda_for_br_rejects_impossible_targets(self):
        for bad in (0.0, 1.0, 1.5, -0.1):
            self.assertRaises(ValueError, RT.lambda_for_br, bad, SPECTRUM,
                              CONSTS, SHIPPED)

    def test_conventions_differ_by_the_pole_mass_factor(self):
        """Deviation 7d: the Julia divides by Gamma_bb(pole) * 1.89 = 8.13e-3
        GeV where the true SM width is 4.1e-3, so its BR is low by ~2x."""
        denom = P.gamma_bb(CONSTS) * 1.89
        self.assertAlmostEqual(denom, 8.13e-3, delta=0.02e-3)
        ratio = denom / RT.GAMMA_H_SM_GEV
        self.assertGreater(ratio, 1.9)
        print("\n  Tier 8: Julia normalisation {0:.4g} GeV vs SM {1:.4g} GeV, "
              "ratio {2:.3f}".format(denom, RT.GAMMA_H_SM_GEV, ratio))

    def test_tuning_the_code_br_to_the_bound_overshoots_physically(self):
        """The trap the physical convention exists to avoid."""
        lam = RT.lambda_for_br(RT.BR_BOUND, SPECTRUM, CONSTS, SHIPPED, "code")
        phys = RT.br_h_to_bsm_physical(SPECTRUM, CONSTS,
                                       replace(SHIPPED, lam=lam))
        self.assertGreater(phys, RT.BR_BOUND)
        print("  Tier 8: tuning the Julia BR to {0:g} gives a physical BR of "
              "{1:.4g} -- over the bound".format(RT.BR_BOUND, phys))


class TestBenchmarkPoint(unittest.TestCase):

    def test_lb_sits_just_under_the_bound(self):
        model, mode, seed = benchmark_entry("L-B")
        self.assertEqual(mode, "higgs")
        br = RT.br_h_to_bsm_physical(draw_spectrum(model, seed), CONSTS, model)
        self.assertLessEqual(br, RT.BR_BOUND)
        self.assertGreater(br, 0.09)
        print("\n  Tier 8: L-B physical BR(h -> BSM) = {0:.4g}".format(br))

    def test_every_benchmark_respects_the_bound(self):
        for tag in sorted(BENCHMARKS):
            model, mode, seed = benchmark_entry(tag)
            br = RT.br_h_to_bsm_physical(draw_spectrum(model, seed), CONSTS,
                                         model)
            self.assertLessEqual(br, RT.BR_BOUND * (1 + 1e-9), tag)

    def test_control_tracks_the_retuning(self):
        """L-C is 'as L-B with lambda'/lambda ~ 1e-6' (section 10), so pinning
        lambda' to an absolute value would have broken it when lambda moved."""
        lb = benchmark_entry("L-B")[0]
        lc = benchmark_entry("L-C")[0]
        self.assertEqual(lc.lam, lb.lam)
        self.assertAlmostEqual(lc.lam_prime / lc.lam, 1e-6, places=15)

    def test_displaced_point_keeps_the_shipped_lambda(self):
        self.assertEqual(benchmark_entry("L-B-displaced")[0].lam, 1e-4)
        self.assertEqual(benchmark_entry("L-B-displaced")[1], "higgs")

    def test_ld_points_differ_only_in_spectrum(self):
        base, mode, seed = benchmark_entry("L-B")
        seeds = set()
        for tag in ("L-D1", "L-D2", "L-D3"):
            m, md, s = benchmark_entry(tag)
            self.assertEqual(m, base)
            self.assertEqual(md, mode)
            seeds.add(s)
        self.assertEqual(len(seeds), 3)
        self.assertNotIn(seed, seeds)


class TestCascadeIsUnchanged(unittest.TestCase):

    def test_hidden_fraction_is_invariant(self):
        worst, rows = RT.cascade_invariance(SPECTRUM, CONSTS, SHIPPED, RETUNED)
        self.assertLess(worst, 1e-4)
        above = [r for r in rows if r[1] > 0.0]
        self.assertTrue(above)
        self.assertGreater(min(r[1] for r in above), 1.0 - 1e-6)
        print("\n  Tier 8 cascade invariance: largest change in hidden "
              "fraction over {0} scalars = {1:.3e}".format(len(rows), worst))

    def test_multiplicity_distribution_is_unchanged(self):
        """The consequence of the above, measured rather than argued."""
        CAS.branching_ratios_general_quartic = (
            B.branching_ratios_general_quartic_fast)
        out = []
        for model in (SHIPPED, RETUNED):
            stream = CAS.UniformStream(rng=random.Random(20250819))
            rng = random.Random(31337)
            mult = []
            for _ in range(400):
                m = SPECTRUM[rng.randrange(len(SPECTRUM))]
                _, prods = CAS.decay_tree_general_quartic(
                    m, SPECTRUM, CONSTS, model, stream)
                mult.append(len(prods or []))
            out.append(mult)
        a, b = out
        # Same uniform stream and same starting masses: if the branching
        # ratios really are unchanged to 1e-5, the chains are identical.
        self.assertEqual(a, b)
        print("  Tier 8: 400 cascades identical between shipped and retuned "
              "lambda, mean multiplicity {0:.2f}".format(sum(a) / len(a)))


class TestLifetimesDoChange(unittest.TestCase):

    def test_sub_threshold_ctau_scales_as_lambda_to_the_minus_two(self):
        m = min(SPECTRUM)
        c_shipped = B.ctau_mm(m, SPECTRUM, CONSTS, SHIPPED)
        c_retuned = B.ctau_mm(m, SPECTRUM, CONSTS, RETUNED)
        expect = (SHIPPED.lam / RETUNED.lam) ** 2
        self.assertAlmostEqual(c_retuned / c_shipped, expect, places=9)

    def test_the_sample_flips_from_displaced_to_prompt(self):
        s = LT.summarise(SPECTRUM, CONSTS, SHIPPED)
        r = LT.summarise(SPECTRUM, CONSTS, RETUNED)
        self.assertGreater(s["below_median_mm"], 1.0)     # millimetres
        self.assertLess(r["below_median_mm"], 0.02)       # microns
        print("\n  Tier 8 lifetimes: median sub-threshold ctau {0:.4g} mm at "
              "lambda = {1:g}, {2:.4g} mm at lambda = {3:g}".format(
                  s["below_median_mm"], SHIPPED.lam,
                  r["below_median_mm"], RETUNED.lam))

    def test_the_threshold_itself_does_not_move(self):
        """It is set by the spectrum, not by any coupling."""
        self.assertEqual(LT.hidden_channel_threshold(SPECTRUM),
                         2.0 * min(SPECTRUM))


if __name__ == "__main__":
    unittest.main(verbosity=2)
