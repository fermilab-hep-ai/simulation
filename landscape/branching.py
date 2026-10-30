"""
Branching-ratio assembly.  Port of BranchingRatiosgeneralquartic in
scalarattributesshare.jl.

THE ARRAY ORDERING IS LOAD-BearING.  The cascade samples an index from
Categorical(BR) and reads the daughter masses from masses1[k] / masses2[k], so
the three returned arrays must stay index-aligned and in exactly the Julia's
order.  An ordering difference is a silent correctness bug that comparing the
widths alone would not catch, which is why the Tier 1 test compares masses1 and
masses2 element by element as well.

Channel order as emitted by the Julia:

    0 .. n_pairs-1   hidden-sector pairs, i-major double loop over the allowed
                     masses (includes below-threshold pairs with zero width)
    then, each only if above its own threshold:
        b bbar, c cbar, tau tau, s sbar, mu mu,
        pi(m=0.134, isospin factor 2), pi(m=0.139, factor 1),
        e e, W W, Z Z, t tbar
    then always:
        gamma gamma   (masses1 = masses2 = m/2)
        g g           (masses1 = masses2 = m/2)

The m/2 sentinel for the last two entries is how the cascade recognises the
photon/gluon channels; see cascade.py.
"""

from .params import SMConstants, ModelParams
from . import widths as W


# Index of the photon channel counted from the end of the arrays; the gluon
# channel is the final entry.
PHOTON_FROM_END = 2
GLUON_FROM_END = 1


def allowed_daughter_masses(m, scalar_masses):
    """
    Julia: [x for x in scalarmasses if (x + minimum(scalarmasses)) < massscalar]

    Note this uses the minimum over ALL scalars, not over the allowed subset,
    and the pair loop below then emits every (i, j) combination -- including
    combinations whose total exceeds m, which get zero width from
    width_scalar_to_scalar_general_quartic.  Those zero entries stay in the
    arrays; removing them would shift every subsequent index.
    """
    m_min = min(scalar_masses)
    return [x for x in scalar_masses if (x + m_min) < m]


def branching_ratios_general_quartic(m, scalar_masses,
                                     consts: SMConstants, model: ModelParams):
    """
    Returns (branching_ratios, masses1, masses2) as parallel lists.

    Mirrors BranchingRatiosgeneralquartic exactly, including the order of the
    pushes.
    """
    decay_widths = []
    masses1 = []
    masses2 = []

    allowed = allowed_daughter_masses(m, scalar_masses)
    for mi in allowed:
        for mj in allowed:
            decay_widths.append(
                W.width_scalar_to_scalar_general_quartic(m, mi, mj, model))
            masses1.append(mi)
            masses2.append(mj)

    def add_fermion(threshold_mass, mass_value, coupling, colour):
        if m > 2.0 * threshold_mass:
            decay_widths.append(
                W.width_scalar_to_fermions(m, threshold_mass, coupling, colour,
                                           consts, model))
            masses1.append(mass_value)
            masses2.append(mass_value)

    add_fermion(consts.m_b, consts.m_b, consts.y_b, 3)
    add_fermion(consts.m_charm, consts.m_charm, consts.y_c, 3)
    add_fermion(consts.m_tau, consts.m_tau, consts.y_tau, 1)
    add_fermion(consts.m_strange, consts.m_strange, consts.y_s, 3)
    add_fermion(consts.m_muon, consts.m_muon, consts.y_muon, 1)

    # Pion channels.  The Julia tests against the bare literals 0.134 / 0.139
    # and pushes those literals as the daughter masses.  The 0.134 channel
    # carries the isospin factor 2.  See params.py on the inverted labelling.
    if m > 2.0 * consts.m_pi0:
        decay_widths.append(2.0 * W.width_to_pions(m, consts, model))
        masses1.append(consts.m_pi0)
        masses2.append(consts.m_pi0)
    if m > 2.0 * consts.m_pipm:
        decay_widths.append(W.width_to_pions(m, consts, model))
        masses1.append(consts.m_pipm)
        masses2.append(consts.m_pipm)

    add_fermion(consts.m_electron, consts.m_electron, consts.y_e, 1)

    if m > 2.0 * consts.m_W:
        decay_widths.append(W.width_scalar_to_WW(m, consts, model))
        masses1.append(consts.m_W)
        masses2.append(consts.m_W)
    if m > 2.0 * consts.m_Z:
        decay_widths.append(W.width_scalar_to_ZZ(m, consts, model))
        masses1.append(consts.m_Z)
        masses2.append(consts.m_Z)

    add_fermion(consts.m_top, consts.m_top, consts.y_t, 3)

    # Photons and gluons are always appended, with no threshold test.  The
    # gluon width is zero at or below 0.4 GeV, but the entry still occupies its
    # slot.  The m/2 daughter masses are the sentinel the cascade keys on.
    decay_widths.append(W.width_to_photons(m, consts, model))
    masses1.append(m / 2.0)
    masses2.append(m / 2.0)
    decay_widths.append(W.width_to_gluons(m, consts, model))
    masses1.append(m / 2.0)
    masses2.append(m / 2.0)

    denominator = sum(decay_widths)
    branching = [w / denominator for w in decay_widths]
    return branching, masses1, masses2


def branching_ratios_general_quartic_fast(m, scalar_masses, consts, model,
                                          _cache={}):
    """
    Vectorised equivalent of ``branching_ratios_general_quartic``.

    The pair block is O(N^2) per cascade node, which at the shipped N = 200 is
    ~35k width evaluations -- far too slow in pure Python for the 10^5-event
    Tier 3 comparison.  This computes the same quantities with numpy.

    Returns the same three arrays in the same order.  Measured agreement with
    the reference implementation is ~5e-15 relative over 1.6e5 channels -- close
    to but NOT bit-identical, so this must not be used for Tier 2, which
    requires exact equality.  Tiers 1 and 2 check the reference implementation;
    this path exists only to make the 10^5-event Tier 3 comparison tractable.
    """
    import numpy as np

    key = id(scalar_masses)
    arr = _cache.get(key)
    if arr is None or len(arr[0]) != len(scalar_masses):
        a = np.asarray(scalar_masses, dtype=np.float64)
        arr = (a, float(a.min()))
        _cache[key] = arr
    masses_arr, m_min = arr

    allowed = masses_arr[(masses_arr + m_min) < m]
    n = allowed.size
    if n:
        mi = np.repeat(allowed, n)     # i-major, matches the nested loop
        mj = np.tile(allowed, n)
        s = mi + mj
        d = mi - mj
        open_ = m > s
        with np.errstate(invalid="ignore"):
            radicand = (m ** 2 - s ** 2) * (m ** 2 - d ** 2)
            pair = ((1.0 / (16.0 * np.pi)) * model.M_star ** 2
                    * model.lam_prime ** 2 * (24.0 / (model.N ** 2))
                    * np.sqrt(np.where(open_, radicand, 0.0)) / (m ** 3))
        pair = np.where(open_, pair, 0.0)
        pair_list = pair.tolist()
        m1 = mi.tolist()
        m2 = mj.tolist()
    else:
        pair_list, m1, m2 = [], [], []

    tail_w, tail_m1, tail_m2 = _sm_channels(m, consts, model)
    widths = pair_list + tail_w
    masses1 = m1 + tail_m1
    masses2 = m2 + tail_m2
    denom = sum(widths)
    return [w / denom for w in widths], masses1, masses2


def _sm_channels(m, consts: SMConstants, model: ModelParams):
    """The SM tail of the channel list, shared by both implementations."""
    widths, masses1, masses2 = [], [], []

    def add(threshold, value, coupling, colour):
        if m > 2.0 * threshold:
            widths.append(W.width_scalar_to_fermions(
                m, threshold, coupling, colour, consts, model))
            masses1.append(value)
            masses2.append(value)

    add(consts.m_b, consts.m_b, consts.y_b, 3)
    add(consts.m_charm, consts.m_charm, consts.y_c, 3)
    add(consts.m_tau, consts.m_tau, consts.y_tau, 1)
    add(consts.m_strange, consts.m_strange, consts.y_s, 3)
    add(consts.m_muon, consts.m_muon, consts.y_muon, 1)
    if m > 2.0 * consts.m_pi0:
        widths.append(2.0 * W.width_to_pions(m, consts, model))
        masses1.append(consts.m_pi0)
        masses2.append(consts.m_pi0)
    if m > 2.0 * consts.m_pipm:
        widths.append(W.width_to_pions(m, consts, model))
        masses1.append(consts.m_pipm)
        masses2.append(consts.m_pipm)
    add(consts.m_electron, consts.m_electron, consts.y_e, 1)
    if m > 2.0 * consts.m_W:
        widths.append(W.width_scalar_to_WW(m, consts, model))
        masses1.append(consts.m_W)
        masses2.append(consts.m_W)
    if m > 2.0 * consts.m_Z:
        widths.append(W.width_scalar_to_ZZ(m, consts, model))
        masses1.append(consts.m_Z)
        masses2.append(consts.m_Z)
    add(consts.m_top, consts.m_top, consts.y_t, 3)
    widths.append(W.width_to_photons(m, consts, model))
    masses1.append(m / 2.0)
    masses2.append(m / 2.0)
    widths.append(W.width_to_gluons(m, consts, model))
    masses1.append(m / 2.0)
    masses2.append(m / 2.0)
    return widths, masses1, masses2


def total_width(m, scalar_masses, consts: SMConstants, model: ModelParams):
    """
    Sum of all partial widths, in GeV.  Not present in the Julia (which only
    ever needs the normalised ratios) but required for lifetimes.
    """
    decay_widths = []
    allowed = allowed_daughter_masses(m, scalar_masses)
    for mi in allowed:
        for mj in allowed:
            decay_widths.append(
                W.width_scalar_to_scalar_general_quartic(m, mi, mj, model))

    if m > 2.0 * consts.m_b:
        decay_widths.append(W.width_scalar_to_fermions(
            m, consts.m_b, consts.y_b, 3, consts, model))
    if m > 2.0 * consts.m_charm:
        decay_widths.append(W.width_scalar_to_fermions(
            m, consts.m_charm, consts.y_c, 3, consts, model))
    if m > 2.0 * consts.m_tau:
        decay_widths.append(W.width_scalar_to_fermions(
            m, consts.m_tau, consts.y_tau, 1, consts, model))
    if m > 2.0 * consts.m_strange:
        decay_widths.append(W.width_scalar_to_fermions(
            m, consts.m_strange, consts.y_s, 3, consts, model))
    if m > 2.0 * consts.m_muon:
        decay_widths.append(W.width_scalar_to_fermions(
            m, consts.m_muon, consts.y_muon, 1, consts, model))
    if m > 2.0 * consts.m_pi0:
        decay_widths.append(2.0 * W.width_to_pions(m, consts, model))
    if m > 2.0 * consts.m_pipm:
        decay_widths.append(W.width_to_pions(m, consts, model))
    if m > 2.0 * consts.m_electron:
        decay_widths.append(W.width_scalar_to_fermions(
            m, consts.m_electron, consts.y_e, 1, consts, model))
    if m > 2.0 * consts.m_W:
        decay_widths.append(W.width_scalar_to_WW(m, consts, model))
    if m > 2.0 * consts.m_Z:
        decay_widths.append(W.width_scalar_to_ZZ(m, consts, model))
    if m > 2.0 * consts.m_top:
        decay_widths.append(W.width_scalar_to_fermions(
            m, consts.m_top, consts.y_t, 3, consts, model))
    decay_widths.append(W.width_to_photons(m, consts, model))
    decay_widths.append(W.width_to_gluons(m, consts, model))
    return sum(decay_widths)


# hbar*c in GeV mm, for converting a width to a decay length.
HBARC_GEV_MM = 1.9732698e-13


def ctau_mm(m, scalar_masses, consts: SMConstants, model: ModelParams):
    """Proper decay length in mm for a scalar of mass m."""
    gamma = total_width(m, scalar_masses, consts, model)
    if gamma <= 0.0:
        return float("inf")
    return HBARC_GEV_MM / gamma
