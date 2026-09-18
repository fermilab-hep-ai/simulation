"""
Tier 2 -- the cascade, exact agreement via injected randomness.

The cascade's only stochastic steps are the two Categorical draws (channel
choice, and the photon/gluon split).  Both implementations are driven by the
same pre-generated stream of uniforms, which turns a statistical comparison
into an exact one and catches off-by-one indexing, ordering and normalisation
errors that a KS test would miss.

Assert the returned Products lists are identical element by element over
10^4 chains.

Regenerate the reference with:
    JULIA_DEPOT_PATH=<depot> julia landscape/julia_ref/dump_tier2.jl \
        landscape/julia_ref/fixtures 10000
"""

import os
import sys
import unittest

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__)))))

from landscape.params import SMConstants, ModelParams          # noqa: E402
from landscape.cascade import (decay_chain_general_quartic,    # noqa: E402
                               UniformStream, categorical_sample)

FIXTURES = os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "julia_ref", "fixtures")

CONSTS = SMConstants()
MODEL = ModelParams(N=200, lam=1e-4, lam_prime=1e-4, M_star=10000.0,
                    vev_2=0.9 * 246.0)


def _load_column(path):
    with open(path) as fh:
        return [float(line.strip()) for line in fh if line.strip()]


class TestCategoricalConvention(unittest.TestCase):
    """
    The inverse-CDF convention must match Distributions.jl.  Verified against
    Julia separately; this pins the Python side so a refactor cannot drift.
    """

    def test_bin_edges(self):
        p = [0.25, 0.25, 0.5]
        s = UniformStream.from_list([0.0, 0.25, 0.2500001, 0.5, 0.9999999])
        self.assertEqual(categorical_sample(p, s), 1)   # u = 0
        self.assertEqual(categorical_sample(p, s), 1)   # u == cp exactly -> low
        self.assertEqual(categorical_sample(p, s), 2)
        self.assertEqual(categorical_sample(p, s), 2)   # u == cp exactly
        self.assertEqual(categorical_sample(p, s), 3)

    def test_one_uniform_per_draw(self):
        s = UniformStream.from_list([0.1, 0.9])
        categorical_sample([0.5, 0.5], s)
        self.assertEqual(s.consumed, 1)


class TestCascadeExact(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.spectrum = _load_column(
            os.path.join(FIXTURES, "tier2_spectrum.csv"))
        cls.uniforms = _load_column(
            os.path.join(FIXTURES, "tier2_uniforms.csv"))
        cls.rows = []
        with open(os.path.join(FIXTURES, "tier2_products.csv")) as fh:
            next(fh)
            for line in fh:
                line = line.rstrip("\n")
                if not line:
                    continue
                chain, root, prods = line.split(",", 2)
                cls.rows.append((int(chain), float(root), prods))
        cls.meta = {}
        with open(os.path.join(FIXTURES, "tier2_meta.csv")) as fh:
            next(fh)
            for line in fh:
                if "," in line:
                    k, v = line.strip().split(",", 1)
                    cls.meta[k] = v

    def test_products_identical(self):
        self.assertGreaterEqual(len(self.rows), 10000,
                                "Tier 2 requires >= 10^4 chains")
        stream = UniformStream.from_list(self.uniforms)
        mismatches = []
        total_products = 0
        multiplicities = []
        for chain, root, expected in self.rows:
            got = decay_chain_general_quartic(
                root, self.spectrum, CONSTS, MODEL, stream)
            if expected == "STABLE":
                if got is not None:
                    mismatches.append((chain, "expected STABLE", got))
                continue
            want = [float(x) for x in expected.split()] if expected else []
            if got is None:
                mismatches.append((chain, want, "got STABLE"))
                continue
            if len(got) != len(want):
                mismatches.append((chain, "len {0}".format(len(want)),
                                   "len {0}".format(len(got))))
                continue
            for a, b in zip(got, want):
                if a != b:
                    mismatches.append((chain, b, a))
                    break
            total_products += len(got)
            multiplicities.append(len(got))
            if len(mismatches) > 5:
                break

        self.assertEqual(
            mismatches, [],
            "cascade diverged from the Julia; first few: {0}".format(
                mismatches[:5]))

        # the streams must have been consumed in lockstep
        self.assertEqual(
            stream.consumed, int(self.meta["uniforms_consumed"]),
            "uniform consumption differs: python={0} julia={1} -- the "
            "implementations took different numbers of stochastic "
            "decisions".format(stream.consumed, self.meta["uniforms_consumed"]))

        multiplicities.sort()
        n = len(multiplicities)
        print("\n  Tier 2: {0} chains identical element by element".format(n))
        print("          {0} product entries, {1} uniforms consumed "
              "in lockstep".format(total_products, stream.consumed))
        print("          multiplicity mean {0:.2f} median {1}".format(
            sum(multiplicities) / n, multiplicities[n // 2]))


if __name__ == "__main__":
    unittest.main(verbosity=2)
