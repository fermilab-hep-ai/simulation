"""
Four-vectors and sequential two-body decay kinematics.

The Julia model tracks masses only -- there are no four-vectors, no decay
angles and no boosts anywhere in it (instructions section 5.1).  Everything
here is new code, so it is checked against physics invariants rather than
against a reference implementation: four-momentum conservation at every node,
invariant mass reconstructing the parent, and isotropy in each parent rest
frame.

Randomness lives in a SEPARATE UniformStream from the cascade's.  Mixing them
would make the Tier 2 replay depend on how many angles were drawn, and the
whole point of Tier 2 is that the cascade's stream consumption is pinned.  With
two streams a sample can be re-showered with different angles but the identical
decay topology, which is also useful on its own.

Conventions: metric (+,-,-,-), energies and momenta in GeV, z along the beam.
"""

import math

from .cascade import iter_nodes


class FourVector(object):
    """A Lorentz vector (E; px, py, pz).  Immutable in practice; treat as such."""

    __slots__ = ("e", "px", "py", "pz")

    def __init__(self, e, px, py, pz):
        self.e = e
        self.px = px
        self.py = py
        self.pz = pz

    # -- construction -------------------------------------------------------

    @classmethod
    def from_mass_at_rest(cls, m):
        return cls(m, 0.0, 0.0, 0.0)

    @classmethod
    def from_pt_eta_phi_m(cls, pt, eta, phi, m):
        px = pt * math.cos(phi)
        py = pt * math.sin(phi)
        pz = pt * math.sinh(eta)
        e = math.sqrt(m * m + px * px + py * py + pz * pz)
        return cls(e, px, py, pz)

    @classmethod
    def from_pt_rapidity_phi_m(cls, pt, y, phi, m):
        """Rapidity, not pseudorapidity -- the right variable for a massive
        resonance whose longitudinal boost comes from the parton momenta."""
        mt = math.sqrt(m * m + pt * pt)
        return cls(mt * math.cosh(y),
                   pt * math.cos(phi), pt * math.sin(phi),
                   mt * math.sinh(y))

    # -- algebra ------------------------------------------------------------

    def __add__(self, other):
        return FourVector(self.e + other.e, self.px + other.px,
                          self.py + other.py, self.pz + other.pz)

    def __sub__(self, other):
        return FourVector(self.e - other.e, self.px - other.px,
                          self.py - other.py, self.pz - other.pz)

    def __repr__(self):
        return "FourVector(E={0:.6g}, px={1:.6g}, py={2:.6g}, pz={3:.6g})".format(
            self.e, self.px, self.py, self.pz)

    # -- observables --------------------------------------------------------

    @property
    def p2(self):
        return self.px ** 2 + self.py ** 2 + self.pz ** 2

    @property
    def p(self):
        return math.sqrt(self.p2)

    @property
    def m2(self):
        return self.e ** 2 - self.p2

    @property
    def mass(self):
        """Signed square root, so a tiny negative m2 from rounding is visible
        rather than silently clamped to zero."""
        m2 = self.m2
        return math.sqrt(m2) if m2 >= 0.0 else -math.sqrt(-m2)

    @property
    def pt(self):
        return math.sqrt(self.px ** 2 + self.py ** 2)

    @property
    def phi(self):
        return math.atan2(self.py, self.px)

    @property
    def eta(self):
        pt = self.pt
        if pt == 0.0:
            return math.inf if self.pz > 0 else -math.inf
        return math.asinh(self.pz / pt)

    @property
    def rapidity(self):
        num = self.e + self.pz
        den = self.e - self.pz
        if den <= 0.0 or num <= 0.0:
            return math.inf if self.pz > 0 else -math.inf
        return 0.5 * math.log(num / den)

    # -- boosts -------------------------------------------------------------

    def boost(self, bx, by, bz):
        """Boost by velocity (bx, by, bz), i.e. into the frame moving at -beta."""
        b2 = bx * bx + by * by + bz * bz
        if b2 <= 0.0:
            return FourVector(self.e, self.px, self.py, self.pz)
        if b2 >= 1.0:
            raise ValueError("boost velocity {0} not below c".format(math.sqrt(b2)))
        gamma = 1.0 / math.sqrt(1.0 - b2)
        bp = bx * self.px + by * self.py + bz * self.pz
        k = (gamma - 1.0) / b2
        return FourVector(gamma * (self.e + bp),
                          self.px + k * bp * bx + gamma * bx * self.e,
                          self.py + k * bp * by + gamma * by * self.e,
                          self.pz + k * bp * bz + gamma * bz * self.e)

    def boost_to_lab(self, parent):
        """Boost this rest-frame vector into the frame where ``parent`` has the
        four-momentum given."""
        if parent.e <= 0.0:
            raise ValueError("parent has non-positive energy")
        return self.boost(parent.px / parent.e, parent.py / parent.e,
                          parent.pz / parent.e)

    def boost_to_rest_of(self, parent):
        """Inverse of boost_to_lab: into ``parent``'s rest frame."""
        if parent.e <= 0.0:
            raise ValueError("parent has non-positive energy")
        return self.boost(-parent.px / parent.e, -parent.py / parent.e,
                          -parent.pz / parent.e)


def two_body_momentum(m, m1, m2):
    """
    Daughter momentum in the parent rest frame:

        |p| = sqrt((m^2 - (m1+m2)^2)(m^2 - (m1-m2)^2)) / (2m)

    Returns 0 rather than raising for a marginally closed decay, so rounding at
    threshold does not blow up a cascade that the branching ratios already
    declared open.
    """
    if m <= 0.0:
        raise ValueError("parent mass must be positive, got {0}".format(m))
    s = m1 + m2
    d = m1 - m2
    radicand = (m * m - s * s) * (m * m - d * d)
    if radicand <= 0.0:
        return 0.0
    return math.sqrt(radicand) / (2.0 * m)


def decay_two_body(parent_p4, m1, m2, stream):
    """
    Decay ``parent_p4`` isotropically into masses ``m1``, ``m2``.

    Two uniforms per decay: cos(theta) flat on [-1, 1] and phi flat on
    [0, 2pi).  Flat in cos(theta) is what isotropic means; flat in theta is the
    classic way to get this wrong.

    Returns the two daughter four-vectors in the lab frame.
    """
    m = parent_p4.mass
    pstar = two_body_momentum(m, m1, m2)

    cos_theta = 2.0 * stream.next() - 1.0
    sin_theta = math.sqrt(max(0.0, 1.0 - cos_theta * cos_theta))
    phi = 2.0 * math.pi * stream.next()

    px = pstar * sin_theta * math.cos(phi)
    py = pstar * sin_theta * math.sin(phi)
    pz = pstar * cos_theta
    e1 = math.sqrt(m1 * m1 + pstar * pstar)
    e2 = math.sqrt(m2 * m2 + pstar * pstar)

    d1 = FourVector(e1, px, py, pz)
    d2 = FourVector(e2, -px, -py, -pz)
    return d1.boost_to_lab(parent_p4), d2.boost_to_lab(parent_p4)


def assign_kinematics(root, root_p4, stream):
    """
    Walk the decay tree and give every node a four-vector.

    ``root_p4`` is the root scalar's lab-frame momentum, which comes from the
    production mode and is deliberately not this module's business -- see
    production_p4 below for the helpers.

    The walk is breadth-first, matching the cascade's own order, so a given
    kinematics stream always maps onto the same nodes for a given tree.

    Mutates the tree in place and returns it.
    """
    root.p4 = root_p4
    for node in iter_nodes(root):
        if not node.children:
            continue
        if len(node.children) != 2:
            raise ValueError(
                "node has {0} children; the cascade is strictly two-body".format(
                    len(node.children)))
        a, b = node.children
        # A daughter's four-vector is built from ITS OWN mass, so a node whose
        # mass came from the branching arrays stays on shell.
        a.p4, b.p4 = decay_two_body(node.p4, a.mass, b.mass, stream)
    return root


# ---------------------------------------------------------------------------
# Validation.  These are the assertions instructions section 9 asks for; they
# are cheap enough to run on a fraction of events in production.
# ---------------------------------------------------------------------------

def max_momentum_violation(root):
    """
    Largest |sum(daughters) - parent| over every decay in the tree, as an
    absolute energy-momentum residual in GeV.

    Returns 0.0 for a tree with no decays.
    """
    worst = 0.0
    for node in iter_nodes(root):
        if not node.children:
            continue
        total = node.children[0].p4
        for c in node.children[1:]:
            total = total + c.p4
        d = total - node.p4
        worst = max(worst, abs(d.e), abs(d.px), abs(d.py), abs(d.pz))
    return worst


def max_mass2_closure(root):
    """
    Largest |m_reconstructed^2 - m_assigned^2| / E^2 over the tree.

    This, not a relative test on m, is the well-conditioned way to ask whether a
    particle is on shell.  m^2 = E^2 - |p|^2 is a difference of two nearly equal
    numbers for anything ultra-relativistic, so it carries an absolute error of
    order eps*E^2 no matter how exact the boosts are.  Dividing by E^2 measures
    against that floor and gives a number that should sit at ~1e-15 for every
    species.

    Two ways to get a misleading answer instead:

      * relative to m^2: a strange quark at gamma ~ 2000 shows ~1e-9 and a
        photon shows infinity, both purely from the cancellation;
      * relative on m: the massless case reports sqrt of the residual, which
        inflates a 1e-12 error into 1e-6.

    Neither indicates a problem with the kinematics.  max_momentum_violation is
    the test that would actually catch a wrong boost.
    """
    worst = 0.0
    for node in iter_nodes(root):
        if node.p4 is None:
            continue
        e2 = node.p4.e ** 2
        if e2 <= 0.0:
            continue
        worst = max(worst, abs(node.p4.m2 - node.mass ** 2) / e2)
    return worst


def max_mass_violation(root, min_mass=0.0):
    """
    Largest relative deviation of a node's reconstructed mass from its assigned
    mass, over nodes with mass > ``min_mass``.

    Kept because it is the intuitive quantity, but read max_mass2_closure first:
    for an ultra-relativistic particle this is dominated by the E^2 - |p|^2
    cancellation and scales as eps*E^2/(2 m^2), not by anything the boosts did.
    Nodes at exactly zero mass are always skipped -- the quantity is undefined
    there.
    """
    worst = 0.0
    for node in iter_nodes(root):
        if node.p4 is None or node.mass <= min_mass or node.mass == 0.0:
            continue
        worst = max(worst, abs(node.p4.mass - node.mass) / node.mass)
    return worst


def visible_four_vector(root, invisible=()):
    """Sum over leaves, optionally skipping species treated as invisible."""
    total = FourVector(0.0, 0.0, 0.0, 0.0)
    for node in iter_nodes(root):
        if node.children:
            continue
        if node.species in invisible:
            continue
        total = total + node.p4
    return total


def scalar_ht(root, pt_min=0.0):
    """Scalar sum of leaf pT -- a crude proxy for the trigger-level HT, before
    any showering or jet clustering.  Useful as a sanity number, not as a
    trigger decision."""
    return sum(n.p4.pt for n in iter_nodes(root)
               if not n.children and n.p4.pt >= pt_min)
