"""
The hard process: where the cascade root's four-momentum comes from.

The model code has no production kinematics at all -- it gives a per-scalar
production probability and a cross section, and nothing else.  This module
turns that into an initial state that can be written to an LHE file.

The process is 2 -> 1: two gluons fuse into the root (a hidden scalar for
direct production, the Higgs for the h -> phi phi benchmarks).  At that order
the root has **zero transverse momentum** and its longitudinal boost is fixed
entirely by the incoming parton momentum fractions,

    x1 x2 s = m^2,        y = (1/2) ln(x1/x2).

That is not an approximation we are choosing to make -- it is the correct LHE
convention for a 2 -> 1 process.  The resonance's real pT comes from initial
state radiation, and Pythia generates it when it showers the event.  Writing a
hand-rolled pT spectrum into the LHE instead would double count.

So the only thing to sample is the rapidity, with weight given by the gluon
luminosity at fixed tau = m^2/s:

    dsigma/dy  ~  g(x1, Q) g(x2, Q),      x1,2 = sqrt(tau) e^(+-y)

There is no silent fallback here.  GluonLuminosity needs LHAPDF (present in the
container, absent on a bare lxplus login node); ApproximateGluonLuminosity is a
crude analytic stand-in that must be constructed deliberately and that the LHE
writer records in the file header, so a sample can never quietly be produced
with the wrong one.
"""

import math

from .kinematics import FourVector


class GluonLuminosity(object):
    """
    Rapidity sampler for a 2 -> 1 gluon-fusion system, using a real PDF.

    Requires the ``lhapdf`` Python module.  The per-mass rapidity CDF is built
    once on a grid and cached, which matters because a direct-production sample
    cycles through the same N scalar masses for every event.
    """

    def __init__(self, pdf_name="NNPDF23_lo_as_0130_qed", member=0,
                 sqrt_s=14000.0, n_grid=400):
        import lhapdf                      # noqa: F401  (deliberately lazy)
        self.pdf = lhapdf.mkPDF(pdf_name, member)
        self.pdf_name = pdf_name
        self.member = member
        self.sqrt_s = sqrt_s
        self.n_grid = n_grid
        self.q_min = math.sqrt(self.pdf.q2Min)
        self.x_min = self.pdf.xMin
        self._cache = {}

    def describe(self):
        return "{0}/{1} (LHAPDF), sqrt(s) = {2:g} GeV".format(
            self.pdf_name, self.member, self.sqrt_s)

    def _xg(self, x, q):
        """x*g(x, Q), clipped to the set's support."""
        if x <= self.x_min or x >= 1.0:
            return 0.0
        return self.pdf.xfxQ(21, x, q)

    def weight(self, m, y):
        """dsigma/dy up to a constant, at fixed tau.

        g = xg/x and x1 x2 = tau is constant, so the 1/(x1 x2) drops out of the
        normalisation and the product of the two xg values is enough.
        """
        tau = (m / self.sqrt_s) ** 2
        r = math.sqrt(tau)
        x1 = r * math.exp(y)
        x2 = r * math.exp(-y)
        if x1 >= 1.0 or x2 >= 1.0:
            return 0.0
        q = max(m, self.q_min)
        return self._xg(x1, q) * self._xg(x2, q)

    def _cdf(self, m):
        key = round(m, 9)
        hit = self._cache.get(key)
        if hit is not None:
            return hit
        tau = (m / self.sqrt_s) ** 2
        if tau >= 1.0:
            raise ValueError(
                "mass {0} exceeds the collider energy {1}".format(m, self.sqrt_s))
        y_max = -0.5 * math.log(tau)
        n = self.n_grid
        ys = [-y_max + 2.0 * y_max * k / (n - 1) for k in range(n)]
        ws = [self.weight(m, y) for y in ys]
        # trapezoid running integral
        cdf = [0.0]
        for k in range(1, n):
            cdf.append(cdf[-1] + 0.5 * (ws[k] + ws[k - 1]) * (ys[k] - ys[k - 1]))
        total = cdf[-1]
        if total <= 0.0:
            raise ValueError(
                "gluon luminosity vanished for m = {0}; check the PDF support"
                .format(m))
        cdf = [c / total for c in cdf]
        self._cache[key] = (ys, cdf)
        return ys, cdf

    def sample_rapidity(self, m, u):
        """Inverse-CDF draw from a single uniform."""
        ys, cdf = self._cdf(m)
        lo, hi = 0, len(cdf) - 1
        while lo < hi:
            mid = (lo + hi) // 2
            if cdf[mid] < u:
                lo = mid + 1
            else:
                hi = mid
        if lo == 0:
            return ys[0]
        c0, c1 = cdf[lo - 1], cdf[lo]
        if c1 == c0:
            return ys[lo]
        f = (u - c0) / (c1 - c0)
        return ys[lo - 1] + f * (ys[lo] - ys[lo - 1])


class ApproximateGluonLuminosity(GluonLuminosity):
    """
    LHAPDF-free stand-in using x g(x) = x^(-0.2) (1 - x)^5.

    This is a rough LO gluon shape, good enough for unit tests and for checking
    the plumbing on a machine without LHAPDF.  It is NOT good enough for a
    physics sample: the rapidity distribution it gives is only qualitatively
    right, which shows up directly as the eta acceptance of the final state.
    The LHE writer stamps describe() into the file header so a sample made with
    this can always be identified after the fact.
    """

    def __init__(self, sqrt_s=14000.0, n_grid=400):
        self.pdf = None
        self.pdf_name = "approximate-analytic"
        self.member = 0
        self.sqrt_s = sqrt_s
        self.n_grid = n_grid
        self.q_min = 1.0
        self.x_min = 1e-9
        self._cache = {}

    def describe(self):
        return ("APPROXIMATE analytic gluon x^-0.2 (1-x)^5, NOT LHAPDF, "
                "sqrt(s) = {0:g} GeV".format(self.sqrt_s))

    def _xg(self, x, q):
        if x <= self.x_min or x >= 1.0:
            return 0.0
        return x ** (-0.2) * (1.0 - x) ** 5


def initial_state(m, y, sqrt_s=14000.0):
    """
    The two incoming gluons for a 2 -> 1 system of mass ``m`` at rapidity ``y``.

    Returns (x1, x2, p_g1, p_g2).  The gluons are massless and exactly
    collinear with the beams, so their sum has pT = 0 and invariant mass m by
    construction.
    """
    tau = (m / sqrt_s) ** 2
    r = math.sqrt(tau)
    x1 = r * math.exp(y)
    x2 = r * math.exp(-y)
    if x1 >= 1.0 or x2 >= 1.0:
        raise ValueError("rapidity {0} is outside the kinematic limit for "
                         "m = {1}".format(y, m))
    e_beam = 0.5 * sqrt_s
    g1 = FourVector(x1 * e_beam, 0.0, 0.0, x1 * e_beam)
    g2 = FourVector(x2 * e_beam, 0.0, 0.0, -x2 * e_beam)
    return x1, x2, g1, g2


def root_momentum(m, y, sqrt_s=14000.0):
    """The 2 -> 1 system's four-momentum: pT = 0, rapidity y, mass m."""
    return FourVector.from_pt_rapidity_phi_m(0.0, y, 0.0, m)
