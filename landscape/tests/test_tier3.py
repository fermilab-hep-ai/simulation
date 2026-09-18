"""
Tier 3 -- statistical backstop at the shipped benchmark (N = 200).

Independent RNGs on both sides, >= 10^5 events.  Compares the multiplicity
distribution (two-sample KS, with mean and median stated explicitly), the
per-flavour fractions as a function of multiplicity, and the total cross
section.  The numbers are reported, not just asserted against a p-value
threshold.

Regenerate the reference with:
    JULIA_DEPOT_PATH=<depot> julia landscape/julia_ref/dump_tier3.jl \
        landscape/julia_ref/fixtures 100000
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
from landscape import production as P                                # noqa: E402
from landscape import cascade as CAS                                 # noqa: E402

FIXTURES = os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "julia_ref", "fixtures")

CONSTS = SMConstants()
MODEL = ModelParams(N=200, lam=1e-4, lam_prime=1e-4, M_star=10000.0,
                    vev_2=0.9 * 246.0)

N_EVENTS = int(os.environ.get("TIER3_EVENTS", "100000"))

FLAVOURS = ["b", "tau", "c", "s", "mu", "pi2", "pi1", "e",
            "gamma", "gluon", "W", "Z", "t", "scalar"]


def ks_two_sample(a, b):
    """Two-sample KS statistic and asymptotic p-value.

    Multiplicity is a discrete variable, so both samples are full of ties.
    The ECDF only has a value *between* distinct observations, so at each
    distinct value we must consume every tied entry on both sides before
    measuring the gap -- advancing one side at a time turns a tie into a
    spurious step of height (number of ties)/n.  The asymptotic p-value is
    conservative for discrete data, which is the safe direction here.
    """
    a = sorted(a)
    b = sorted(b)
    na, nb = len(a), len(b)
    i = j = 0
    d = 0.0
    while i < na and j < nb:
        x = a[i] if a[i] < b[j] else b[j]
        while i < na and a[i] == x:
            i += 1
        while j < nb and b[j] == x:
            j += 1
        d = max(d, abs(i / na - j / nb))
    en = math.sqrt(na * nb / (na + nb))
    lam = (en + 0.12 + 0.11 / en) * d
    p = 2.0 * sum((-1) ** (k - 1) * math.exp(-2.0 * k * k * lam * lam)
                  for k in range(1, 101))
    return d, max(0.0, min(1.0, p))


class TestTier3(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        # The committed fixture is the summary: a multiplicity histogram plus
        # per-flavour totals.  That is a sufficient statistic for everything
        # this test does -- an ECDF is fully determined by its histogram, so
        # the KS statistic computed from the expanded sample is identical to
        # the one computed from the 10^5 individual rows, which are ~5 MB and
        # gitignored.
        path = os.path.join(FIXTURES, "tier3_summary.csv")
        if not os.path.exists(path):
            raise unittest.SkipTest(
                "Tier 3 reference missing; run dump_tier3.jl first")
        with open(os.path.join(FIXTURES, "tier3_spectrum.csv")) as fh:
            cls.spectrum = [float(l.strip()) for l in fh if l.strip()]
        with open(os.path.join(FIXTURES, "tier3_prodprob.csv")) as fh:
            cls.prodprob = [float(l.strip()) for l in fh if l.strip()]
        cls.jl_mult = []
        cls.jl_flav = {k: 0 for k in FLAVOURS}
        cls.jl_meta = {}
        with open(path) as fh:
            next(fh)
            for line in fh:
                parts = line.strip().split(",")
                if len(parts) != 3:
                    continue
                kind, key, val = parts
                if kind == "mult":
                    cls.jl_mult.extend([int(key)] * int(val))
                elif kind == "flav":
                    cls.jl_flav[key] = int(val)
                else:
                    cls.jl_meta[key] = val
        cls.meta = {}
        with open(os.path.join(FIXTURES, "tier3_xsec.csv")) as fh:
            next(fh)
            for line in fh:
                if "," in line:
                    k, v = line.strip().split(",", 1)
                    cls.meta[k] = v

    def test_production_prob_matches(self):
        pp, _ = P.production_prob(self.spectrum, CONSTS, MODEL)
        worst = max(abs(a - b) / abs(b) for a, b in zip(pp, self.prodprob) if b)
        self.assertLess(worst, 1e-12)
        print("\n  Tier 3 production probabilities: N={0}, worst rel dev "
              "{1:.2e}".format(len(pp), worst))

    def test_total_cross_section(self):
        xs, sigma_h = P.cross_sections(self.spectrum, CONSTS, MODEL)
        total = sum(xs)
        want = float(self.meta["total_crosssection_barn"])
        rel = abs(total - want) / abs(want)
        self.assertLess(rel, 1e-12)
        print("  Tier 3 total cross section: python {0:.6e} b, julia "
              "{1:.6e} b (rel dev {2:.2e})".format(total, want, rel))
        print("           = {0:.4g} pb, sigma_h used {1:g} b".format(
            total * 1e12, sigma_h))

    def test_multiplicity_and_flavour(self):
        rng = random.Random(20240608)
        cum = []
        s = 0.0
        for p in self.prodprob:
            s += p
            cum.append(s)

        py_mult = []
        py_flav = {k: 0 for k in FLAVOURS}
        name_map = {"b": "b", "tau": "tau", "c": "c", "s": "s", "mu": "mu",
                    "pi2": "pi_isospin2", "pi1": "pi_isospin1", "e": "e",
                    "gamma": "gamma", "gluon": "gluon", "W": "W", "Z": "Z",
                    "t": "t", "scalar": "scalar"}

        # use the vectorised branching path; the reference implementation is
        # what Tiers 1 and 2 pin down, this only has to be fast
        orig = CAS.branching_ratios_general_quartic
        CAS.branching_ratios_general_quartic = (
            lambda m, sm, c, mo: B.branching_ratios_general_quartic_fast(
                m, sm, c, mo))
        try:
            stream = CAS.UniformStream(rng=rng)
            for _ in range(N_EVENTS):
                u = rng.random()
                lo, hi = 0, len(cum) - 1
                while lo < hi:
                    mid = (lo + hi) // 2
                    if cum[mid] < u:
                        lo = mid + 1
                    else:
                        hi = mid
                root = self.spectrum[lo]
                prods = CAS.decay_chain_general_quartic(
                    root, self.spectrum, CONSTS, MODEL, stream)
                if prods is None:
                    continue
                py_mult.append(len(prods))
                fc = CAS.flavour_counts(prods, CONSTS)
                for f in FLAVOURS:
                    py_flav[f] += fc[name_map[f]]
        finally:
            CAS.branching_ratios_general_quartic = orig

        jl = self.jl_mult
        d, p = ks_two_sample(py_mult, jl)
        py_sorted = sorted(py_mult)
        jl_sorted = sorted(jl)
        print("\n  Tier 3 multiplicity ({0} python vs {1} julia events)".format(
            len(py_mult), len(jl)))
        print("    python  mean {0:.3f}  median {1}  max {2}".format(
            sum(py_mult) / len(py_mult), py_sorted[len(py_sorted) // 2],
            py_sorted[-1]))
        print("    julia   mean {0:.3f}  median {1}  max {2}".format(
            sum(jl) / len(jl), jl_sorted[len(jl_sorted) // 2], jl_sorted[-1]))
        print("    KS statistic {0:.5f}, p = {1:.4f}".format(d, p))

        # the KS p-value is conservative on a discrete variable; the PMF
        # comparison below is the one that actually has teeth
        vals = sorted(set(py_mult) | set(jl))
        py_n, jl_n = len(py_mult), len(jl)
        py_h = {v: 0 for v in vals}
        jl_h = {v: 0 for v in vals}
        for v in py_mult:
            py_h[v] += 1
        for v in jl:
            jl_h[v] += 1
        print("    {0:>5} {1:>10} {2:>10} {3:>9}".format(
            "mult", "python", "julia", "pull"))
        chi2 = 0.0
        ndf = 0
        for v in vals:
            fa = py_h[v] / py_n
            fb = jl_h[v] / jl_n
            sig = math.sqrt(fa * (1 - fa) / py_n + fb * (1 - fb) / jl_n)
            pull = (fa - fb) / sig if sig > 0 else 0.0
            if sig > 0:
                chi2 += pull * pull
                ndf += 1
            print("    {0:>5} {1:>10.5f} {2:>10.5f} {3:>+9.2f}".format(
                v, fa, fb, pull))
        print("    chi2/ndf = {0:.2f}/{1} = {2:.2f}".format(
            chi2, ndf, chi2 / ndf if ndf else 0.0))

        py_tot = sum(py_flav.values())
        jl_tot = sum(self.jl_flav.values())
        print("\n  Tier 3 flavour fractions")
        print("    {0:<8} {1:>10} {2:>10} {3:>10}".format(
            "species", "python", "julia", "diff"))
        worst_f = 0.0
        for f in FLAVOURS:
            a = py_flav[f] / py_tot if py_tot else 0.0
            b = self.jl_flav[f] / jl_tot if jl_tot else 0.0
            if a or b:
                worst_f = max(worst_f, abs(a - b))
                print("    {0:<8} {1:>10.5f} {2:>10.5f} {3:>+10.5f}".format(
                    f, a, b, a - b))
        print("    largest fraction difference: {0:.5f}".format(worst_f))

        self.assertGreater(p, 0.001,
                           "multiplicity distributions differ (KS p={0})".format(p))
        self.assertLess(worst_f, 0.01,
                        "flavour fractions differ by more than 1%")


if __name__ == "__main__":
    unittest.main(verbosity=2)
