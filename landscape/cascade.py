"""
The decay cascade.  Port of DecayChaingeneralquartic in
scalarattributesshare.jl.

The randomness is injectable: every stochastic step draws from a
``UniformStream``, so the Julia and the Python can be driven by an identical
pre-generated stream and their outputs compared element by element (Tier 2).

Two behaviours of the original are worth stating explicitly, because both look
like bugs and neither is:

* ``massesavailable`` is built inside the loop and then only used for a
  ``length == 0`` test.  Since the code unconditionally pushes ``m/2`` twice at
  the end of building it, the list is never empty and that branch is dead.  It
  is reproduced (as a comment) but not executed.
* The photon/gluon channel is identified by the daughter mass being exactly
  ``parent/2``, which is the sentinel BranchingRatiosgeneralquartic writes for
  those two entries.  A hidden scalar of mass exactly ``parent/2`` would be
  misclassified; with a continuous spectrum that has probability zero.
"""

import math

from .params import SMConstants, ModelParams
from .branching import branching_ratios_general_quartic

# The integer codes the original pushes into Products in place of a mass.
PHOTON_CODE = 1
GLUON_CODE = 2


class UniformStream:
    """
    A source of uniforms on [0, 1).

    ``from_list`` replays a pre-generated stream, which is what Tier 2 uses to
    make the comparison with the Julia exact rather than statistical.
    """

    def __init__(self, rng=None, values=None):
        self._rng = rng
        self._values = values
        self._i = 0

    @classmethod
    def from_list(cls, values):
        return cls(values=list(values))

    def next(self):
        if self._values is not None:
            if self._i >= len(self._values):
                raise IndexError(
                    "uniform stream exhausted after {0} draws".format(self._i))
            v = self._values[self._i]
            self._i += 1
            return v
        return self._rng.random()

    @property
    def consumed(self):
        return self._i


def categorical_sample(probs, stream: UniformStream):
    """
    One-based inverse-CDF draw, matching Julia's ``rand(Categorical(p))``.

    Verified empirically against Distributions.jl v0.25 on 20000 draws: the
    Julia consumes exactly one uniform per draw and walks the cumulative sum
    from the left.  The ``u <= cp`` and ``while cp < u`` conventions differ only
    on exact ties, which have measure zero for a continuous uniform.
    """
    u = stream.next()
    cp = 0.0
    for i, p in enumerate(probs):
        cp += p
        if u <= cp:
            return i + 1
    return len(probs)


def _terminal_masses(consts: SMConstants):
    """
    The masses the original treats as final-state SM particles.

    Julia tests ``massproduct == m_b || ... || m_u || m_d || ...`` where m_u and
    m_d hold the pion masses.  Exact float equality is safe here because
    BranchingRatiosgeneralquartic pushes these very constants.
    """
    return (consts.m_b, consts.m_charm, consts.m_tau, consts.m_strange,
            consts.m_muon, consts.m_pi0, consts.m_pipm, consts.m_electron,
            consts.m_W, consts.m_Z, consts.m_top)


def _photon_gluon_probs(br, model: ModelParams):
    """
    Conditional split between the photon and gluon channels.

    DEVIATION (instructions 7a).  The original computes, with l = len(BR):

        if BR[l-1] > BR[l]:  p_gamma = 1 - BR[l]/BR[l-1]; p_g = BR[l]/BR[l-1]
        else:                p_gamma = BR[l-1]/BR[l];     p_g = 1 - BR[l-1]/BR[l]

    (Julia is 1-based, so BR[l-1] is the photon entry and BR[l] the gluon.)
    The standard conditional split would be BR_gamma/(BR_gamma + BR_g).  These
    differ: for (0.6, 0.3) the code gives p_gamma = 0.50 against 0.67.
    Multiplicity is unaffected but the GLUON FRACTION changes, and gluons mean
    jets while photons mean EM deposits -- first order for a PUPPI signature.
    """
    br_gamma = br[-2]
    br_gluon = br[-1]
    if model.photon_gluon_split == "standard":
        denom = br_gamma + br_gluon
        if denom == 0.0:
            return 1.0, 0.0
        return br_gamma / denom, br_gluon / denom
    # the code's version
    if br_gamma > br_gluon:
        return 1.0 - br_gluon / br_gamma, br_gluon / br_gamma
    return br_gamma / br_gluon, 1.0 - br_gamma / br_gluon


def decay_chain_general_quartic(m, scalar_masses, consts: SMConstants,
                                model: ModelParams, stream: UniformStream,
                                max_nodes=200000):
    """
    Run one cascade from a scalar of mass ``m``.

    Returns a flat list whose entries are SM particle MASSES, except for the
    photon and gluon channels which contribute the integer codes 1 and 2 (twice
    each), exactly as the original does.  Any scalars left undecayed when the
    loop exits are appended as their masses.

    Returns ``None`` for the Julia's "stable scalar" case.
    """
    m_min = min(scalar_masses)
    if 2.0 * m_min > m and 2.0 * consts.m_electron > m:
        return None

    terminal = _terminal_masses(consts)
    edukts = [m]
    products = []
    nodes = 0

    while edukts and (max(edukts) > 2.0 * m_min
                      or max(edukts) > 2.0 * consts.m_electron):
        next_edukts = []
        for parent in edukts:
            nodes += 1
            if nodes > max_nodes:
                raise RuntimeError(
                    "cascade exceeded {0} nodes; runaway chain".format(max_nodes))

            # NOTE: the original builds `massesavailable` here and tests it for
            # emptiness, but always pushes parent/2 twice while building it, so
            # the test can never fire.  Dead code, not reproduced.
            br, mass1, mass2 = branching_ratios_general_quartic(
                parent, scalar_masses, consts, model)

            index = categorical_sample(br, stream)      # 1-based
            mp = mass1[index - 1]
            mp2 = mass2[index - 1]

            if mp in terminal:
                products.append(mp)
                products.append(mp2)
            elif mp == parent / 2.0:
                p_gamma, p_gluon = _photon_gluon_probs(br, model)
                sample = categorical_sample([p_gamma, p_gluon], stream)
                # the original pushes the integer code twice
                products.append(sample)
                products.append(sample)
            else:
                next_edukts.append(mp)
                next_edukts.append(mp2)
        edukts = next_edukts

    products.extend(edukts)
    return products


# ---------------------------------------------------------------------------
# Tree-valued cascade
#
# decay_chain_general_quartic above returns the flat list the Julia returns,
# which is all the paper's plots need.  Kinematics needs the TREE: to boost a
# daughter you need its parent, and the flat list has thrown that away.
#
# decay_tree_general_quartic below walks the identical loop, draws from the
# stream in the identical order, and additionally records the parent/child
# structure.  test_tier5 asserts the two agree on both the flat product list and
# the number of uniforms consumed, so the tree version stays pinned to the
# behaviour Tiers 1-3 verified.
# ---------------------------------------------------------------------------

# PDG codes for the terminal channels.  The pair is (particle, antiparticle);
# for self-conjugate channels both entries are the same code.
#
# NOTE on the pions (instructions 7e).  The channel carrying the isospin factor
# 2 is physically pi+ pi-, but the Julia gives it the value 0.134, which is the
# pi0 mass; the factor-1 channel labelled pi0 pi0 gets 0.139, the pi+- mass.
# The isospin factors are right, so the LABELS below follow the isospin factor
# (the physics) while the MASSES stay as the Julia has them (the numbers).
# Emitting these as the wrong charge state would be a real error -- pi+- are
# tracks, pi0 -> gamma gamma is an EM deposit -- so the labelling is resolved
# here rather than left to the mass value.
PDG = {
    "b": (5, -5),
    "c": (4, -4),
    "tau": (15, -15),
    "s": (3, -3),
    "mu": (13, -13),
    "e": (11, -11),
    "t": (6, -6),
    "W": (24, -24),
    "Z": (23, 23),
    "pi_isospin2": (211, -211),    # pi+ pi-, model mass 0.134
    "pi_isospin1": (111, 111),     # pi0 pi0, model mass 0.139
    "gamma": (22, 22),
    "gluon": (21, 21),
}

# Which terminal channels are coloured, i.e. need colour lines in an LHE.
COLOURED = {"b", "c", "s", "t", "gluon"}


def species_table(consts: SMConstants):
    """Map the daughter mass the cascade emits to the channel name."""
    return {
        consts.m_b: "b",
        consts.m_charm: "c",
        consts.m_tau: "tau",
        consts.m_strange: "s",
        consts.m_muon: "mu",
        consts.m_pi0: "pi_isospin2",
        consts.m_pipm: "pi_isospin1",
        consts.m_electron: "e",
        consts.m_W: "W",
        consts.m_Z: "Z",
        consts.m_top: "t",
    }


class DecayNode(object):
    """
    One particle in the cascade.

    ``species`` is None for a hidden scalar and the channel name for a terminal
    SM particle.  ``pdg`` is None for hidden scalars (they have no PDG code
    until an LHE assigns one).  ``p4`` is filled in by kinematics.py; it is None
    on a freshly generated tree.
    """

    # ctau_mm / tau_mm are filled in by lifetimes.py, vertex_mm by
    # lifetimes.assign_vertices; all stay None on a freshly generated tree.
    __slots__ = ("mass", "species", "pdg", "children", "p4",
                 "ctau_mm", "tau_mm", "vertex_mm")

    def __init__(self, mass, species=None, pdg=None):
        self.mass = mass
        self.species = species
        self.pdg = pdg
        self.children = []
        self.p4 = None
        self.ctau_mm = None
        self.tau_mm = None
        self.vertex_mm = None

    @property
    def is_scalar(self):
        return self.species is None

    @property
    def is_leaf(self):
        return not self.children

    def __repr__(self):
        what = self.species or "phi"
        return "<DecayNode {0} m={1:.4g} nchild={2}>".format(
            what, self.mass, len(self.children))


def iter_nodes(root):
    """Breadth-first walk, the order the cascade itself uses."""
    level = [root]
    while level:
        nxt = []
        for n in level:
            yield n
            nxt.extend(n.children)
        level = nxt


def leaves(root):
    """Terminal particles, in breadth-first order."""
    return [n for n in iter_nodes(root) if n.is_leaf]


def decay_tree_general_quartic(m, scalar_masses, consts: SMConstants,
                               model: ModelParams, stream: UniformStream,
                               max_nodes=200000):
    """
    As decay_chain_general_quartic, but returns ``(root, products)`` where
    ``root`` is a DecayNode tree and ``products`` is the identical flat list the
    original returns.

    Returns ``(None, None)`` for the stable-scalar case.
    """
    m_min = min(scalar_masses)
    if 2.0 * m_min > m and 2.0 * consts.m_electron > m:
        return None, None

    species_of = species_table(consts)
    root = DecayNode(m)
    edukts = [root]
    products = []
    nodes = 0

    while edukts and (max(n.mass for n in edukts) > 2.0 * m_min
                      or max(n.mass for n in edukts) > 2.0 * consts.m_electron):
        next_edukts = []
        for parent in edukts:
            nodes += 1
            if nodes > max_nodes:
                raise RuntimeError(
                    "cascade exceeded {0} nodes; runaway chain".format(max_nodes))

            br, mass1, mass2 = branching_ratios_general_quartic(
                parent.mass, scalar_masses, consts, model)

            index = categorical_sample(br, stream)      # 1-based
            mp = mass1[index - 1]
            mp2 = mass2[index - 1]

            name = species_of.get(mp)
            if name is not None:
                pdg, anti = PDG[name]
                parent.children = [DecayNode(mp, name, pdg),
                                   DecayNode(mp2, name, anti)]
                products.append(mp)
                products.append(mp2)
            elif mp == parent.mass / 2.0:
                p_gamma, p_gluon = _photon_gluon_probs(br, model)
                sample = categorical_sample([p_gamma, p_gluon], stream)
                name = "gamma" if sample == PHOTON_CODE else "gluon"
                pdg, anti = PDG[name]
                # massless daughters; the m/2 in the branching arrays is a
                # sentinel for the channel, not a physical daughter mass
                parent.children = [DecayNode(0.0, name, pdg),
                                   DecayNode(0.0, name, anti)]
                products.append(sample)
                products.append(sample)
            else:
                a = DecayNode(mp)
                b = DecayNode(mp2)
                parent.children = [a, b]
                next_edukts.append(a)
                next_edukts.append(b)
        edukts = next_edukts

    products.extend(n.mass for n in edukts)
    return root, products


def multiplicity(products):
    """Number of parton/lepton-level entries, i.e. what the paper plots."""
    return 0 if products is None else len(products)


def flavour_counts(products, consts: SMConstants):
    """
    Count entries by species, using the same keys as the driver's histogram.

    The photon and gluon entries are integers rather than masses, so they are
    matched on the integer codes.  Anything not recognised (an undecayed
    scalar appended at the end of the chain) is bucketed as 'scalar'.
    """
    keys = [
        ("b", consts.m_b), ("tau", consts.m_tau), ("c", consts.m_charm),
        ("s", consts.m_strange), ("mu", consts.m_muon),
        ("pi_isospin2", consts.m_pi0), ("pi_isospin1", consts.m_pipm),
        ("e", consts.m_electron), ("W", consts.m_W), ("Z", consts.m_Z),
        ("t", consts.m_top),
    ]
    out = {k: 0 for k, _ in keys}
    out["gamma"] = 0
    out["gluon"] = 0
    out["scalar"] = 0
    if not products:
        return out
    for p in products:
        if p == PHOTON_CODE:
            out["gamma"] += 1
            continue
        if p == GLUON_CODE:
            out["gluon"] += 1
            continue
        for name, val in keys:
            if p == val:
                out[name] += 1
                break
        else:
            out["scalar"] += 1
    return out
