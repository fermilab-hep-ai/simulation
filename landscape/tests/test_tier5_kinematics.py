"""
Tier 5 -- kinematics.

There is no Julia reference for any of this: the model code tracks masses only
and has no four-vectors at all.  So this tier checks against physics invariants
instead, which is the stronger test anyway.

  * the tree-valued cascade reproduces the flat cascade exactly, product for
    product and uniform for uniform, so Tiers 1-3 still cover the tree;
  * four-momentum is conserved at every node;
  * every node's invariant mass reconstructs the mass it was assigned;
  * decays are isotropic in the parent rest frame (flat in cos(theta), which is
    the thing that is easy to get wrong);
  * boosts round-trip.
"""

import math
import os
import random
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__)))))

from landscape.params import SMConstants, ModelParams                # noqa: E402
from landscape import cascade as CAS                                 # noqa: E402
from landscape import kinematics as K                                # noqa: E402

CONSTS = SMConstants()
# A small N keeps the reference branching implementation fast; the tree logic
# is independent of N, and Tier 3 already covers N = 200.
MODEL = ModelParams(N=12, lam=1e-4, lam_prime=1e-4, M_star=10000.0,
                    vev_2=0.9 * 246.0)


def make_spectrum(seed=4242, n=12, low=0.7071, high=10.0):
    rng = random.Random(seed)
    return sorted(rng.uniform(low, high) for _ in range(n))


SPECTRUM = make_spectrum()


class TestFourVector(unittest.TestCase):

    def test_mass_and_kinematic_variables(self):
        v = K.FourVector.from_pt_eta_phi_m(30.0, 1.2, 0.7, 4.18)
        self.assertAlmostEqual(v.mass, 4.18, places=9)
        self.assertAlmostEqual(v.pt, 30.0, places=9)
        self.assertAlmostEqual(v.eta, 1.2, places=9)
        self.assertAlmostEqual(v.phi, 0.7, places=9)

    def test_rapidity_construction(self):
        v = K.FourVector.from_pt_rapidity_phi_m(15.0, -0.9, 2.1, 125.11)
        self.assertAlmostEqual(v.rapidity, -0.9, places=9)
        self.assertAlmostEqual(v.mass, 125.11, places=8)

    def test_boost_round_trip(self):
        parent = K.FourVector.from_pt_eta_phi_m(80.0, -0.6, 1.3, 10.0)
        v = K.FourVector.from_pt_eta_phi_m(12.0, 0.4, -2.0, 1.28)
        back = v.boost_to_rest_of(parent).boost_to_lab(parent)
        for a, b in ((v.e, back.e), (v.px, back.px),
                     (v.py, back.py), (v.pz, back.pz)):
            self.assertAlmostEqual(a, b, places=9)

    def test_boost_to_rest_frame_kills_momentum(self):
        parent = K.FourVector.from_pt_eta_phi_m(60.0, 1.1, 0.2, 8.0)
        rest = parent.boost_to_rest_of(parent)
        self.assertLess(rest.p, 1e-9)
        self.assertAlmostEqual(rest.e, 8.0, places=9)

    def test_two_body_momentum_closed_decay(self):
        self.assertEqual(K.two_body_momentum(1.0, 0.6, 0.6), 0.0)

    def test_two_body_momentum_massless(self):
        # m -> 0 0 gives |p| = m/2
        self.assertAlmostEqual(K.two_body_momentum(7.0, 0.0, 0.0), 3.5, places=12)


class TestTreeMatchesFlatCascade(unittest.TestCase):
    """The tree must not have changed the physics Tiers 1-3 pinned down."""

    def test_identical_products_and_stream_use(self):
        rng = random.Random(90210)
        pool = [rng.random() for _ in range(400000)]

        flat_stream = CAS.UniformStream.from_list(pool)
        tree_stream = CAS.UniformStream.from_list(pool)

        n_chains = 2000
        mismatches = 0
        n_products = 0
        for c in range(n_chains):
            root_m = SPECTRUM[c % len(SPECTRUM)]
            flat = CAS.decay_chain_general_quartic(
                root_m, SPECTRUM, CONSTS, MODEL, flat_stream)
            root, prods = CAS.decay_tree_general_quartic(
                root_m, SPECTRUM, CONSTS, MODEL, tree_stream)
            if flat != prods:
                mismatches += 1
            n_products += len(prods or [])
            # the tree's leaf count must equal the flat multiplicity
            if root is not None:
                self.assertEqual(len(CAS.leaves(root)), len(prods))

        self.assertEqual(mismatches, 0)
        self.assertEqual(flat_stream.consumed, tree_stream.consumed)
        print("\n  Tier 5 tree/flat: {0} chains identical, {1} products, "
              "{2} uniforms consumed by each".format(
                  n_chains, n_products, flat_stream.consumed))

    def test_leaf_species_match_flat_encoding(self):
        """The flat list encodes photons/gluons as the integers 1 and 2; the
        tree carries species names.  They must agree."""
        rng = random.Random(13579)
        stream_a = CAS.UniformStream(rng=random.Random(24680))
        stream_b = CAS.UniformStream(rng=random.Random(24680))
        counts_flat = {k: 0 for k in
                       CAS.flavour_counts([], CONSTS)}
        counts_tree = dict(counts_flat)
        for c in range(3000):
            root_m = SPECTRUM[rng.randrange(len(SPECTRUM))]
            flat = CAS.decay_chain_general_quartic(
                root_m, SPECTRUM, CONSTS, MODEL, stream_a)
            root, _ = CAS.decay_tree_general_quartic(
                root_m, SPECTRUM, CONSTS, MODEL, stream_b)
            for k, v in CAS.flavour_counts(flat, CONSTS).items():
                counts_flat[k] += v
            for leaf in CAS.leaves(root):
                counts_tree[leaf.species] += 1
        self.assertEqual(counts_flat, counts_tree)
        print("  Tier 5 species: flat and tree agree on all {0} channels, "
              "{1} leaves".format(len(counts_flat), sum(counts_tree.values())))


class TestCascadeKinematics(unittest.TestCase):

    def _events(self, n, root_pt=0.0, seed=555):
        rng = random.Random(seed)
        cas_stream = CAS.UniformStream(rng=rng)
        kin_stream = CAS.UniformStream(rng=random.Random(seed + 1))
        out = []
        for c in range(n):
            m = SPECTRUM[c % len(SPECTRUM)]
            root, prods = CAS.decay_tree_general_quartic(
                m, SPECTRUM, CONSTS, MODEL, cas_stream)
            if root is None:
                continue
            p4 = K.FourVector.from_pt_rapidity_phi_m(
                root_pt, rng.uniform(-2.5, 2.5), rng.uniform(0, 2 * math.pi), m)
            K.assign_kinematics(root, p4, kin_stream)
            out.append(root)
        return out

    def test_momentum_conservation_at_rest(self):
        worst = max(K.max_momentum_violation(r) for r in self._events(2000))
        self.assertLess(worst, 1e-9)
        print("\n  Tier 5 conservation (root at rest, 2000 events): worst "
              "residual {0:.3e} GeV".format(worst))

    def test_momentum_conservation_boosted(self):
        # A boosted root is the demanding case: gamma ~ 60/0.7 ~ 85 for the
        # lightest scalars, so cancellations in the boost are large.
        worst = max(K.max_momentum_violation(r)
                    for r in self._events(2000, root_pt=60.0, seed=777))
        self.assertLess(worst, 1e-7)
        print("  Tier 5 conservation (root pT = 60 GeV, 2000 events): worst "
              "residual {0:.3e} GeV".format(worst))

    def test_masses_reconstruct(self):
        events = self._events(2000, root_pt=60.0, seed=888)
        worst2 = max(K.max_mass2_closure(r) for r in events)
        worst_rel = max(K.max_mass_violation(r) for r in events)
        # the E^2-normalised residual is the quantity with a meaningful floor
        self.assertLess(worst2, 1e-12)
        print("  Tier 5 mass closure (2000 events): worst |dm^2|/E^2 "
              "{0:.3e}".format(worst2))
        print("           worst relative on m (massive nodes only) {0:.3e} -- "
              "this is the E^2-|p|^2 cancellation, not the boosts".format(
                  worst_rel))

    def test_total_energy_is_root_energy(self):
        worst = 0.0
        for r in self._events(500, root_pt=40.0, seed=999):
            total = K.visible_four_vector(r)
            d = total - r.p4
            worst = max(worst, abs(d.e) / r.p4.e)
        self.assertLess(worst, 1e-9)
        print("  Tier 5 leaf energy sum vs root energy: worst relative "
              "deviation {0:.3e}".format(worst))


class TestIsotropy(unittest.TestCase):

    def test_cos_theta_is_flat(self):
        """Flat in cos(theta), not in theta.  A chi2 over 20 bins."""
        rng = random.Random(31337)
        stream = CAS.UniformStream(rng=rng)
        parent = K.FourVector.from_pt_eta_phi_m(45.0, 0.8, 1.1, 10.0)
        nbin = 20
        n = 200000
        hist = [0] * nbin
        for _ in range(n):
            d1, _ = K.decay_two_body(parent, 4.18, 4.18, stream)
            rest = d1.boost_to_rest_of(parent)
            c = rest.pz / rest.p
            k = int((c + 1.0) / 2.0 * nbin)
            hist[min(max(k, 0), nbin - 1)] += 1
        expect = n / nbin
        chi2 = sum((h - expect) ** 2 / expect for h in hist)
        print("\n  Tier 5 isotropy: cos(theta*) chi2/ndf = {0:.1f}/{1} = "
              "{2:.2f}".format(chi2, nbin - 1, chi2 / (nbin - 1)))
        self.assertLess(chi2, 50.0)   # ndf = 19; 50 is ~p = 1e-4

    def test_phi_is_flat(self):
        rng = random.Random(4711)
        stream = CAS.UniformStream(rng=rng)
        parent = K.FourVector.from_mass_at_rest(10.0)
        nbin = 20
        n = 200000
        hist = [0] * nbin
        for _ in range(n):
            d1, _ = K.decay_two_body(parent, 0.0, 0.0, stream)
            k = int((d1.phi + math.pi) / (2 * math.pi) * nbin)
            hist[min(max(k, 0), nbin - 1)] += 1
        expect = n / nbin
        chi2 = sum((h - expect) ** 2 / expect for h in hist)
        print("  Tier 5 isotropy: phi chi2/ndf = {0:.1f}/{1} = {2:.2f}".format(
            chi2, nbin - 1, chi2 / (nbin - 1)))
        self.assertLess(chi2, 50.0)

    def test_two_body_energies_are_fixed(self):
        """In the rest frame a two-body decay is monochromatic; only the
        direction is random."""
        stream = CAS.UniformStream(rng=random.Random(2024))
        parent = K.FourVector.from_mass_at_rest(10.0)
        energies = []
        for _ in range(2000):
            d1, d2 = K.decay_two_body(parent, 4.18, 1.28, stream)
            energies.append(d1.e)
        self.assertLess(max(energies) - min(energies), 1e-9)
        expect = (10.0 ** 2 + 4.18 ** 2 - 1.28 ** 2) / (2 * 10.0)
        self.assertAlmostEqual(energies[0], expect, places=9)


if __name__ == "__main__":
    unittest.main(verbosity=2)
