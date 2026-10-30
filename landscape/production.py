"""
Production cross sections and per-scalar production probabilities.

Port of ScalarProductionshare.jl.

Two Higgs cross sections appear in the original and are kept distinct:
ProductionProb uses 21.39e-12 barns, while Crosssections,
ProductionProbjustHiggsDecaytwomasses and CrosssectionsjustHiggsDecay use
48.51e-12.  Each entry point logs which one it used via the returned
``sigma_h_used`` so the discrepancy cannot pass unnoticed.
(instructions section 7c)
"""

import math

from .params import (SMConstants, ModelParams, SIGMA_H_PRODUCTIONPROB,
                     SIGMA_H_CROSSSECTIONS, C_DIRECT, DIRECT_XSEC_X,
                     DIRECT_XSEC_Y, M_BMESON, M_KAON, BMESON_SUPPRESSION)


def _interp_linear_extrap(x, xs, ys):
    """
    Linear interpolation on a gridded table with LINEAR extrapolation outside
    it, matching Julia's

        extrapolate(interpolate((x,), y, Gridded(Linear())), Line())

    numpy.interp would clamp to the end values instead of extrapolating, which
    would silently change sigma_s below 5.05 GeV -- precisely the region the
    shipped spectrum [0.707, 10] GeV lives in.
    """
    n = len(xs)
    if x <= xs[0]:
        slope = (ys[1] - ys[0]) / (xs[1] - xs[0])
        return ys[0] + slope * (x - xs[0])
    if x >= xs[n - 1]:
        slope = (ys[n - 1] - ys[n - 2]) / (xs[n - 1] - xs[n - 2])
        return ys[n - 1] + slope * (x - xs[n - 1])
    lo, hi = 0, n - 1
    while hi - lo > 1:
        mid = (lo + hi) // 2
        if xs[mid] <= x:
            lo = mid
        else:
            hi = mid
    t = (x - xs[lo]) / (xs[hi] - xs[lo])
    return ys[lo] + t * (ys[hi] - ys[lo])


def gamma_bb(consts: SMConstants):
    """
    Assumed h -> b bbar width, used as the normalisation for BR(h -> BSM).

    DEVIATION (instructions 7d): built from the POLE mass m_b = 4.18 rather
    than the running mass at m_h (~2.8), and multiplied by 1.89 downstream to
    stand in for the total Higgs width.  That gives an assumed total of
    8.13e-3 GeV against the true SM 4.1e-3, so BR(h -> BSM) comes out low by
    roughly 2x and the Higgs-mode rate is conservative.  Reproduced as written.

    Also note this uses G_F = 1.166e-5 while DecaytoPhotons uses 1.1664e-5.
    """
    return ((3.0 * consts.m_h * consts.m_b ** 2 * consts.G_F_gammabb)
            / (4.0 * math.pi * math.sqrt(2.0)))


def _h_to_pair_width(mi, mj, consts: SMConstants, model: ModelParams):
    """h -> phi_i phi_j partial width; zero above threshold."""
    if consts.m_h <= (mi + mj):
        return 0.0
    return (2.0 * (model.lam ** 2 * model.vev_2 ** 2)
            * math.sqrt((consts.m_h ** 2 - (mi + mj) ** 2)
                        * (consts.m_h ** 2 - (mi - mj) ** 2))
            / (model.N ** 2 * 4.0 * math.pi * consts.m_h ** 3))


def _sigma_direct(m, consts: SMConstants, model: ModelParams):
    """Direct (non-Higgs) production cross section in barns, before theta^2."""
    if m > 18.1:
        return C_DIRECT / (m ** 2)
    return _interp_linear_extrap(m, DIRECT_XSEC_X, DIRECT_XSEC_Y) * 1e-9


def _bmeson_term(m, consts: SMConstants, model: ModelParams):
    """B-meson production term; zero at or above 4.7 GeV."""
    if m >= 4.7:
        return 0.0
    mixing = model.mixing(consts, m)
    pms = (math.sqrt((M_BMESON ** 2 - (m + M_KAON) ** 2)
                     * (M_BMESON ** 2 - (m - M_KAON) ** 2)) / (2.0 * M_BMESON))
    F = 0.33 / (1.0 - (m ** 2 / 38.0))
    return mixing ** 2 * 0.5 * 2.0 * pms * F / M_BMESON


def production_breakdown(scalar_masses, consts, model, sigma_h,
                         include_bmeson=True):
    """
    The three production terms, summed over the spectrum, in barns.

    Returns (higgs, direct, bmeson).  Exposed separately because the three are
    not on the same footing -- see the note on the B-meson term below.
    """
    h = d = b = 0.0
    for mi in scalar_masses:
        summed = 0.0
        for mj in scalar_masses:
            summed += _h_to_pair_width(mi, mj, consts, model) / (gamma_bb(consts) * 1.89)
        mixing = model.mixing(consts, mi)
        h += sigma_h * summed
        d += _sigma_direct(mi, consts, model) * mixing ** 2
        if include_bmeson:
            b += BMESON_SUPPRESSION * _bmeson_term(mi, consts, model)
    return h, d, b


def _weights(scalar_masses, consts, model, sigma_h, include_bmeson=True):
    """
    Shared body of ProductionProb / Crosssections.

    **The B-meson term is dimensionally inconsistent with the other two, and
    it dominates.**  `sigma_h * summed` and `sigma_s * theta^2` are cross
    sections in barns; `bmesondecay = theta^2 * pms * F / m_B` is a
    dimensionless branching-ratio-like quantity, and the Julia adds it to them
    with a bare 1e-3 in front (ScalarProductionshare.jl lines 66-81 and
    143-153).  At the shipped point it contributes 1.12e4 pb against 2.9 pb of
    genuine direct production -- a factor 3800 -- and, because it is nonzero
    only below 4.7 GeV, it also skews which scalar gets produced, not just the
    normalisation.

    Reproduced as written by default, because it is what defines the authors'
    L-A sample.  ``include_bmeson=False`` drops it, and make_lhe records the
    three-term breakdown in every LHE header so the number is never taken at
    face value.
    """
    out = []
    for mi in scalar_masses:
        summed = 0.0
        for mj in scalar_masses:
            summed += _h_to_pair_width(mi, mj, consts, model) / (gamma_bb(consts) * 1.89)
        sigma_s = _sigma_direct(mi, consts, model)
        bmeson = _bmeson_term(mi, consts, model) if include_bmeson else 0.0
        mixing = model.mixing(consts, mi)
        out.append(sigma_h * summed + sigma_s * (mixing ** 2)
                   + BMESON_SUPPRESSION * bmeson)
    return out


def production_prob(scalar_masses, consts: SMConstants, model: ModelParams,
                    include_bmeson=True):
    """
    Julia: ProductionProb.  Returns (probabilities, sigma_h_used).

    L1-normalised weights over the N scalars, combining Higgs-decay, direct and
    B-meson production.  Uses sigma_h = 21.39e-12 barns.
    """
    w = _weights(scalar_masses, consts, model, SIGMA_H_PRODUCTIONPROB,
                 include_bmeson=include_bmeson)
    total = sum(abs(x) for x in w)
    return [x / total for x in w], SIGMA_H_PRODUCTIONPROB


def cross_sections(scalar_masses, consts: SMConstants, model: ModelParams,
                   include_bmeson=True):
    """
    Julia: Crosssections.  Returns (per-scalar cross sections in barns,
    sigma_h_used).  Uses sigma_h = 48.51e-12 barns -- a different value from
    production_prob above, as in the original.
    """
    w = _weights(scalar_masses, consts, model, SIGMA_H_CROSSSECTIONS,
                 include_bmeson=include_bmeson)
    return w, SIGMA_H_CROSSSECTIONS


def production_prob_higgs_pairs(scalar_masses, consts: SMConstants,
                                model: ModelParams):
    """
    Julia: ProductionProbjustHiggsDecaytwomasses.

    Returns (probabilities, mass1, mass2, summed_BR, sigma_h_used) with
    PAIR-level entries: index k gives the probability of producing the pair
    (mass1[k], mass2[k]) from h -> phi phi.  This is the entry point for the
    Higgs benchmark (L-B), where both daughter masses are needed to seed the
    two cascade roots.
    """
    weights = []
    mass1 = []
    mass2 = []
    br_sum = 0.0
    denom = gamma_bb(consts) * 1.89
    for mi in scalar_masses:
        for mj in scalar_masses:
            brara = _h_to_pair_width(mi, mj, consts, model) / denom
            weights.append(brara)
            mass1.append(mi)
            mass2.append(mj)
            br_sum += brara
    total = sum(abs(x) for x in weights)
    probs = [x / total for x in weights] if total > 0 else weights
    return probs, mass1, mass2, br_sum, SIGMA_H_CROSSSECTIONS


def cross_sections_higgs_only(scalar_masses, consts: SMConstants,
                              model: ModelParams):
    """
    Julia: CrosssectionsjustHiggsDecay.  Higgs-decay contribution only, in
    barns, per scalar.  Uses sigma_h = 48.51e-12.
    """
    denom = gamma_bb(consts) * 1.89
    out = []
    for mi in scalar_masses:
        summed = 0.0
        for mj in scalar_masses:
            summed += _h_to_pair_width(mi, mj, consts, model) / denom
        out.append(SIGMA_H_CROSSSECTIONS * summed)
    return out, SIGMA_H_CROSSSECTIONS


def br_h_to_bsm(scalar_masses, consts: SMConstants, model: ModelParams):
    """
    Summed BR(h -> phi_i phi_j) over all N^2 pairs.

    instructions section 9 requires this be checked against the Higgs
    signal-strength bound (roughly <= 0.1 from mu = 1.03 +- 0.06) for every
    benchmark.  Verified value at the shipped point: 7.7e-5.
    """
    denom = gamma_bb(consts) * 1.89
    total = 0.0
    for mi in scalar_masses:
        for mj in scalar_masses:
            total += _h_to_pair_width(mi, mj, consts, model) / denom
    return total


def check_higgs_constraint(scalar_masses, consts: SMConstants,
                           model: ModelParams, bound=0.1):
    """Returns (br, passes) so callers can print it for every benchmark."""
    br = br_h_to_bsm(scalar_masses, consts, model)
    return br, br <= bound
