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
| `RPV_squark{300,600}_UDD` | Squark pair production, direct two-body decay to two quarks — 4 jets |
| `RPV_squark{300,600,150,120}_cascade_LSP{250,550,100,90}` | Squark pair with a cascade `q̃ → q χ̃⁰₁`, `χ̃⁰₁ → qqq` — 8 partons. The 150/100 point gives ~9 jets above 10 GeV |
| `RPV_ewkino{200,300}_UDD` | Electroweak Higgsino production, `χ̃ → t s b` via λ″₃₂₃ — ~7 jets, several b-tagged |
| `RPV_ewkino150_UDD_ctau10mm` | Higgsino below the top threshold decaying via λ″₂₂₃ to `c s b` with cτ = 10 mm — ~6 displaced jets |

The light squark points (120, 150 GeV) are chosen to reach the target jet
multiplicity and energy; those masses are excluded by existing LHC searches, so
they are signature benchmarks rather than viable model points. The Higgsino
points are the non-excluded counterparts.

## Reference / control samples (1 point)

`Zprime_qq_m500`

A 500 GeV sequential Z′ to light quarks, giving two ~250 GeV jets — a
conventional, easily-triggered resonance for comparison.

---

**Cross sections.** For the Pythia-generated points the LO cross section is
written to `outdir/cross_section.txt` at generation time. No k-factors are
applied. For the Higgs-portal points (`SUEPlike_*`, `hToAA_*`) normalise as
σ(gg→φ) × BR using your own assumed branching ratio. For the RPV decay-chain
points (`*_cascade_*`, `RPV_ewkino*`) the cross section MadGraph reports is not
usable, because the widths are set by hand to build the decay-chain propagators;
normalise with the production cross section generated on its own.

Per-point details are in each process directory's `README.md`.
