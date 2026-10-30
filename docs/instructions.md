# AIDA-Scout — Signal Generation Specification

Handoff document for MC production. Target: anomaly-detection analysis on the CMS Phase-2 L1 scouting stream.

---

## 1. Context you need

**The analysis.** AIDA-Scout is a fully anomaly-detection-based search running on the Phase-2 L1 scouting stream. The stream delivers **PUPPI candidates at 40 MHz** from the correlator layer — i.e. we see individual reconstructed particles, not just L1 jets and sums. This is the central fact for signal selection: soft, high-multiplicity final states that produce *zero* L1 jets are still fully visible to us as particle-level activity.

**The physics goal.** Signals that (a) have a striking, structured signature in PUPPI candidates, and (b) are missed by the Phase-2 L1 menu. We want models where the menu is structurally blind, not just inefficient.

**Phase-2 L1 menu, relevant floors** (offline thresholds at 95–100% plateau, PU = 200, 542 kHz total; online L1 cuts sit somewhat below these):

| Category | Softest available seed | Note |
|---|---|---|
| Hadronic | PuppiHT 450; single PuppiJet 230; QuadJet 400,70,55,40,40 | HT constituents require jet pT > 30 |
| Muon (BPH) | Double TkMuon 2,2 @ 13 kHz | \|η\| < 1.5, ΔR < 1.4, opposite sign, Δz < 1 cm, **tkMuon (prompt track match)** |
| Muon (central) | Double TkMuon 4,4; Triple TkMuon 5,3,0 | \|η\| < 2.4 |
| Electron | Double tkElectron 25,12 | **No BPH-equivalent below 12 GeV** |
| Photon | Double TkIsoPhoton 22,12 | |
| Tau | Double PuppiTau 52,52 | Double CaloTau 90,90 |
| MET | PuppiETmiss 200 (130 in DoubleTkMuon cross-seed) | |

**The three structural gaps we are exploiting:**

1. **Isotropic hadronic energy is untriggerable.** An anti-kT R = 0.4 jet covers area πR² ≈ 0.50 in η–φ against ~31 units of acceptance (|η| < 2.5). A uniformly distributed event puts ≈ 0.50/31 ≈ 1.6% of its energy in the leading jet. For a 125 GeV isotropic decay that is ~1.6 GeV (fluctuating up to ~5–10 GeV), against a 30 GeV HT constituent threshold and a 230 GeV single-jet seed. To reach PuppiHT 450 by isotropic deposition alone would require a mediator mass ≳ 3 TeV, where the cross section is negligible. **This gap covers the entire accessible mass range.**

2. **Lepton-flavour asymmetry.** Soft prompt dimuons have a dedicated 2,2 GeV seed at 13 kHz. Soft di-electrons have *nothing* below 12 GeV. Identical kinematics, completely different trigger fate.

3. **Displacement kills tkMuon.** The BPH seeds require an L1 track match, and L1 tracking is prompt with limited |d0| acceptance. A decay beyond a few cm produces no tkMuon at all, regardless of pT.

---

## 2. Signals to generate

Priority order. Parameter points are starting suggestions — flag if the repo has existing conventions that conflict.

### S1 — SUEP, hadronic (top priority)

Soft Unclustered Energy Patterns. A heavy scalar decays to a strongly-coupled, quasi-conformal hidden sector that showers thermally into many soft, isotropically distributed dark hadrons.

- **Production:** gg → φ (loop-induced). MG5 `loop_sm` / HEFT, or Pythia `HiggsSM:gg2H` directly if simpler.
- **Shower:** dedicated SUEP generator (thermal shower), *not* MadGraph. The Knapen/Griso/Papucci SUEP generator or the CMS-adopted equivalent. Check the repo for an existing integration before building one.
- **Benchmark points:**
  - m_φ = 125, 400 GeV (primary); optionally 750, 1000 GeV
  - Dark temperature T = 1, 2, 4 GeV
  - Dark meson mass m_X = 2 GeV
  - Decay mode: generic hadronic (dark mesons → SM light hadrons)
- **Expected multiplicity:** N ≈ m_φ / ⟨E⟩ ≈ 60 hadrons at ~2 GeV for the 125 GeV / T = 2 GeV point.
- **Critical:** generate with **no ISR requirement**. Existing CMS SUEP searches tag an ISR jet to get a trigger handle, which discards most of the cross section and biases toward the non-isotropic tail. Not requiring ISR is the entire point of doing this in scouting.

### S2 — Dark shower → soft dileptons, **matched ee / μμ pair** (top priority)

This is the cleanest demonstration in the whole program: two samples with **identical kinematics**, differing only in lepton flavour. The μμ sample is covered by the BPH seed; the ee sample is invisible. If AD recovers comparable sensitivity in both, that is a direct, controlled measurement of what the menu is missing.

- **Hard process (MadGraph):** Hidden Valley UFO, `generate p p > zp, zp > qv qv~`
- **Shower/hadronization (Pythia8 HiddenValley module):**
  ```
  HiddenValley:fragment = on
  HiddenValley:FSR = on
  HiddenValley:alphaOrder = 1
  HiddenValley:Ngauge = 3
  HiddenValley:nFlav = 2
  HiddenValley:Lambda = <set consistent with m_πD>
  HiddenValley:pTminFSR = <~1.1 × Lambda>
  HiddenValley:probVector = 0.75
  4900111:m0 = 2.0     # dark pion
  4900113:m0 = 4.0     # dark rho
  ```
- **The flavour switch:** use `4900111:oneChannel` to force **100% → e+e−** in sample A and **100% → μ+μ−** in sample B. Same mass point, same Λ, same everything else. Do not try to get the ee mode by dropping below the dimuon threshold (m < 211 MeV) — that changes the kinematics and ruins the comparison.
- **Benchmark points:** m_Z' = 500, 1000 GeV; m_πD = 2, 5 GeV.
- **Expected signature:** 4–12 soft leptons in 2–4 collimated clusters, roughly φ-balanced.

### S3 — Displaced soft dimuons

The muon gap relocated from threshold to displacement. Defeats tkMuon by construction.

- Same generation chain as S2, μμ mode.
- Scan `4900111:tau0` (or the A′ lifetime, depending on portal) over **cτ = 1, 10, 100 mm**.
- Include a cτ = 0 point — that is S2-μμ and serves as the covered reference.
- Confirm the downstream sim chain actually propagates decay vertices into PUPPI candidate reconstruction; if displaced tracks are dropped upstream this sample is meaningless.

### S4 — Multi-soft-tau

Tau floor is 52 GeV (Puppi) / 90,90 (double calo), with no soft cross-seed rescue absent a hard jet or lepton.

- **Process:** h → a a → 4τ, with m_a = 5, 10, 15 GeV.
- MG5 with a 2HDM+S or generic light-scalar UFO; alternatively gg → h in MG and handle h → aa → ττττ in the Pythia decay table.
- Alternative if simpler in the repo: dark shower (S2 chain) with dark pions forced to ττ.

### S5 — Stealth SUSY / light RPV cascade

Probes a different menu failure mode from S1: **high multiplicity but not isotropic**, and no MET.

- MG5 with the RPV-MSSM UFO. Squark or gluino pair production, λ″ UDD decays to light quarks through a nearly-degenerate spectrum.
- Mass points: m_squark = 300, 600 GeV with small mass splittings in the cascade.
- Target: 8–12 jets, each 10–30 GeV, HT well below 450, MET ≈ 0.

---

## 3. Negative controls — generate these too

These are not optional. Without them the sensitivity claims are uninterpretable, and the question will be asked in review regardless.

- **C1 — Boosted SUEP with hard ISR.** Same as S1 but requiring a high-pT ISR jet. Should be caught by the existing HT seeds. If AD flags it, fine; it must not be part of the headline sensitivity claim.
- **C2 — Prompt collimated soft dimuons (S2-μμ, cτ = 0).** Covered by the BPH 2,2 seed. Doubles as a **calibration signal** — the one model where AD efficiency can be cross-checked against a triggered dataset.
- **C3 — Low-mass dijet resonance** already covered by existing seeds. Standard "AD should not claim credit here" control.
- **C4 — Anisotropy control.** SUEP at fixed multiplicity but with the isotropy deliberately broken (large boost). Tests whether the anomaly score is genuinely detecting anomalousness or is just an isotropy discriminant in disguise. **This is the control most likely to change how we interpret results.**

---

## 4. Generation requirements — read before writing any card

**Do not apply default generator-level cuts.** The MG5 `run_card.dat` defaults (`ptj = 20`, `ptl = 10`, `drjj = 0.4`, `etaj`, `mmll`, …) will destroy every signal in this list. Set all pT and ΔR cuts to **0** and remove invariant-mass windows. This is the single most common way these samples go wrong.

**Matching/merging.** For the soft high-multiplicity signals, do **not** use MLM matching — a low `xqcut` in this regime is unstable and the merged sample will be unreliable. Generate the hard process only and let the parton shower do the rest. If a repo convention mandates matching, flag the conflict rather than silently following it.

**Pileup.** All samples must be overlaid with **PU = 200** before PUPPI reconstruction. Signal-only samples are useful for debugging but are not the deliverable — every conclusion in this analysis depends on how the signal survives PUPPI at PU 200.

**Emulation chain.** Samples must run through the Phase-2 L1 emulator to produce (a) the PUPPI candidate list we train on, and (b) the L1 menu decision bits, so we can demonstrate per-event which seeds fired. **The menu decision is a required output, not an afterthought** — the entire argument is "AD finds this, the menu does not," and that needs to be shown event by event.

**Statistics.** 100k events per parameter point as a default; more for the S2 ee/μμ pair since that comparison carries the headline result.

---

## 5. Deliverables per signal point

1. `proc_card.dat` — process definition
2. `run_card.dat` — with cuts explicitly zeroed as above
3. `param_card.dat` — masses, couplings, lifetimes
4. Pythia8 fragment — shower, HV module config, decay tables, lifetimes
5. Cross-section normalization (MG output, plus k-factor source if applied)
6. A short README per point: what the model is, why it evades the menu, which seeds it *should* fail

Match existing repo conventions for directory layout, naming, and card templates. Inspect the repo first and follow what is there rather than imposing this document's structure.

---

## 6. Open items to resolve

- Does the repo already have a SUEP generator integration, or does one need building? This determines whether S1 is a day or a week.
- Does the sim chain propagate displaced decay vertices through to PUPPI candidates? Blocks S3 if not.
- Which Hidden Valley UFO version is in use, and does it match the Pythia HV module conventions for particle IDs 4900xxx?
- Confirm whether the L1 menu emulation available in the repo matches the PU 200 menu in the table above, or an older/newer version.

---

## 7. Suggested order

1. **S2 ee/μμ pair** — one MG hard process, physics lives in the Pythia fragment, delivers the covered/uncovered contrast in a single campaign. Best effort-to-result ratio.
2. **S1 SUEP** — highest physics impact, but generator integration may be the long pole. Start scoping it in parallel.
3. **S5 stealth SUSY** — MG-native, straightforward, fills out the hadronic non-isotropic corner.
4. **S3 displaced**, **S4 taus**
5. **Controls C1–C4** — build alongside, not at the end.
