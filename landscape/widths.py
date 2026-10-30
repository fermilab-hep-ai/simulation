"""
Partial decay widths for the landscape scalar model.

Direct port of the Decay* functions in scalarattributesshare.jl.  Every formula
is reproduced as written, including the deliberate deviations catalogued in
instructions section 7 -- the model is defined by the code, so substituting a
textbook form would change the model.

All functions are pure: constants come in through ``consts`` and ``model``
rather than from module globals, which is where a port most easily diverges
from its original.
"""

import math

from .params import SMConstants, ModelParams


# ---------------------------------------------------------------------------
# Hidden-sector decays
# ---------------------------------------------------------------------------

def width_scalar_to_scalar_general_quartic(m, m1, m2, model: ModelParams):
    """
    phi -> phi_j phi_k, general quartic.  Julia:
    DecayWidthScalartoScalargeneralquartic.

        Gamma = (1/16pi) M*^2 lambda'^2 (24/N^2)
                * sqrt((m^2-(m1+m2)^2)(m^2-(m1-m2)^2)) / m^3

    Zero below threshold.  Note the 24/N^2 scaling; the nearest-neighbour
    "pairing" variant instead uses 1/N^4, a difference of 24 N^2 ~ 1e6 at
    N = 200.  This is the general-quartic form used by the paper's main results.
    """
    if m > (m1 + m2):
        return ((1.0 / (16.0 * math.pi)) * model.M_star ** 2 * model.lam_prime ** 2
                * (24.0 / (model.N ** 2))
                * math.sqrt((m ** 2 - (m1 + m2) ** 2) * (m ** 2 - (m1 - m2) ** 2))
                / (m ** 3))
    return 0.0


def width_scalar_to_scalar_pairing(m, m_product, model: ModelParams):
    """
    phi -> phi phi in the nearest-neighbour pairing variant.  Julia:
    DecayWidthScalartoScalar.  Not our benchmark; provided for completeness.
    """
    return (1.0 / (16.0 * math.pi * m)
            * math.sqrt(1.0 - 4.0 * (m_product ** 2 / m ** 2))
            * model.M_star ** 2 * model.lam_prime ** 2
            * (1.0 / (model.N ** 4)))


# ---------------------------------------------------------------------------
# Decays back to the SM through Higgs mixing
# ---------------------------------------------------------------------------

def width_scalar_to_fermions(m, m_fermion, coupling, colour_factor,
                             consts: SMConstants, model: ModelParams):
    """
    phi -> f fbar.  Julia: DecayWidthScalartoSM.

        Gamma = (N_c/8pi) theta^2 y_f^2 m (1 - 4 m_f^2/m^2)^{3/2}

    No threshold guard here -- the caller is responsible, exactly as in the
    Julia, where the m > 2 m_f checks live in the BranchingRatios* assembly.
    """
    mixing = model.mixing(consts, m)
    return (1.0 / (8.0 * math.pi) * mixing ** 2 * coupling ** 2 * m
            * (1.0 - ((4.0 * m_fermion ** 2) / (m ** 2))) ** 1.5
            * colour_factor)


def width_scalar_to_WW(m, consts: SMConstants, model: ModelParams):
    """phi -> W+ W-.  Julia: DecayWidthScalartoSMWboson."""
    mixing = model.mixing(consts, m)
    mW = consts.m_W
    return ((2.0 / (math.pi * 32.0 * consts.vev ** 2)) * mixing ** 2 * m ** 3
            * (1.0 - ((4.0 * mW ** 2) / (m ** 2))) ** 0.5
            * (1.0 - 4.0 * (mW ** 2 / m ** 2) + 12.0 * (mW ** 4 / m ** 4)))


def width_scalar_to_ZZ(m, consts: SMConstants, model: ModelParams):
    """
    phi -> Z Z.  Julia: DecayWidthScalartoSMZboson.

    DEVIATION (instructions 7b): the Julia uses the global m_W in the kinematic
    factor rather than m_Z, so this is the WW expression with the 2 -> 1
    prefactor change only.  Only bites for m_phi > 2 m_Z ~ 182 GeV, i.e. never
    for the light benchmark.  ``model.zz_uses_mW = False`` switches to the m_Z
    form for heavy scans.
    """
    mixing = model.mixing(consts, m)
    mV = consts.m_W if model.zz_uses_mW else consts.m_Z
    return ((1.0 / (math.pi * 32.0 * consts.vev ** 2)) * mixing ** 2 * m ** 3
            * (1.0 - ((4.0 * mV ** 2) / (m ** 2))) ** 0.5
            * (1.0 - 4.0 * (mV ** 2 / m ** 2) + 12.0 * (mV ** 4 / m ** 4)))


def width_to_photons(m, consts: SMConstants, model: ModelParams):
    """
    phi -> gamma gamma.  Julia: DecaytoPhotons.  No threshold: this channel is
    always open, which is what keeps the total width non-zero for scalars below
    every other threshold.
    """
    mixing = model.mixing(consts, m)
    return (7.0 ** 2 * ((1.0 / consts.alpha_em_inv) / (4.0 * math.pi)) ** 2
            * mixing ** 2 * consts.G_F_photons * (m ** 3)
            / (8.0 * math.sqrt(2.0) * math.pi))


def width_to_pions(m, consts: SMConstants, model: ModelParams):
    """
    phi -> pi pi.  Julia: DecaytoPions.

    Polynomial form factor, with a (0.3/m)^3 suppression applied at and above
    1 GeV.  The caller applies the isospin factor 2 for the pi0-mass channel.
    """
    mixing = model.mixing(consts, m)
    poly = 0.983 + 6.54 * m ** 2 - 1.12 * m ** 4 + 0.071 * m ** 6
    if m < 1.0:
        return mixing ** 2 * 1e-8 * poly
    return (0.3 / m) ** 3 * mixing ** 2 * 1e-8 * poly


def width_to_gluons(m, consts: SMConstants, model: ModelParams):
    """
    phi -> g g.  Julia: DecaytoGluons.  Zero at or below 0.4 GeV; the effective
    number of heavy flavours in the loop steps with the quark thresholds.
    """
    if m > 0.4:
        mixing = model.mixing(consts, m)
        if m < 2.0 * consts.m_strange:
            Nh = 4
        elif m < 2.0 * consts.m_charm:
            Nh = 3
        elif m < 2.0 * consts.m_b:
            Nh = 2
        else:
            Nh = 1
        return (mixing ** 2 * (Nh ** 2 * consts.alpha_s ** 2 * m ** 3)
                / (72.0 * math.pi ** 3 * consts.vev ** 2))
    return 0.0
