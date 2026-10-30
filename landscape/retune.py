"""
Retuning lambda for the Higgs-decay benchmark.

The shipped driver runs at lambda = 1e-4, where BR(h -> BSM) = 7.6e-5 -- three
orders of magnitude below the Higgs signal-strength bound.  The Higgs channel
is therefore invisible at the shipped point (the spec's section 6 note that the
shipped configuration is direct-production dominated by ~500), and section 10
asks for L-B to be generated with lambda retuned.

Everything here follows from one fact:

    Gamma(h -> phi_i phi_j) is proportional to lambda^2,

with no other lambda dependence anywhere in the production chain.  So the
retuning is a closed form, not a scan.

**Two BR conventions, and they differ by 2x.**  The Julia normalises to
Gamma_bb(pole) * 1.89 = 8.13e-3 GeV, whereas the true SM Higgs width is
4.1e-3 GeV (instructions deviation 7d).  Tuning the CODE's BR to 0.1 therefore
lands at a physical BR of 0.17, which is over the bound the spec is quoting.
``lambda_for_br`` defaults to the physical convention for that reason, and
``summarise`` prints both so the discrepancy is never implicit.

**What retuning does and does not change.**  The scalar branching ratios are
ratios of widths that are homogeneous in the couplings: every hidden-sector
channel carries lambda'^2 and every Standard Model channel carries
theta^2 ~ lambda^2.  Raising lambda at fixed lambda' therefore reweights hidden
against SM by (lambda_old/lambda_new)^2 -- but at the shipped point the hidden
channels already carry 1 - 5e-9 of the width of every above-threshold scalar,
so a factor 729 leaves them at 1 - 5.0e-5.  ``cascade_invariance`` measures
this directly: the largest change in hidden fraction anywhere in the spectrum
is 5.0e-5, so multiplicity and flavour composition are unchanged.

What does change is the **lifetime**.  Below the hidden-pair threshold a scalar
has no hidden channel open, so its width is pure mixing and ctau goes as
lambda^-2.  The retuning shortens the median sub-threshold ctau from 2.7 mm to
a few microns: the sample flips from displaced to prompt.  That is why the
shipped-lambda Higgs point is kept as a benchmark in its own right rather than
being replaced -- see params.BENCHMARKS and the README.
"""

import math
from dataclasses import replace

from .params import SMConstants, ModelParams
from . import production as P
from . import branching as B
from . import lifetimes as LT

# True SM Higgs total width, GeV (PDG).  Used only for the physical BR
# convention; nothing in the ported Julia knows about it.
GAMMA_H_SM_GEV = 4.1e-3

# Higgs signal-strength bound quoted in instructions section 9, from
# mu = 1.03 +- 0.06.
BR_BOUND = 0.1


def hidden_width_gev(scalar_masses, consts: SMConstants, model: ModelParams):
    """Summed Gamma(h -> phi_i phi_j) over all N^2 pairs, in GeV."""
    total = 0.0
    for mi in scalar_masses:
        for mj in scalar_masses:
            total += P._h_to_pair_width(mi, mj, consts, model)
    return total


def br_h_to_bsm_physical(scalar_masses, consts: SMConstants,
                         model: ModelParams):
    """
    BR(h -> BSM) normalised to the true SM width, Gamma / (Gamma_SM + Gamma).

    The companion production.br_h_to_bsm uses the Julia's normalisation
    (Gamma_bb from the pole mass, times 1.89), which overstates the SM width by
    2x and so understates the BR by the same factor.
    """
    g = hidden_width_gev(scalar_masses, consts, model)
    return g / (GAMMA_H_SM_GEV + g)


def lambda_for_br(target, scalar_masses, consts: SMConstants,
                  model: ModelParams, convention="physical"):
    """
    The lambda giving BR(h -> BSM) = ``target``, in closed form.

    Gamma is proportional to lambda^2, so with Gamma_0 the width at the model's
    current lambda:

        code      BR = Gamma / D,                lambda = lambda_0 sqrt(t D / Gamma_0)
        physical  BR = Gamma / (Gamma_SM + Gamma),
                  so Gamma = t Gamma_SM / (1 - t) and the same square root
                  applies with D -> Gamma_SM / (1 - t).

    Raises on target >= 1 in the physical convention, where no lambda works.
    """
    if not 0.0 < target < 1.0:
        raise ValueError("target BR must be in (0, 1), got {0!r}".format(target))
    g0 = hidden_width_gev(scalar_masses, consts, model)
    if g0 <= 0.0:
        raise ValueError("h -> phi phi is closed at this spectrum")
    if convention == "physical":
        g_target = target * GAMMA_H_SM_GEV / (1.0 - target)
    elif convention == "code":
        g_target = target * P.gamma_bb(consts) * 1.89
    else:
        raise ValueError("convention must be 'physical' or 'code'")
    return model.lam * math.sqrt(g_target / g0)


def retuned(scalar_masses, consts: SMConstants, model: ModelParams,
            target=BR_BOUND, convention="physical"):
    """The same ModelParams with lambda set to hit ``target``."""
    return replace(model, lam=lambda_for_br(target, scalar_masses, consts,
                                            model, convention))


def cascade_invariance(scalar_masses, consts: SMConstants,
                       model_a: ModelParams, model_b: ModelParams):
    """
    How much the cascade actually moves between two parameter points.

    For every mass in the spectrum, the fraction of the total width carried by
    the hidden-sector pair channels.  This is the only quantity a change in
    lambda can move: within the hidden block and within the SM block the
    relative weights are lambda-independent, because every hidden width carries
    lambda'^2 and every SM width carries theta^2.

    Returns (max_abs_difference, rows) with rows = [(mass, f_a, f_b)].
    """
    rows = []
    worst = 0.0
    for m in scalar_masses:
        vals = []
        for mod in (model_a, model_b):
            br, _, _ = B.branching_ratios_general_quartic_fast(
                m, scalar_masses, consts, mod)
            n_pairs = len(B.allowed_daughter_masses(m, scalar_masses)) ** 2
            vals.append(sum(br[:n_pairs]))
        rows.append((m, vals[0], vals[1]))
        worst = max(worst, abs(vals[0] - vals[1]))
    return worst, rows


def summarise(scalar_masses, consts: SMConstants, model: ModelParams,
              label=""):
    """Human-readable normalisation block for one parameter point."""
    br_code = P.br_h_to_bsm(scalar_masses, consts, model)
    br_phys = br_h_to_bsm_physical(scalar_masses, consts, model)
    xs, _ = P.cross_sections_higgs_only(scalar_masses, consts, model)
    lines = []
    if label:
        lines.append("Normalisation: {0}".format(label))
    lines.append("  lambda = {0:.4g}   lambda' = {1:.4g}   theta = {2:.4g}"
                 .format(model.lam, model.lam_prime, model.mixing(consts)))
    lines.append("  BR(h -> BSM): {0:.4g} (Julia normalisation, Gamma_bb*1.89)"
                 .format(br_code))
    lines.append("                {0:.4g} (physical, Gamma_SM = {1:g} GeV)"
                 " {2}".format(br_phys, GAMMA_H_SM_GEV,
                               "<= bound" if br_phys <= BR_BOUND * (1 + 1e-9)
                               else "*** OVER THE {0:g} BOUND ***"
                               .format(BR_BOUND)))
    lines.append("  sigma(h) x BR = {0:.4g} pb".format(sum(xs) * 1e12))
    lines.append(LT.format_summary(scalar_masses, consts, model))
    return "\n".join(lines)
