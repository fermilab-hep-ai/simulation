"""
Tier 6 -- lifetimes and displacement.

New code with no Julia counterpart, so again checked against invariants and
against closed-form expectations:

  * ctau = hbar*c / Gamma, with Gamma the sum of the same partial widths Tier 1
    already validated;
  * the spectrum splits at 2*min(spectrum), where the hidden pair channel
    opens, and the split is orders of magnitude wide;
  * an exponential proper-time draw has mean ctau;
  * lab-frame vertices are the parent's vertex plus (p/m)*tau, so the mean
    transverse displacement scales with the boost.
"""

import math
import os
import random
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__)))))

from landscape.params import SMConstants, ModelParams                # noqa: E402
from landscape import branching as B                                 # noqa: E402
from landscape import cascade as CAS                                 # noqa: E402
from landscape import kinematics as K                                # noqa: E402
from landscape import lifetimes as L                                 # noqa: E402

CONSTS = SMConstants()
MODEL = ModelParams(N=12, lam=1e-4, lam_prime=1e-4, M_star=10000.0,
                    vev_2=0.9 * 246.0)

BENCH = ModelParams(N=200, lam=1e-4, lam_prime=1e-4, M_star=10000.0,
                    vev_2=0.9 * 246.0)


def spectrum(seed=4242, n=12, low=0.7071, high=10.0):
    rng = random.Random(seed)
    return sorted(rng.uniform(low, high) for _ in range(n))


SPECTRUM = spectrum()
BENCH_SPECTRUM = spectrum(seed=424242, n=200, low=10 / math.sqrt(200), high=10.0)


class TestCtau(unittest.TestCase):

    def test_ctau_is_hbarc_over_width(self):
        m = SPECTRUM[-1]
        g = B.total_width(m, SPECTRUM, CONSTS, MODEL)
        self.assertAlmostEqual(
            B.ctau_mm(m, SPECTRUM, CONSTS, MODEL), B.HBARC_GEV_MM / g, places=20)

    def test_spectrum_splits_at_hidden_threshold(self):
        thr = L.hidden_channel_threshold(BENCH_SPECTRUM)
        self.assertAlmostEqual(thr, 2.0 * min(BENCH_SPECTRUM), places=12)
        table = L.ctau_table(BENCH_SPECTRUM, CONSTS, BENCH)
        below = [c for m, _, c in table if m <= thr]
        above = [c for m, _, c in table if m > thr]
        self.assertTrue(below and above)
        # the two populations must not overlap, and must be far apart
        self.assertGreater(min(below) / max(above), 1e6)
        print("\n  Tier 6: {0} scalars below threshold ({1:.4g} GeV), "
              "{2} above".format(len(below), thr, len(above)))
        print("    below: ctau median {0:.3e} mm   above: median {1:.3e} mm".
              format(sorted(below)[len(below) // 2],
                     sorted(above)[len(above) // 2]))

    def test_light_scalar_ctau_independent_of_lambda_prime(self):
        """Below threshold there is no hidden channel, so the width is pure
        mixing and lambda' cannot matter."""
        m = min(BENCH_SPECTRUM)
        a = B.ctau_mm(BENCH_SPECTRUM, CONSTS, BENCH) if False else B.ctau_mm(
            m, BENCH_SPECTRUM, CONSTS, BENCH)
        from dataclasses import replace
        b = B.ctau_mm(m, BENCH_SPECTRUM, CONSTS,
                      replace(BENCH, lam_prime=1e-10))
        self.assertAlmostEqual(a, b, places=12)
        print("    lightest scalar ctau {0:.4f} mm, identical for "
              "lambda' = 1e-4 and 1e-10".format(a))

    def test_benchmark_summary_prints(self):
        print("\n" + L.format_summary(BENCH_SPECTRUM, CONSTS, BENCH,
                                      label="L-A (shipped driver, N=200)"))


class TestProperTimeSampling(unittest.TestCase):

    def test_exponential_mean(self):
        rng = random.Random(1234)
        ctau = 2.5
        n = 200000
        s = sum(L.sample_proper_time_mm(ctau, rng.random()) for _ in range(n))
        mean = s / n
        # standard error of the mean of an exponential is ctau/sqrt(n)
        err = ctau / math.sqrt(n)
        self.assertLess(abs(mean - ctau), 5 * err)
        print("\n  Tier 6 proper time: mean {0:.4f} mm vs ctau {1} "
              "(+-{2:.4f} at 1 sigma)".format(mean, ctau, err))

    def test_u_zero_gives_zero(self):
        self.assertEqual(L.sample_proper_time_mm(3.0, 0.0), 0.0)


class TestVertices(unittest.TestCase):

    def _one_event(self, seed, root_pt):
        rng = random.Random(seed)
        cas = CAS.UniformStream(rng=rng)
        kin = CAS.UniformStream(rng=random.Random(seed + 1))
        life = CAS.UniformStream(rng=random.Random(seed + 2))
        m = SPECTRUM[-1]
        root, _ = CAS.decay_tree_general_quartic(m, SPECTRUM, CONSTS, MODEL, cas)
        p4 = K.FourVector.from_pt_rapidity_phi_m(root_pt, 0.0, 0.0, m)
        K.assign_kinematics(root, p4, kin)
        L.assign_proper_times(root, SPECTRUM, CONSTS, MODEL, life)
        L.assign_vertices(root)
        return root

    def test_vertices_are_causal_and_ordered(self):
        """A daughter's production vertex must be its parent's decay point, and
        the displacement must line up with the parent's momentum."""
        root = self._one_event(31415, 50.0)
        checked = 0
        for node in CAS.iter_nodes(root):
            if not node.children:
                continue
            px, py, pz = node.vertex_mm
            cx, cy, cz = node.children[0].vertex_mm
            dx, dy, dz = cx - px, cy - py, cz - pz
            step = math.sqrt(dx * dx + dy * dy + dz * dz)
            if step == 0.0:
                continue
            # displacement parallel to the parent momentum
            pmag = node.p4.p
            cosang = (dx * node.p4.px + dy * node.p4.py
                      + dz * node.p4.pz) / (step * pmag)
            self.assertAlmostEqual(cosang, 1.0, places=9)
            # and of the expected length beta*gamma*tau
            self.assertAlmostEqual(step, node.p4.p / node.mass * node.tau_mm,
                                   places=9)
            checked += 1
            # both children share the vertex
            self.assertEqual(node.children[0].vertex_mm,
                             node.children[1].vertex_mm)
        self.assertGreater(checked, 0)
        print("\n  Tier 6 vertices: {0} decays, all displaced along the parent "
              "momentum by beta*gamma*tau".format(checked))

    def test_displacement_grows_with_boost(self):
        def median_rxy(root_pt, seed):
            vals = []
            for k in range(300):
                r = self._one_event(seed + 7 * k, root_pt)
                for n in CAS.iter_nodes(r):
                    if not n.children:
                        vals.append(L.transverse_displacement_mm(n))
            vals.sort()
            return vals[len(vals) // 2]

        slow = median_rxy(5.0, 600)
        fast = median_rxy(200.0, 600)
        self.assertGreater(fast, slow)
        print("  Tier 6 boost dependence: median leaf r_xy {0:.4f} mm at root "
              "pT 5 GeV vs {1:.4f} mm at 200 GeV".format(slow, fast))


if __name__ == "__main__":
    unittest.main(verbosity=2)
