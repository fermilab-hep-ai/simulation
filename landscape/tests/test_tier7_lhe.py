"""
Tier 7 -- LHE record structure.

The two things that would silently change the physics are colour flow and the
displaced vertices, so both get explicit tests:

  * every colour tag is used exactly twice, once as a colour and once as an
    anticolour;
  * both users of a tag share the same mother, i.e. colour is connected WITHIN
    a decay and never across the cascade (the incoming pair excepted, which is
    the one legitimate cross-connection);
  * intermediate scalars carry their proper decay length in VTIMUP and
    final-state particles do not, because without that the whole sample would
    be prompt.

Plus the ordinary structural invariants: valid mother indices, momentum
conservation between the incoming and final states, and a write/read round
trip through the file format.
"""

import math
import os
import sys
import tempfile
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__)))))

from landscape.params import SMConstants, ModelParams                # noqa: E402
from landscape.generate import Generator                             # noqa: E402
from landscape.hardprocess import ApproximateGluonLuminosity, initial_state  # noqa: E402
from landscape import lhe as LHE                                     # noqa: E402
from landscape import cascade as CAS                                 # noqa: E402

CONSTS = SMConstants()
MODEL = ModelParams(N=40, lam=1e-4, lam_prime=1e-4, M_star=10000.0,
                    vev_2=0.9 * 246.0)


def make_events(n, mode="direct", seed=321):
    gen = Generator(MODEL, CONSTS, spectrum_seed=99, mode=mode,
                    luminosity=ApproximateGluonLuminosity(), seed=seed)
    return list(gen.events(n)), gen


class TestColourFlow(unittest.TestCase):

    def test_tags_balance(self):
        events, _ = make_events(300)
        for parts in events:
            self.assertEqual(LHE.check_colour_flow(parts), [])
        print("\n  Tier 7 colour: 300 events, every tag used once as colour "
              "and once as anticolour")

    def test_colour_is_local_to_each_decay(self):
        """The failure this guards against is a colour line joining partons
        from different phi decays, which builds a string across the event."""
        events, _ = make_events(300)
        crossings = 0
        checked = 0
        for parts in events:
            users = {}
            for i, p in enumerate(parts, 1):
                for tag in (p.col, p.acol):
                    if tag:
                        users.setdefault(tag, []).append(i)
            for tag, idx in users.items():
                a, b = idx
                pa, pb = parts[a - 1], parts[b - 1]
                if pa.status == -1 and pb.status == -1:
                    continue          # the incoming pair, legitimately joined
                checked += 1
                if pa.mother1 != pb.mother1:
                    crossings += 1
        self.assertEqual(crossings, 0)
        print("  Tier 7 colour locality: {0} colour lines checked, 0 span "
              "different decays".format(checked))

    def test_gluon_pair_is_a_closed_loop(self):
        events, _ = make_events(400)
        loops = 0
        for parts in events:
            for i, p in enumerate(parts, 1):
                if p.pdg != 21 or p.status != 1:
                    continue
                sib = [q for j, q in enumerate(parts, 1)
                       if j != i and q.mother1 == p.mother1]
                self.assertEqual(len(sib), 1)
                s = sib[0]
                self.assertEqual(p.col, s.acol)
                self.assertEqual(p.acol, s.col)
                loops += 1
        self.assertGreater(loops, 0)
        print("  Tier 7 colour: {0} final gluons, each in a closed loop with "
              "its own sibling".format(loops))


class TestStructure(unittest.TestCase):

    def test_mothers_are_valid_and_ordered(self):
        events, _ = make_events(200)
        for parts in events:
            self.assertEqual(parts[0].status, -1)
            self.assertEqual(parts[1].status, -1)
            for i, p in enumerate(parts, 1):
                if p.status == -1:
                    self.assertEqual((p.mother1, p.mother2), (0, 0))
                    continue
                self.assertGreaterEqual(p.mother1, 1)
                # a mother must appear before its daughter
                self.assertLess(p.mother1, i)
                self.assertLess(p.mother2, i)

    def test_momentum_conserved(self):
        events, _ = make_events(300)
        worst = max(LHE.check_momentum(p) for p in events)
        self.assertLess(worst, 1e-5)
        print("\n  Tier 7 momentum: worst incoming-minus-final residual "
              "{0:.3e} GeV over 300 events".format(worst))

    def test_every_final_particle_has_a_pdg_code(self):
        events, _ = make_events(200)
        for parts in events:
            for p in parts:
                if p.status == 1:
                    self.assertNotEqual(p.pdg, 0)
                    self.assertNotEqual(p.pdg, LHE.BSM_SCALAR_ID,
                                        "an undecayed hidden scalar reached "
                                        "the final state")


class TestLifetimesInRecord(unittest.TestCase):

    def test_scalars_carry_vtim_and_leaves_do_not(self):
        events, _ = make_events(300)
        n_scalar = 0
        n_displaced = 0
        for parts in events:
            for p in parts:
                if p.status == 1:
                    self.assertEqual(p.vtim, 0.0)
                elif p.status == 2 and p.pdg == LHE.BSM_SCALAR_ID:
                    n_scalar += 1
                    self.assertGreaterEqual(p.vtim, 0.0)
                    if p.vtim > 0.1:
                        n_displaced += 1
        self.assertGreater(n_scalar, 0)
        self.assertGreater(n_displaced, 0,
                           "no scalar got a displaced proper length; the "
                           "sample would be prompt")
        print("\n  Tier 7 lifetimes: {0} scalars in the record, {1} ({2:.0%}) "
              "with ctau draw > 0.1 mm".format(
                  n_scalar, n_displaced, n_displaced / n_scalar))

    def test_pion_channel_labelling_follows_isospin(self):
        """Deviation 7e: the isospin-factor-2 channel is physically pi+ pi-
        even though the Julia gives it the pi0 mass value."""
        # the pion channels are rare, so this needs a large sample to make the
        # 2:1 isospin ratio a real test rather than a coin flip
        events, _ = make_events(4000)
        charged = neutral = 0
        for parts in events:
            for p in parts:
                if abs(p.pdg) == 211:
                    charged += 1
                    self.assertAlmostEqual(p.m, CONSTS.m_pi0, places=12)
                elif p.pdg == 111:
                    neutral += 1
                    self.assertAlmostEqual(p.m, CONSTS.m_pipm, places=12)
        self.assertGreater(charged, 0)
        self.assertGreater(neutral, 0)
        # the factor-2 channel must be the more common one
        self.assertGreater(charged, neutral)
        print("  Tier 7 pions: {0} pi+- (isospin factor 2) vs {1} pi0, ratio "
              "{2:.2f}".format(charged, neutral, charged / neutral))


class TestFileRoundTrip(unittest.TestCase):

    def test_write_then_read(self):
        events, gen = make_events(50)
        fd, path = tempfile.mkstemp(suffix=".lhe")
        os.close(fd)
        try:
            n = LHE.write_lhe(path, events, gen.cross_section_pb(),
                              comments=["unit test"])
            self.assertEqual(n, 50)
            back = list(LHE.read_lhe(path))
            self.assertEqual(len(back), 50)
            for a, b in zip(events, back):
                self.assertEqual(len(a), len(b))
                for pa, pb in zip(a, b):
                    self.assertEqual(pa.pdg, pb.pdg)
                    self.assertEqual(pa.status, pb.status)
                    self.assertEqual((pa.col, pa.acol), (pb.col, pb.acol))
                    self.assertAlmostEqual(pa.px, pb.px, places=6)
                    self.assertAlmostEqual(pa.e, pb.e, places=6)
            print("\n  Tier 7 file: 50 events survive a write/read round trip "
                  "intact")
        finally:
            os.unlink(path)


class TestHiggsMode(unittest.TestCase):

    def test_higgs_root_and_two_cascades(self):
        events, gen = make_events(100, mode="higgs", seed=808)
        for parts in events:
            root = parts[2]
            self.assertEqual(root.pdg, 25)
            self.assertEqual(root.status, 2)
            self.assertAlmostEqual(root.m, CONSTS.m_h, places=9)
            self.assertEqual(root.vtim, 0.0)     # the Higgs is prompt
            kids = [p for p in parts if p.mother1 == 3]
            self.assertEqual(len(kids), 2)
            for k in kids:
                self.assertEqual(k.pdg, LHE.BSM_SCALAR_ID)
        worst = max(LHE.check_momentum(p) for p in events)
        self.assertLess(worst, 1e-5)
        print("\n  Tier 7 higgs mode: 100 events, Higgs root at {0} GeV with "
              "two hidden daughters, worst residual {1:.2e} GeV".format(
                  CONSTS.m_h, worst))


class TestHardProcess(unittest.TestCase):

    def test_initial_state_reconstructs_the_mass(self):
        for m in (0.8, 5.0, 125.11):
            for y in (-3.0, 0.0, 2.5):
                x1, x2, g1, g2 = initial_state(m, y)
                s = g1 + g2
                self.assertAlmostEqual(s.mass, m, places=7)
                self.assertLess(s.pt, 1e-12)
                self.assertAlmostEqual(s.rapidity, y, places=9)
                self.assertAlmostEqual(0.5 * math.log(x1 / x2), y, places=9)


if __name__ == "__main__":
    unittest.main(verbosity=2)
