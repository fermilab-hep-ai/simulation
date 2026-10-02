# Signal samples

Beyond-the-Standard-Model signal samples for L1 scouting / anomaly-detection
studies. All points are generated at 14 TeV, showered, overlaid with PU 200 and
reconstructed through the same Delphes card as the rest of the repository.

Run any point exactly like the Standard Model processes:

```bash
apptainer exec --bind $simdir \
  /cvmfs/unpacked.cern.ch/registry.hub.docker.com/jmduarte/mapyde:latest \
  sh $simdir/run.sh <process> <nevents> <seed> $simdir False
```

The cards are produced by `../make_signal_cards.py`; edit that script and re-run
it rather than editing individual cards.

---

## Dark showers to soft dileptons (12 points)

`HVdilep_Zp{200,500,1000}_piD{2,5}_{ee,mumu}`

A Hidden Valley Z′ decays to dark quarks, which shower and hadronise in the
hidden sector into dark mesons that decay back to a single lepton flavour. The
final state is a handful of soft, collimated leptons. The `ee` and `mumu` members
of each mass point are identical in every respect except the lepton flavour, so
they form matched pairs.

m_Z′ = 200, 500, 1000 GeV; m_πD = 2, 5 GeV. The 200 GeV points use a stronger
hidden-sector coupling, giving higher multiplicity and softer leptons (~14
leptons/event, median pT ~3 GeV).

## Displaced soft dimuons (3 points)

`HVdilep_Zp500_piD2_mumu_ctau{1,10,100}mm`

The same chain in the muon mode, with a proper lifetime given to the dark mesons.
`HVdilep_Zp500_piD2_mumu` is the cτ = 0 reference.

## Soft high-multiplicity hadronic (5 points)

`SUEPlike_HV_mPhi{125,400}_mX2_Lam{1,2,4}` and `SUEPlike_HV_mPhi125_mX2_Lam2_ISR`

A scalar produced by gluon fusion decays through a Higgs portal into a hidden
sector that showers into many soft dark mesons, which decay to light quarks. The
result is a soft, high-multiplicity, all-hadronic final state with no MET. The
`_ISR` point requires a hard recoil jet; the others have no ISR requirement.

> **Note on the name.** These use Pythia's Hidden Valley module, *not* a thermal
> SUEP generator. A Hidden Valley shower is QCD-like and produces two
> back-to-back dark jets, whereas a real SUEP is isotropic. These samples are
> soft and high-multiplicity but **not isotropic**, and should not be described
> as SUEP.

## Higgs to light pseudoscalars (15 points)

A 125 GeV Higgs decays to a pair of light pseudoscalars `a`, each of which decays
to a single final state — four objects sharing 125 GeV, so each is soft.

| Points | Decay |
|---|---|
| `hToAA_4b_ma{15,30,60}` | `a → bb̄`, four b jets |
| `hToAA_4b_ma30_ctau{1,10,100}mm` | as above, displaced |
| `hToAA_4tau_ma{5,10,15}` | `a → τ⁺τ⁻`, four taus |
| `hToAA_4tau_ma10_ctau{1,10,100}mm` | as above, displaced |
| `hToAA_4gamma_ma{1,5,10}` | `a → γγ`, four photons |

The displaced points give the `a` a proper lifetime; measured median transverse
decay radii are 1.7 / 17 / 170 mm for the 4τ scan and 5.9 / 59 mm for the 4b
scan, the difference being the larger boost of the lighter `a`.

For the 4γ points the photon pair opening angle depends strongly on m_a: at
m_a = 1 GeV the two photons are collimated (median ΔR = 0.05) and often merge
into a single EM cluster, while at m_a = 10 GeV they are well separated
(ΔR = 0.51).

m_a for the 4b mode starts at 15 GeV because the decay must clear 2m_b.

## RPV multijets (9 points)

R-parity-violating SUSY through the λ″ UDD operator: high jet multiplicity, no
MET, not isotropic.

| Points | Description |
|---|---|
| `RPV_squark{300,600}_UDD` | Pair production of the four right-handed light-flavour squarks, direct two-body decay to two quarks — 4 jets, no MET |
| `RPV_squark{300,600,150,120}_cascade_LSP{250,550,100,90}` | Squark pair with a cascade `q̃ → q χ̃⁰₁`, `χ̃⁰₁ → qqq` — 8 partons. The 150/100 point gives ~9 jets above 10 GeV |
| `RPV_ewkino{200,300}_UDD` | Electroweak Higgsino production, `χ̃ → t s b` via λ″₃₂₃ — ~7 jets, several b-tagged |
| `RPV_ewkino150_UDD_ctau10mm` | Higgsino below the top threshold decaying via λ″₂₂₃ to `c s b` with cτ = 10 mm — ~6 displaced jets |

The light squark points (120, 150 GeV) are chosen to reach the target jet
multiplicity and energy; those masses are excluded by existing LHC searches, so
they are signature benchmarks rather than viable model points. The Higgsino
points are the non-excluded counterparts.

**These points need the patched UFO in `models/RPVMSSM_UFO_Wn1`, not the
container's `RPVMSSM_UFO`.** The stock model hardcodes `width = Param.ZERO` for
the neutralino, so `set param_card decay 1000022 ...` in a customizecards file
is silently discarded. The `n1` propagator in the decay chain then has no
regulator, the integration does not converge, and MadGraph unweights only a
handful of events -- measured at 9, 5 and 11 out of 5000 requested for the 120,
300 and 600 GeV cascade points. For `RPV_ewkino150_UDD_ctau10mm` the discarded
width is also what encodes the lifetime, so that point came out prompt. The
proc cards reference the patched model through the `_SIMDIR_` placeholder that
`run.sh` substitutes. See `models/RPVMSSM_UFO_Wn1/PATCH_README.md`.

**In this UFO the MG5 particle name is not the squark flavour.** MG5 names
squarks from their PDG code, but `USQMIX` / `DSQMIX` here order the mass
eigenstates by *mass*, and with the shipped spectrum the stops and sbottoms are
lightest. So `ul`/`cl` are the two stops, `dl`/`sl` are the two sbottoms, and
the states you actually want are `ur` = ũ_R, `t1` = c̃_R, `dr` = d̃_R,
`b1` = s̃_R. The `*_UDD` proc cards previously read
`define sq = ur ul cr cl dr dl sr sl`, described as "the eight light-flavour
squarks"; that set really pair-produced two stops and two sbottoms, and since
λ″ couples only to right-handed squarks, six of the eight had **no open decay at
all** — stable coloured particles. Check the mixing matrices, not the names,
before editing these cards.

## Reference / control samples (1 point)

`Zprime_qq_m500`

A 500 GeV sequential Z′ to light quarks, giving two ~250 GeV jets — a
conventional, easily-triggered resonance for comparison.

---

## Generator-level jet cut

The 27 **hadronic** signal points carry the same generator-level requirement as
the MadGraph Standard Model samples:

> keep the event if it has a **leading jet above 10 GeV** or a **jet HT above
> 50 GeV**.

The 18 points whose visible final state is leptons or photons -- `HVdilep_*`
(15) and `hToAA_4gamma_*` (3) -- carry **no** generator-level cut. Why, below.

### What the Standard Model samples actually do

Not what their names suggest. The cut does not split by final state; it tracks
the MLM merging scale. Every SM sample with `xqcut = 20` carries
`ptj1min = 10`, every one with `xqcut = 10` or `0` carries `ptj1min = 0`, and
the correlation is exact:

| carries `ptj1min = 10` | carries `ptj1min = 0` |
|---|---|
| `WW_leptonic`, `WZ_leptonic`, `ZZ_leptonic` | `ggHWW`, `ggHZZ` |
| `ZJetsTovv` (fully invisible) | `WJetsToLNu`, `DYJetsToLL` |
| `ggHtautau` | `ggHgammagamma`, `ttH_incl`, `tttt_incl` |

`ggHtautau` against `ggHWW` is the clearest pair: same production, neither
hadronic, opposite cut. The two QCD samples are the only ones using `htjmin`,
at 50, which is a regulator for the divergent dijet cross section rather than an
acceptance choice.

So there is no SM rule to copy, and the rule used here is the physical one:
filter a point when the jets being clustered are genuinely hadronic.

### Why the cut reaches further than it looks

Both MG5 cuts are event-level, and neither is gated by `cut_decays`.
`SubProcesses/cuts.f` counts every final-state parton with
`|pdg| <= maxjetflavor` or 21 into `njets` whether or not it came from a decay,
then rejects the event outright if `njets < 1` while either cut is on.
`cut_decays` gates only the per-particle pT / eta / dR cuts.

Two consequences:

* On a decay-chain process such as `p p > sq sq~, (sq > q q)` the cut **does**
  apply to the squark decay quarks. It is not the no-op it looks like with
  `cut_decays = False`.
* On a process with no partons in the final state it rejects everything.
  Measured: `p p > w+ w-, (w+ > e+ ve), (w- > e- ve~)` integrates to
  0.8635 pb at `ptj1min = 0` and returns *zero cross section* at
  `ptj1min = 10`. The 0-jet bins of `WW_leptonic`, `WZ_leptonic`,
  `ZZ_leptonic`, `ZJetsTovv` and `ggHtautau` are therefore discarded by their
  own run cards -- those samples are effectively "+ at least one jet above
  10 GeV". That is a pre-existing property of the SM samples, not something
  introduced here, but it is worth knowing before they are used as a baseline.

### Which signals are filtered, and why those

`SlowJet` clusters the whole visible final state, so leptons and photons end up
inside "jets" -- MG5's `is_a_j` counts neither. Share of the visible truth-level
pT (Gen_Part, status 1, no pileup, neutrinos removed), measured on the
5000-event samples:

| point | e/mu | gamma | |
|---|---|---|---|
| `SUEPlike_HV_mPhi125_Lam2` | 0.0% | 20.4% | hadronic baseline (pi0 photons) |
| `Zprime_qq_m500` | 0.1% | 26.6% | baseline |
| `RPV_squark300_UDD` | 0.1% | 26.2% | baseline |
| `hToAA_4b_ma30` | 2.2% | 27.4% | baseline |
| `hToAA_4tau_ma5` | 5.5% | 26.2% | baseline -- taus decay hadronically |
| `HVdilep_Zp200_piD2_mumu` | **28.6%** | 11.5% | the jets are muon clusters |
| `HVdilep_Zp1000_piD2_mumu` | **40.1%** | 4.9% | the jets are muon clusters |
| `hToAA_4gamma_ma1` | 0.0% | **59.1%** | the jets are photon pairs |

The 20-27% photon fraction is the pi0 content of ordinary jets, which is what
makes the last three rows stand out. For those 18 points a jet filter would be
cutting on the signal's own leptons and photons, so they are left unfiltered --
which is also what the SM samples with no coloured final state do.

| | filtered | how |
|---|---|---|
| `RPV_*` (9) | yes | `ptj1min = 10` in the run card |
| `SUEPlike_HV_*` (5) | yes | `SignalFilter:*` in the Pythia card |
| `hToAA_4b_*` (6) | yes | `SignalFilter:*` |
| `hToAA_4tau_*` (6) | yes | `SignalFilter:*` |
| `Zprime_qq_m500` (1) | yes | `SignalFilter:*` |
| `HVdilep_*` (15) | **no** | `SignalFilter:on = off`, stated in the card |
| `hToAA_4gamma_*` (3) | **no** | `SignalFilter:on = off`, stated in the card |

The classification lives in `make_signal_cards.py:UNFILTERED_PREFIXES`; a point
that is neither gets filtered, so a new leptonic signal must be added there
deliberately.

### How the Pythia filter works

Pythia points have no parton-level jet to cut on -- for the Hidden Valley
samples the visible jets are made by the dark shower, long after the hard
process. `main_signal.cc` clusters the visible final state into anti-kT R = 0.4
jets above 10 GeV within |eta| < 5 -- the same object Delphes calls
`Gen_JetAK4` -- and vetoes the event before it is written to HepMC. The event
loop then keeps generating until the requested number has been *accepted*, so a
filtered sample is still the size that was asked for, exactly as MadGraph
behaves.

Because the filter runs before Delphes it changes the cross section, so these
points write five numbers to `outdir/cross_section.txt`:

| key | meaning |
|---|---|
| `xsec_pb`, `xsec_pb_err` | cross section **after** the filter -- what the sample represents |
| `xsec_pb_unfiltered`, `xsec_pb_unfiltered_err` | before the filter |
| `filter_eff`, `filter_accepted`, `filter_generated` | the measured efficiency and the counts behind it |

An unfiltered point reports an efficiency of 1 and two identical cross sections.

### Measured efficiency

Measured by generating until 500 events were accepted (binomial uncertainty
~0.9%). The filter runs before Delphes and before pileup, so these are
production efficiencies, not a reconstructed approximation.

| Family | Filter efficiency |
|---|---|
| `SUEPlike_HV_mPhi125_*` | 96.0% (Lam1), 96.7% (Lam2), 100% (`_ISR`) |
| `SUEPlike_HV_mPhi400_*` | 99.2 - 99.8% |
| `hToAA_4tau_*` | 98.8 - 99.4% |
| `hToAA_4b_*` | 99.4 - 100% |
| `Zprime_qq_m500` | 100% |
| `RPV_*` (all nine, MadGraph) | 100% |

The MadGraph side was checked directly rather than by proxy. Two points were
integrated twice at the same seed, once with `ptj1min = 10` and once with it
zeroed:

| point | with the cut | without |
|---|---|---|
| `RPV_squark120_cascade_LSP90` (softest jets) | 5.4437911e-14, 2000/2000 | 5.4437911e-14, 2000/2000 |
| `RPV_squark300_UDD` | 29.880685 pb, 1997/2000 | 29.880685 pb, 1997/2000 |

Identical to every digit, so the cut removes nothing on either. (The cascade
number is not a physical cross section -- the widths are set by hand, see below.
The 29.88 pb for `RPV_squark300_UDD` agrees with the 29.83 +- 0.089 pb measured
on the 5000-event production sample, and the 1997/2000 shortfall is present with
and without the cut, so it is MG5 unweighting, not the cut.)

This also reverses the earlier spec-section-4 decision to zero `ptj1min` on the
RPV points, whose stated reason was that 10 GeV would bias a signal with 10-30
GeV jets. It does not: the softest RPV point has a median leading jet of
66.7 GeV, and all nine clear a stricter 15 GeV truth-jet test in 5000 of 5000
events. MLM matching stays off (`ickkw = 0`, `xqcut = 0`) -- that part of
section 4 still holds.

---

**Cross sections.** For the Pythia-generated points the LO cross section is
written to `outdir/cross_section.txt` at generation time. No k-factors are
applied. For the Higgs-portal points (`SUEPlike_*`, `hToAA_*`) normalise as
σ(gg→φ) × BR using your own assumed branching ratio. For the RPV decay-chain
points (`*_cascade_*`, `RPV_ewkino*`) the cross section MadGraph reports is not
usable, because the widths are set by hand to build the decay-chain propagators;
normalise with the production cross section generated on its own.

Per-point details are in each process directory's `README.md`.
