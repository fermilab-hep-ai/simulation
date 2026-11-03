"""
Event generation: spectrum -> production -> cascade -> kinematics -> lifetimes
-> LHE.

Two production modes, matching the benchmark table in the spec:

* ``direct``  -- a single hidden scalar is produced by gluon fusion through its
  Higgs admixture, sampled from ProductionProb.  This is what the shipped
  driver parameters give, and it dominates the Higgs mode there by ~500.
* ``higgs``   -- gg -> h -> phi_i phi_j, with the pair sampled from
  ProductionProbjustHiggsDecaytwomasses.  The root of the tree is a real Higgs
  and the cascade runs from each daughter.

Everything stochastic goes through a named UniformStream, one per concern
(production, cascade, kinematics, lifetime), so a sample is reproducible from
its seeds and the cascade's stream stays exactly as Tier 2 pinned it.
"""

import math
import random

from .params import SMConstants, ModelParams
from . import production as P
from . import cascade as CAS
from . import kinematics as K
from . import lifetimes as LT
from . import lhe as LHE
from . import hardprocess as HP

HIGGS_PDG = 25


def draw_spectrum(model: ModelParams, seed):
    """
    One landscape realisation: N masses uniform on [10/sqrt(N), 10] GeV.

    Uniform in mass, not in m^2 -- matching the Julia (instructions section 6).
    Sorted for reproducibility; the order carries no meaning.
    """
    rng = random.Random(seed)
    low = 10.0 / math.sqrt(model.N)
    return sorted(rng.uniform(low, 10.0) for _ in range(model.N))


def _inverse_cdf(cum, u):
    lo, hi = 0, len(cum) - 1
    while lo < hi:
        mid = (lo + hi) // 2
        if cum[mid] < u:
            lo = mid + 1
        else:
            hi = mid
    return lo


def _cumulative(probs):
    cum = []
    s = 0.0
    for p in probs:
        s += p
        cum.append(s)
    return cum


def make_higgs_root(m_i, m_j, consts: SMConstants):
    """
    A Higgs node with two hidden-scalar children, for the h -> phi phi mode.

    The Higgs is given species 'higgs' so the lifetime code does not mistake it
    for a hidden scalar and hand it the width of a 125 GeV landscape scalar.
    It decays promptly, so its proper length is set to zero explicitly.
    """
    h = CAS.DecayNode(consts.m_h, species="higgs", pdg=HIGGS_PDG)
    h.tau_mm = 0.0
    h.children = [CAS.DecayNode(m_i), CAS.DecayNode(m_j)]
    return h


class Generator(object):
    """
    One benchmark's worth of settings, and the event loop.

    ``mode`` is 'direct' or 'higgs'.  ``luminosity`` is a
    hardprocess.GluonLuminosity (or the approximate stand-in), used to sample
    the rapidity of the 2 -> 1 system.
    """

    def __init__(self, model: ModelParams, consts: SMConstants = None,
                 spectrum_seed=424242, mode="direct", luminosity=None,
                 sqrt_s=14000.0, seed=1234, fast_branching=False,
                 include_bmeson=True):
        if model.spectrum_per_event:
            # Declared on ModelParams but not wired up.  Silently generating a
            # fixed-spectrum sample for someone who asked for the marginalised
            # one would be invisible in the output and wrong in exactly the way
            # deviation 7g is about, so refuse instead.
            raise NotImplementedError(
                "spectrum_per_event (the paper's marginalised mode) is not "
                "implemented; every sample uses one fixed realisation. See "
                "'Not yet implemented' in landscape/README.md.")
        self.model = model
        self.consts = consts or SMConstants()
        self.spectrum_seed = spectrum_seed
        self.spectrum = draw_spectrum(model, spectrum_seed)
        self.mode = mode
        self.sqrt_s = sqrt_s
        self.luminosity = luminosity or HP.GluonLuminosity(sqrt_s=sqrt_s)
        self.seed = seed
        # The reference branching implementation is the one Tiers 1 and 2 pin
        # down, and it is what runs by default.  At N = 200 its O(N^2) pair
        # block costs ~24 ms per cascade node, which is hours for a 10^5-event
        # sample; fast_branching swaps in the vectorised path (agreement ~5e-15,
        # not bit-identical) for production running.
        self.fast_branching = fast_branching
        # The Julia's B-meson production term is dimensionally inconsistent
        # with the other two and dominates the direct-mode normalisation by
        # ~3800; see production._weights.  Reproduced by default.
        self.include_bmeson = include_bmeson

        # one stream per concern, each with its own seed
        self.prod_stream = CAS.UniformStream(rng=random.Random(seed))
        self.cascade_stream = CAS.UniformStream(rng=random.Random(seed + 1))
        self.kin_stream = CAS.UniformStream(rng=random.Random(seed + 2))
        self.life_stream = CAS.UniformStream(rng=random.Random(seed + 3))
        self._ctau_cache = {}

        if mode == "direct":
            probs, _ = P.production_prob(self.spectrum, self.consts, model,
                                         include_bmeson=include_bmeson)
            self._cum = _cumulative(probs)
        elif mode == "higgs":
            probs, m1, m2, br_sum, _ = P.production_prob_higgs_pairs(
                self.spectrum, self.consts, model)
            self._cum = _cumulative(probs)
            self._pair_m1 = m1
            self._pair_m2 = m2
            self.br_h_to_bsm = br_sum
        else:
            raise ValueError("mode must be 'direct' or 'higgs', got "
                             + repr(mode))

    # -- normalisation ------------------------------------------------------

    def cross_section_pb(self):
        """Total cross section in pb for this benchmark's production mode."""
        if self.mode == "direct":
            xs, _ = P.cross_sections(self.spectrum, self.consts, self.model,
                                     include_bmeson=self.include_bmeson)
            return sum(xs) * 1e12          # barns -> pb
        xs, _ = P.cross_sections_higgs_only(self.spectrum, self.consts,
                                            self.model)
        return sum(xs) * 1e12

    def cross_section_breakdown_pb(self):
        """(higgs, direct, bmeson) contributions in pb, for the LHE header."""
        h, d, b = P.production_breakdown(
            self.spectrum, self.consts, self.model, P.SIGMA_H_CROSSSECTIONS,
            include_bmeson=self.include_bmeson)
        return h * 1e12, d * 1e12, b * 1e12

    def higgs_constraint(self):
        return P.check_higgs_constraint(self.spectrum, self.consts, self.model)

    # -- one event ----------------------------------------------------------

    def _branching_context(self):
        """Swap in the vectorised branching path for the duration of a call."""
        from . import branching as B

        class _Ctx(object):
            def __init__(self, on):
                self.on = on
                self.orig = None

            def __enter__(self):
                if self.on:
                    self.orig = CAS.branching_ratios_general_quartic
                    CAS.branching_ratios_general_quartic = (
                        B.branching_ratios_general_quartic_fast)
                return self

            def __exit__(self, *a):
                if self.on:
                    CAS.branching_ratios_general_quartic = self.orig
                return False

        return _Ctx(self.fast_branching)

    def _cascade_from(self, node):
        """Run the cascade in place from an existing scalar node."""
        sub, _ = CAS.decay_tree_general_quartic(
            node.mass, self.spectrum, self.consts, self.model,
            self.cascade_stream)
        if sub is None:
            return False
        node.children = sub.children
        return True

    def event_tree(self):
        """
        Build one fully decorated decay tree, or None if the draw gave a stable
        scalar with nothing to decay to.
        """
        with self._branching_context():
            return self._event_tree_inner()

    def _event_tree_inner(self):
        u = self.prod_stream.next()
        k = _inverse_cdf(self._cum, u)

        if self.mode == "direct":
            m_root = self.spectrum[k]
            root, _ = CAS.decay_tree_general_quartic(
                m_root, self.spectrum, self.consts, self.model,
                self.cascade_stream)
            if root is None:
                return None
            hard_mass = m_root
        else:
            root = make_higgs_root(self._pair_m1[k], self._pair_m2[k],
                                   self.consts)
            for child in root.children:
                if not self._cascade_from(child):
                    return None
            hard_mass = self.consts.m_h

        y = self.luminosity.sample_rapidity(hard_mass,
                                            self.prod_stream.next())
        x1, x2, g1, g2 = HP.initial_state(hard_mass, y, self.sqrt_s)

        K.assign_kinematics(root, g1 + g2, self.kin_stream)
        LT.assign_proper_times(root, self.spectrum, self.consts, self.model,
                               self.life_stream, cache=self._ctau_cache)
        LT.assign_vertices(root)
        return root, g1, g2

    def events(self, n):
        """Yield ``n`` LHE particle lists.  Stable-scalar draws are retried."""
        made = 0
        attempts = 0
        limit = 100 * n + 1000
        while made < n:
            attempts += 1
            if attempts > limit:
                raise RuntimeError(
                    "only {0} of {1} events produced in {2} attempts".format(
                        made, n, attempts))
            got = self.event_tree()
            if got is None:
                continue
            root, g1, g2 = got
            yield LHE.build_event(root, g1, g2)
            made += 1
