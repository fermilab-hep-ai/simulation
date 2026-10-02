"""
Measured numbers for the landscape benchmark READMEs.

Kept apart from make_processes.py so that re-measuring is an edit to a table of
results rather than an edit to the generator.  Everything here comes from an
actual run; a point with no entry gets "to measure" in its README rather than a
guess.

Provenance
----------
2026-08-19, 2000 events per point, seed 1234, spectrum seeds as recorded in
params.BENCHMARKS.

  hadronic seeds   truth-level Pythia 8.310, anti-kT R = 0.4, jets pT > 30 GeV
                   and |eta| < 2.4, NO pileup and NO detector
                   (landscape/pythia/analyse.cc)
  lepton seeds     parton level, from the LHE, before showering; the muons come
                   straight from phi -> mu mu so their parton pT is essentially
                   final

Both are **upper bounds on what the real menu sees**: no pileup subtraction, no
PUPPI, no L1 object resolution, and the BPH seed's opposite-sign / dR / dz
requirements are not applied.  Read them as "this point does not come close",
not as efficiencies.
"""

_NO = "no"


def _menu(ht, jet, bph, mu44, quad="no -- the 400 GeV HT leg already fails"):
    return dict(ht=ht, jet=jet, quad=quad, bph=bph, mu44=mu44,
                ele="no -- no electrons in the cascade",
                pho="no -- the photon channel is below 0.1%",
                tau="no", met="no -- nothing escapes but tau neutrinos")


MEASURED = {
    "L-A": {
        "what": (
            "A single hidden scalar, produced directly by gluon fusion through "
            "its Higgs admixture, cascades within the hidden sector until it "
            "reaches scalars below the pair-production threshold, which then "
            "decay to the Standard Model. The whole event is one such chain: "
            "**4 partons at a median 8 GeV**, sharing whatever mass the "
            "produced scalar had (median 2.6 GeV).\n\n"
            "**This point has nothing to trigger on at all.** Only **3.2% of "
            "events contain a single 30 GeV jet**, and the median HT over such "
            "jets is 0. It is not that it fails the menu -- there is no "
            "hadronic object in the event to fail with."),
        "menu": _menu("no -- 0.10%", "no -- 0.15%", "no -- 0.0%", "no -- 0.0%"),
        "notes": """
## Measured, truth level, 2000 events, no pileup

| | |
|---|---|
| parton multiplicity, mean / median | 4.01 / 4 |
| parton energy, median | 8.1 GeV |
| charged multiplicity after showering, median | 33 |
| of which from the hard process | 2 |
| jets above 30 GeV, median | 0 |
| HT, median | 0 GeV |
| leading jet pT, median | 0 GeV |
| signal charged particles displaced > 0.1 mm | 96.4% |
| signal charged r_xy, median / 90% | 2.9 / 31 mm |
""",
    },

    "L-B": {
        "what": (
            "gg -> h -> phi_i phi_j, with each scalar cascading inside the "
            "hidden sector before the terminal decays reach the Standard "
            "Model. **This is the paper's headline: a median of 12 partons at "
            "a median 12 GeV each, sharing 125 GeV.** That was not tuned for -- "
            "it falls out of the ported widths and branching ratios.\n\n"
            "Against a PuppiHT floor of 450 and a single-jet floor of 230, the "
            "measured HT is 121 GeV and the leading jet 67 GeV. The hadronic "
            "menu is missed in ~97% of events.\n\n"
            "**But the muon seed is not missed.** phi -> mu mu carries ~8% of "
            "the terminal decays, and two muons above 4 GeV appear in **19% of "
            "events**. This point is not untriggerable across the board; it is "
            "untriggerable *hadronically*, which is the claim the analysis "
            "actually rests on."),
        "menu": _menu("no -- 2.70%", "no -- 2.15%",
                      "**yes, ~16%** (upper bound, see below)",
                      "**yes, ~19%** (upper bound, see below)"),
        "notes": """
## Measured, truth level, 2000 events, no pileup

| | |
|---|---|
| parton multiplicity, mean / median | 12.38 / 12 |
| parton energy, median | 12.4 GeV |
| invariant mass of all partons | **125.1100 GeV, spread 2.6e-6 GeV** |
| charged multiplicity after showering, median | 113 |
| of which from the hard process | 4 |
| jets above 30 GeV, median | 2 |
| HT, median | 121 GeV |
| leading jet pT, median | 67 GeV |
| hidden-scalar decay r_xy, median / max | 0.00 / 0.40 mm |
| signal charged particles displaced > 0.1 mm | 17.8% (underlying event: 10.7%) |

The 2.7% of events that do pass PuppiHT 450 pass on **initial-state radiation,
not on signal**: the cascade contributes ~31 GeV of charged pT against a
whole-event 265 GeV. That rate is essentially the rate for any 125 GeV
gluon-fusion event.

### The muon seed, and why it is quoted as an upper bound

Two muons above 4 GeV appear in 19% of events, and two above 2 GeV within
|eta| < 1.5 in 16%. Those are parton-level counts: the opposite-sign, dR and dz
requirements of the real BPH seed are not applied, and no L1 muon efficiency is
folded in. Treat them as "this seed is live for this point", not as
efficiencies. `landscape_LB_higgs_displaced` has the same muon rate on paper
but should lose most of it to displacement, which this chain cannot show --
see below.
""",
    },

    "L-B-displaced": {
        "what": (
            "The same h -> phi_i phi_j topology as `landscape_LB_higgs`, at the "
            "shipped lambda = 1e-4 rather than the retuned 2.7e-3.\n\n"
            "**The pair is a controlled comparison, and it is unusually "
            "clean.** Measured side by side at 2000 events, the two points "
            "agree on parton multiplicity (12.39 vs 12.38), flavour "
            "composition, charged multiplicity (113 vs 113), HT (119 vs 121 "
            "GeV), leading jet pT (65 vs 67 GeV) and every L1 rate. The only "
            "thing that differs is **displacement**: the hidden scalars decay "
            "at a median r_xy of 2.6 mm here against 0.00 mm there, and 99.4% "
            "of signal charged particles come from beyond 100 um against "
            "17.8%.\n\n"
            "That makes this the point to use for any question of the form "
            "'does displacement change what the trigger or the anomaly "
            "detector sees', with L-B as the null."),
        "menu": _menu("no -- 2.90%", "no -- 2.35%",
                      "~16% on paper -- **but see the d0 caveat**",
                      "~20% on paper -- **but see the d0 caveat**"),
        "notes": """
## Measured, truth level, 2000 events, no pileup

Side by side with `landscape_LB_higgs` (the retuned, prompt point):

| | L-B (prompt) | this point (displaced) |
|---|---|---|
| parton multiplicity, mean | 12.38 | 12.39 |
| parton energy, median | 12.4 GeV | 12.3 GeV |
| charged multiplicity, median | 113 | 113 |
| jets above 30 GeV, median | 2 | 2 |
| HT, median | 121 GeV | 119 GeV |
| leading jet pT, median | 67 GeV | 65 GeV |
| HT > 450 | 2.70% | 2.90% |
| any jet > 230 | 2.15% | 2.35% |
| **hidden-scalar decay r_xy, median / 90% / max** | **0.00 / 0.08 / 0.40 mm** | **2.6 / 60 / 266 mm** |
| **signal charged displaced > 0.1 mm** | **17.8%** | **99.4%** |
| cross section x BR | 2.70 pb | 3.70e-3 pb |

Everything except the last two rows is the same point. That is the whole
argument for keeping both.

## The displacement survives PU 200 and Delphes

30 events each through the full chain, comparing `L1T_PUPPIPart_D0`:

| L1T PUPPI charged candidates | L-B (prompt) | this point |
|---|---|---|
| per event, pT > 2 GeV | 48.0 | 47.3 |
| of those, \\|d0\\| > 1 mm | 0.30 (0.6%) | **1.47 (3.1%)** |
| per event, pT > 5 GeV | 7.6 | 7.5 |
| of those, \\|d0\\| > 1 mm | 0.17 (2.2%) | **0.83 (11.2%)** |

A 5x enhancement in displaced L1 tracks that survives 200 pileup vertices.
Note the dilution: 99.4% of the *signal's* charged particles are displaced at
truth level, but the signal contributes a handful of candidates against ~1000
from pileup, so the whole-event displaced fraction is 3%, not 99%. Displacement
is a per-track handle here, not a per-event one.

This is also the check that `LesHouches:setLifetime = 1` is doing its job: the
proper decay lengths written into VTIMUP come out the other end as impact
parameters.
""",
    },

    "L-C": {
        "what": (
            "The negative control. At lambda'/lambda = 1e-6 the hidden-sector "
            "quartic is switched off, so no scalar can decay into a pair of "
            "lighter scalars: the cascade never starts and each of the two "
            "scalars from the Higgs decays straight to the Standard Model.\n\n"
            "The topology collapses exactly as intended -- **multiplicity goes "
            "to exactly 4**, and the flavour composition flips from "
            "pion/gluon-dominated to c (54%) and tau (18%), which is an "
            "h -> aa -> 4c / 4tau signature this repository already has prompt "
            "benchmarks for and existing searches already cover.\n\n"
            "It shares L-B's production, coupling and cross section exactly; "
            "one parameter separates uncovered from covered."),
        "menu": _menu("no -- 2.25%", "no -- 1.65%", "no -- 1.9%", "no -- 3.3%"),
        "notes": """
## Measured, truth level, 2000 events, no pileup

| | L-B | L-C (this point) |
|---|---|---|
| parton multiplicity, mean | 12.38 | **4.00** |
| parton energy, median | 12.4 GeV | **47.8 GeV** |
| flavour | pi+- 38%, s 18%, g 18%, pi0 18%, mu 8% | **c 54%, tau 18%, g 14%, s 5%, b 4%** |
| charged multiplicity, median | 113 | 113 |
| jets above 30 GeV, median | 2 | 2 |
| HT, median | 121 GeV | 108 GeV |
| hidden-scalar decay r_xy, median / max | 0.00 / 0.40 mm | 0.00 / 0.43 mm |

### The control is now genuinely prompt

At the shipped lambda this point was **not** prompt -- its scalars decayed
through theta^2-suppressed mixing with millimetre lifetimes, so "already
covered by prompt searches" needed qualifying. The retuning fixed that as a
side effect: cutting the lifetimes by 729 puts the hidden-scalar decay vertices
at a median of 0.00 mm and a maximum of 0.43 mm. The control is prompt where it
claims to be.

80% of its *charged* particles still come from beyond 100 um, but that is
ordinary charm and tau lifetime, not the model -- which is exactly what a
prompt h -> aa -> 4c search is built to handle.

### It is still not distinguishable at jet level

HT 108 vs 121 GeV, leading jet 62 vs 67 GeV, charged multiplicity identical.
L-C separates from L-B in **substructure, flavour and multiplicity of the hard
process**, not in trigger-level energy flow. Use it as a control for what the
anomaly detector keys on, not for what the menu sees.
""",
    },
}

_LD_WHAT = (
    "`landscape_LB_higgs` on an independent landscape realisation. The model "
    "has N = 200 scalars whose masses are drawn once from a uniform "
    "distribution; that draw is the vacuum we live in, and it is fixed per "
    "sample rather than redrawn per event (deviation 7g). These three points "
    "exist so the realisation-to-realisation spread can be measured instead of "
    "averaged away.\n\n"
    "Measured across the three seeds plus L-B's own: bulk energy flow is "
    "stable to a few percent (HT median 120-122 GeV, charged multiplicity 113 "
    "throughout, every L1 rate within 0.5 points), while **parton "
    "multiplicity moves by ~6% and the flavour composition by ~30% relative** "
    "(gluon fraction 17.5-23.8%, pi+- 30.0-38.9%). The trigger conclusions do "
    "not depend on which vacuum you draw; the quantities an anomaly detector "
    "keys on do.")

_LD_NOTES = """
## Measured, truth level, 2000 events per seed, no pileup

| | L-B (424242) | L-D1 (515151) | L-D2 (606060) | L-D3 (717171) |
|---|---|---|---|---|
| parton multiplicity, mean | 12.38 | 11.72 | 11.68 | 12.04 |
| parton energy, median | 12.4 GeV | 12.8 GeV | 12.9 GeV | 12.5 GeV |
| gluon fraction | 18.0% | **23.8%** | 18.4% | 17.5% |
| pi+- fraction | 38.0% | **30.0%** | 38.9% | 37.2% |
| charged multiplicity, median | 113 | 113 | 113 | 113 |
| HT, median | 121 GeV | 122 GeV | 121 GeV | 120 GeV |
| leading jet pT, median | 67 GeV | 66 GeV | 66 GeV | 66 GeV |
| HT > 450 | 2.70% | 3.20% | 2.80% | 2.95% |
| any jet > 30 | 91.4% | 90.6% | 90.6% | 90.5% |
| Sum p closure | 125.1100 | 125.1100 | 125.1100 | 125.1100 |

The spread lives in multiplicity and flavour, not in energy flow. That is the
argument for the fixed-spectrum default: the authors' driver redraws the
spectrum inside the event loop, which averages these four columns together and
washes out the structure.
"""

for _tag in ("L-D1", "L-D2", "L-D3"):
    MEASURED[_tag] = {
        "what": _LD_WHAT,
        "menu": _menu("no -- 2.8-3.2%", "no -- 1.8-2.4%",
                      "~17% (upper bound, as L-B)", "~22% (upper bound, as L-B)"),
        "notes": _LD_NOTES,
    }
del _tag
