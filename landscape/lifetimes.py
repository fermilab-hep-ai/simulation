"""
Proper lifetimes across the scalar spectrum.

The Julia never computes a total width -- it only ever needs normalised
branching ratios -- so nothing in the original outputs a ctau (instructions
section 5.3).  This module sums the partial widths and reports the resulting
decay-length distribution, because promptness has to be decided per benchmark
rather than assumed (instructions section 9).

**At the shipped benchmark it is not prompt.**  The spectrum splits in two at
2*min(spectrum), the threshold for the hidden-sector pair channel:

  * above it, phi -> phi phi is open and dominates, giving Gamma ~ 1e-2 GeV and
    ctau ~ 1e-11 mm -- prompt by any measure;
  * below it, the only channels left are the Higgs-mixing ones, suppressed by
    theta^2 ~ 1e-6, giving Gamma ~ 1e-13 GeV and **ctau of order 1 mm**.

Every cascade terminates on scalars in the second group, so the visible decays
of a landscape event are displaced at the mm scale even though the cascade
itself is instantaneous.  This is the regime where L1 tracking -- which is
prompt -- starts to lose the tracks, so it is a property of the signal worth
carrying downstream rather than a detail.

Note the sub-threshold ctau is independent of lambda': those scalars have no
hidden channel open, so their width is pure mixing and scales as lambda^2 only.
The negative control L-C (lambda'/lambda ~ 1e-6) therefore has the SAME light-
scalar lifetimes as L-A; what changes is that the heavy scalars also become
long-lived (ctau ~ 1e-3 mm rather than 1e-11).
"""

import math

from .params import SMConstants, ModelParams
from .branching import total_width, HBARC_GEV_MM, allowed_daughter_masses


def ctau_table(scalar_masses, consts: SMConstants, model: ModelParams):
    """[(mass, total width in GeV, ctau in mm)] for every scalar, sorted by mass."""
    out = []
    for m in sorted(scalar_masses):
        g = total_width(m, scalar_masses, consts, model)
        out.append((m, g, HBARC_GEV_MM / g if g > 0.0 else math.inf))
    return out


def hidden_channel_threshold(scalar_masses):
    """
    The mass above which the hidden-sector pair channel opens.

    branching.allowed_daughter_masses keeps x with x + min(spectrum) < m, so a
    scalar has at least one open pair channel exactly when
    m > 2*min(spectrum).  This is the boundary the lifetime distribution
    splits on.
    """
    return 2.0 * min(scalar_masses)


def summarise(scalar_masses, consts: SMConstants, model: ModelParams):
    """
    Lifetime summary for one benchmark.

    Returns a dict with the quantiles and, separately, the two populations
    either side of the hidden-channel threshold -- reporting a single median
    over the whole spectrum hides the split, which is the whole point.
    """
    table = ctau_table(scalar_masses, consts, model)
    thr = hidden_channel_threshold(scalar_masses)
    below = [c for m, _, c in table if m <= thr]
    above = [c for m, _, c in table if m > thr]
    allc = sorted(c for _, _, c in table)

    def q(vals, f):
        if not vals:
            return None
        s = sorted(vals)
        return s[min(len(s) - 1, int(f * len(s)))]

    return {
        "n": len(table),
        "threshold_gev": thr,
        "n_below": len(below),
        "n_above": len(above),
        "frac_below": len(below) / len(table) if table else 0.0,
        "ctau_min_mm": allc[0] if allc else None,
        "ctau_median_mm": q(allc, 0.5),
        "ctau_max_mm": allc[-1] if allc else None,
        "below_median_mm": q(below, 0.5),
        "below_max_mm": max(below) if below else None,
        "above_median_mm": q(above, 0.5),
        "above_max_mm": max(above) if above else None,
    }


def format_summary(scalar_masses, consts: SMConstants, model: ModelParams,
                   label=""):
    s = summarise(scalar_masses, consts, model)
    lines = []
    if label:
        lines.append("Lifetimes: {0}".format(label))
    lines.append(
        "  {0} scalars, hidden-pair threshold 2*m_min = {1:.4g} GeV".format(
            s["n"], s["threshold_gev"]))
    lines.append(
        "  ctau over the whole spectrum: min {0:.3e}  median {1:.3e}  "
        "max {2:.3e} mm".format(
            s["ctau_min_mm"], s["ctau_median_mm"], s["ctau_max_mm"]))
    if s["n_above"]:
        lines.append(
            "  above threshold ({0} scalars, hidden pair channel open): "
            "median {1:.3e} mm  max {2:.3e} mm".format(
                s["n_above"], s["above_median_mm"], s["above_max_mm"]))
    if s["n_below"]:
        lines.append(
            "  below threshold ({0} scalars = {1:.1%}, mixing only): "
            "median {2:.3e} mm  max {3:.3e} mm  <-- DISPLACED".format(
                s["n_below"], s["frac_below"], s["below_median_mm"],
                s["below_max_mm"]))
    return "\n".join(lines)


def sample_proper_time_mm(ctau, u):
    """
    Draw a proper decay length from exp(-t/ctau) given a uniform u in [0, 1).

    Returned in mm, i.e. as c*tau, which is what LHE's VTIMUP wants.
    """
    if ctau == 0.0:
        return 0.0
    if math.isinf(ctau):
        return math.inf
    # 1 - u rather than u so u = 0 maps to 0 rather than to infinity
    return -ctau * math.log(1.0 - u)


def assign_proper_times(root, scalar_masses, consts: SMConstants,
                        model: ModelParams, stream, cache=None):
    """
    Give every scalar node in a decay tree a proper decay length, in mm.

    Sets ``node.ctau_mm`` (the species' mean) and ``node.tau_mm`` (this node's
    draw) as attributes.  Leaves are untouched -- their lifetimes are Pythia's
    business, not ours.

    ``cache`` maps mass -> ctau so the O(N^2) width sum is not repeated for
    every node; pass the same dict across an entire sample.
    """
    from .cascade import iter_nodes

    if cache is None:
        cache = {}
    for node in iter_nodes(root):
        if not node.is_scalar:
            continue
        ct = cache.get(node.mass)
        if ct is None:
            g = total_width(node.mass, scalar_masses, consts, model)
            ct = HBARC_GEV_MM / g if g > 0.0 else math.inf
            cache[node.mass] = ct
        node.ctau_mm = ct
        node.tau_mm = sample_proper_time_mm(ct, stream.next())
    return root


def assign_vertices(root, origin=(0.0, 0.0, 0.0)):
    """
    Propagate decay vertices down the tree, in mm.

    A scalar produced at x with four-momentum p and proper decay length
    tau (= c*tau_proper) decays at

        x + (p_vector / m) * tau

    since p/m = beta*gamma.  Every node gets ``vertex_mm`` = the point at which
    it was PRODUCED, so a leaf's vertex is where its parent decayed.

    Requires assign_kinematics and assign_proper_times to have run first.
    """
    from .cascade import iter_nodes

    root.vertex_mm = tuple(origin)
    for node in iter_nodes(root):
        if not node.children:
            continue
        if node.tau_mm is None or node.p4 is None:
            raise ValueError(
                "assign_kinematics and assign_proper_times must run first")
        x, y, z = node.vertex_mm
        if math.isinf(node.tau_mm):
            raise ValueError("stable scalar cannot be placed; ctau is infinite")
        # m > 0 for every decaying scalar, so no guard needed beyond this
        f = node.tau_mm / node.mass
        end = (x + node.p4.px * f, y + node.p4.py * f, z + node.p4.pz * f)
        for c in node.children:
            c.vertex_mm = end
    return root


def transverse_displacement_mm(node):
    """Radial distance of a node's production vertex from the beam line."""
    x, y, _ = node.vertex_mm
    return math.hypot(x, y)
