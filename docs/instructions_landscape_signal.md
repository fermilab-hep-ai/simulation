# AIDA-Scout — Signal S1b: Landscape Scalar Cascades

Generation spec. This signal is separated from the main signal document because **it is not a MadGraph card-writing task** — the authors have shared their model code in Julia, and the work is porting it, extending it to produce kinematics, and interfacing it to Pythia.

**Reference:** R. T. D'Agnolo, M. Ettengruber, L.-T. Wang, *"Landscapes at Colliders,"* arXiv:2512.18001.

---

## 1. Context

AIDA-Scout is an anomaly-detection analysis on the CMS Phase-2 L1 scouting stream, which delivers **PUPPI candidates at 40 MHz** with no trigger threshold applied. The target is signals that are structurally invisible to the Phase-2 L1 menu but rich in the scouting data.

The relevant menu floors (offline thresholds at 95–100% plateau, PU = 200): PuppiHT 450, single PuppiJet 230, HT constituents require jet p_T > 30, quad-jet seed 400/70/55/40/40, PuppiETmiss 200. There is no hadronic seed below HT ≈ 300.

**The model.** N ~ 50–200 real singlet scalars φ_i, each mixing with the SM Higgs (coupling λ, mixing angle θ) and coupled to one another through a quartic λ′. When λ′ is not tiny, scalars preferentially cascade within their own sector before terminal decays to the SM through Higgs mixing — so the final states follow SM-Higgs-like branching ratios at the relevant mass, meaning b quarks dominate above ~10 GeV. The result is long decay chains producing many soft, b-rich particles.

**Why it is a target.**

- Median multiplicity from Higgs-initiated cascades is ~12 particles sharing ~125 GeV, i.e. ~10 GeV each. Total visible E_T ≈ 125–175 GeV against PuppiHT 450, with no jet near the 230 GeV single-jet seed. Untriggerable across the accessible mass range.
- The signal spreads across many distinct final states, each with a tiny branching ratio, so no single channel is targetable by a cut-based search. This is a stronger argument for anomaly detection specifically than most of our other benchmarks.
- The paper explicitly motivates data scouting and cites the CMS scouting report (arXiv:2403.16134).

---

## 2. Code inventory

Three Julia files from the authors:

| File | Lines | Contents |
|---|---|---|
| `scalarattributesshare.jl` | 920 | Decay widths, branching ratios, cascade generation |
| `ScalarProductionshare.jl` | 280 | Production cross sections and per-scalar production probabilities |
| `ScalarScanningshare.jl` | 325 | Driver: benchmark parameters, event loop, multiplicity/flavour plots |

Read all three before writing any Python. The driver is the entry point and defines the working parameter set.

**Two hidden-sector decay models exist in the code.** `DecayWidthScalartoScalargeneralquartic` (general case) and `DecayWidthScalartoScalar` (nearest-neighbour "pairing" variant). **The paper's main results and the driver use the general quartic.** The pairing functions and their `DecayChainpaired` / `BranchingRatiospairing*` companions are a different model variant — port them if cheap, but they are not our benchmark.

**Dead imports.** `BAT`, `Neurthino`, `HDF5`, `ValueShapes`, `DensityInterface`, `QuadGK`, `TypedTables` are imported but never used. Drop them; do not look for Python equivalents.

---

## 3. Critical fact: the multiplicity is parton-level

`DecayChaingeneralquartic` returns a flat list called `Products` whose entries are **masses of SM particles at the decay-product level** — b, c, τ, s, μ, π, e, γ, g, W, Z, t. The driver plots `length(productvector)` against an axis labelled "Final State Particles". There is no shower, no hadronization, and no jet clustering anywhere in the code.

So the paper's median of ~12 counts **partons and leptons before showering**. Twelve b quarks at ~10 GeV each produce a substantially higher detector-level multiplicity in the PUPPI stream. Set expectations from post-shower output, not from the paper's figures.

---

## 4. Physics as implemented

Port these as written. Do not substitute textbook forms or "improved" treatments — the model is defined by this code, and silently changing a formula changes the model.

**Constants** (driver, GeV): m_h = 125.11, m_b = 4.18, m_τ = 1.78, m_c = 1.28, m_s = 0.096, m_μ = 0.10566, m_e = 0.000511, m_W = 80.37, m_Z = 91.19, m_t = 172.57, v = 246. Yukawas y_f = m_f/v.

**Mixing angle** — mass-independent, using m_h² in the denominator:

```
θ = λ · M* · v₂ / (√N · m_h²)
```

**φ → ff̄:**  `Γ = (N_c/8π) · θ² · y_f² · m_φ · (1 − 4m_f²/m_φ²)^{3/2}`

**φ → φ_j φ_k (general quartic):**

```
Γ = (1/16π) · M*² · λ′² · (24/N²) · √((m²−(m_j+m_k)²)(m²−(m_j−m_k)²)) / m³
```

zero below threshold. Note the `24/N²` scaling — the pairing variant instead uses `1/N⁴`, a difference of 24N² ≈ 10⁶ at N = 200. Use the general-quartic form for our benchmarks.

**φ → γγ, gg, ππ** use closed forms in the code: a polynomial pion form factor `(0.983 + 6.54m² − 1.12m⁴ + 0.071m⁶)` with a `(0.3/m)³` suppression above 1 GeV, and a gluon width with flavour-threshold-dependent `Nh` and fixed `αs = 0.44`. The charged-pion channel carries an isospin factor 2 relative to neutral.

**h → φ_i φ_j:**

```
Γ = 2λ²v₂² · √((m_h²−(m_i+m_j)²)(m_h²−(m_i−m_j)²)) / (4π N² m_h³)
BR ≈ Γ / (Γ_bb · 1.89),   Γ_bb = 3 m_h m_b² G_F / (4π√2)
```

**Branching-ratio assembly and ordering.** `BranchingRatiosgeneralquartic` returns `(BR, masses1, masses2)` — parallel arrays where index *k* gives the branching ratio and both daughter masses for channel *k*. The cascade samples an index from `Categorical(BR)` and reads the daughters from `masses1[k]`, `masses2[k]`. **The ordering of these arrays is load-bearing.** Preserve it exactly.

Note that `BranchingRatios` (the non-general version) returns only the BR vector, and the caller reconstructs the daughter from a separately-built `massesavailable` list whose order must match. The general-quartic path avoids this fragility, which is another reason to use it.

**Photon/gluon encoding.** When the sampled channel is γγ or gg, the code pushes the *integer* 1 (photon) or 2 (gluon) into `Products` rather than a mass, and the plotting code keys on `key == 1` / `key == 2`. Preserve this convention or replace it with an explicit particle-ID enum throughout — but do not half-migrate, or the flavour histograms will silently lose entries.

---

## 5. What the code does not provide

This is the bulk of the work.

1. **No kinematics whatsoever.** The cascade tracks *masses only*. There are no four-vectors, no decay angles, no boosts. `Products` is a list of numbers that happen to be masses. Kinematics must be written from scratch, and it is what Pythia needs.
2. **No LHE writer or Pythia interface.**
3. **No lifetimes.** Total widths are computable from the existing functions, but nothing outputs cτ.
4. **No energy-spectrum code.** The paper's median-energy figures cannot be reproduced from what we have, so they are not available as a validation target.
5. **No constraint check** on BR(h → BSM) against the Higgs signal-strength bound.
6. **Not seeded.** The driver uses `@threads` with Julia's default RNG and no seed, so results are not reproducible run to run. Fix in the port.

---

## 6. The shipped benchmark

Driver values: `N = 200`, `λ = λ′ = 1e-4`, `M* = 10000 GeV`, `v₂ = 0.9v = 221.4`, spectrum uniform on `[10/√200, 10] = [0.707, 10] GeV`, `L = 3000 fb⁻¹`.

Verified numbers at this point:

| Quantity | Value |
|---|---|
| Mixing angle θ | 1.00 × 10⁻³ |
| BR(h → BSM), summed over all N² pairs | 7.7 × 10⁻⁵ |
| σ_h × BR (Higgs channel) | 3.7 × 10⁻³ pb |
| σ_direct × θ², summed over 200 scalars | ≈ 1.9 pb |
| **Direct / Higgs production ratio** | **≈ 500** |

**The shipped driver is direct-production dominated by a factor ~500.** The Higgs-decay mode is sub-percent here. For the Higgs benchmark — higher energy per particle, reconstructable resonance — use `ProductionProbjustHiggsDecaytwomasses` (which returns pair-level probabilities together with both daughter masses) and `CrosssectionsjustHiggsDecay`, and expect to need a different λ. Do not assume the shipped configuration is the Higgs benchmark.

**Mass spectrum sampling is uniform in mass**, via `Uniform(low, up)`. Not uniform in m². Match the code.

The spectrum `[0.707, 10] GeV` straddles the B-meson threshold at m_B − m_K ≈ 4.6 GeV; the code handles B-meson production via a `bmesondecay` term carrying a hard-coded `1e-3` suppression factor.

---

## 7. Known deviations — implement deliberately

These are places where the code departs from what a naive reading would give. Implement the code's behaviour as the default so we reproduce the authors' results, but make each switchable and quantify the impact.

**(a) γγ vs gg splitting.** In `DecayChaingeneralquartic` (~lines 628–650), when the γγ/gg placeholder is drawn, the split is computed as:

```julia
if BR[l-1] > BR[l]
    pphoton = 1 - BR[l]/BR[l-1];  pgluon = BR[l]/BR[l-1]
else
    pphoton = BR[l-1]/BR[l];      pgluon = 1 - BR[l-1]/BR[l]
end
```

The standard conditional split would be `BR[l-1]/(BR[l-1]+BR[l])`. These differ — for BR = (0.6, 0.3) the code gives p_γ = 0.50 against 0.67. Multiplicity is unaffected, but the **gluon fraction changes**, and gluons mean jets while photons mean EM deposits. That is first-order for our PUPPI signature. **Implement both behind a flag, default to the code's version, and report the difference in gluon fraction.**

**(b) ZZ width uses m_W.** `DecayWidthScalartoSMZboson` uses `(1 − 4m_W²/m²)` with the global `m_W` rather than `m_Z`. Only bites for m_φ > 2m_Z ≈ 182 GeV, so irrelevant for the light benchmark. Reproduce as written; add a flag for the m_Z version if we go heavy.

**(c) Two σ_h values.** `ProductionProb` uses `21.39e-12`; `Crosssections`, `ProductionProbjustHiggsDecay*` and `CrosssectionsjustHiggsDecay` use `48.51e-12`. Sampling weights and event-count normalization therefore use different Higgs cross sections. Keep both as written, but **expose σ_h as a named parameter** rather than a literal, and log which value each call path uses.

**(d) Γ_bb uses the pole mass.** Built from `m_b = 4.18` rather than the running mass at m_h (≈ 2.8 GeV), giving 4.30 × 10⁻³ GeV; with the `×1.89` factor the assumed total Higgs width is 8.13 × 10⁻³ GeV against the true SM 4.1 × 10⁻³. BR(h → BSM) is therefore low by roughly 2×, i.e. the Higgs-mode rate is conservative. Reproduce as written; note the factor in the sample README.

**(e) Pion mass labelling is inverted.** `m_u = 0.134` (the π⁰ mass) feeds the channel carrying the isospin factor 2, which the legend labels π⁺π⁻; `m_d = 0.139` (the π± mass) feeds the factor-1 channel labelled π⁰π⁰. The isospin factors are correct and the numerical effect is negligible. Rename the variables to `m_pi0` / `m_pipm` in the port with a comment, but **do not swap the values** — that would change the numbers.

**(f) Mixing angle is mass-independent.** `θ` uses `m_h²` rather than `|m_h² − m_φ²|`, i.e. the m_φ ≪ m_h limit. This becomes unreliable as m_φ approaches or exceeds m_h. Keep our benchmarks light, or add the mass-dependent denominator behind a flag and check the difference.

**(g) A new mass spectrum is drawn per event.** In the driver, `massdistsample2 = rand(massdistribution, N)` sits *inside* the event loop, so the paper's distributions are marginalized over landscape realizations.

**This is a modelling choice we must make deliberately, and it is the most consequential item here.** For a signal MC sample the physical picture is a *single* realization — we live in one vacuum, with one spectrum — and marginalizing smears out exactly the structure an anomaly detector would key on. **Default to a fixed spectrum per sample, with the seed recorded**, and generate several independent realizations as a systematic. Implement the marginalized mode too, since reproducing the paper's figures requires it.

*(Minor, non-blocking: the diagnostic at driver line 106 passes `massdis` where the surrounding loop uses `massdistsample2`. Affects only the printed `equalitypoint`, not the physics.)*

---

## 8. Python port and verification protocol

The port is worth doing for repo consistency, but the value is entirely in the verification. A silent factor of 2 in a width propagates into every sample and is nearly invisible downstream. Do not skip this section or retrofit the tests.

### 8.1 Structure

```
landscape/
  widths.py        # all Decay* functions, pure, no globals
  branching.py     # BranchingRatios* assembly
  production.py    # ProductionProb*, Crosssections*
  cascade.py       # DecayChain*, with injectable RNG
  kinematics.py    # NEW: four-vectors, sequential 2-body decay
  lhe.py           # NEW: LHE / Pythia fragment output
  params.py        # benchmark definitions
  tests/
```

Constants are **globals in the Julia**, read implicitly inside functions. In Python pass them explicitly or hold them in a frozen dataclass. Do not reproduce the global-mutable-state pattern — it is where a port most easily diverges.

### 8.2 Tier 1 — deterministic functions, exact agreement

Every width and branching-ratio function is deterministic. Build an input grid spanning all threshold regions: below 2m_e, between each pair of fermion thresholds, above 2m_t, and either side of the 0.4 and 1.0 GeV breakpoints in `DecaytoGluons` and `DecaytoPions`.

1. Run the Julia; dump inputs and outputs to CSV.
2. Run the Python port on the same inputs.
3. Assert agreement to **relative 1e-12**.

Cover the full `BranchingRatiosgeneralquartic` output *and* the `masses1` / `masses2` arrays, element by element and **in order**. The cascade indexes into these by position, so an ordering difference is a silent correctness bug that comparing widths alone will not catch.

### 8.3 Tier 2 — the cascade, exact agreement via injected randomness

The cascade's only stochastic step is `rand(dist)` on a Categorical. Make the random stream injectable in both implementations:

1. Modify the Julia to read a pre-generated stream of uniforms from file instead of calling `rand()`.
2. Implement matching inverse-CDF sampling in Python (confirm Julia's `Categorical` uses inverse CDF on the normalized weight vector, and match the tie-breaking convention at bin edges).
3. Drive both with the identical uniform stream and a fixed input spectrum.
4. Assert the returned `Products` lists are **identical element by element**, for ≥ 10⁴ chains.

This converts a statistical comparison into an exact one and catches off-by-one indexing, ordering, and normalization errors that a KS test would miss.

### 8.4 Tier 3 — statistical backstop

With independent RNGs, compare over ≥ 10⁵ events: multiplicity distribution (KS test, plus mean and median stated explicitly), per-flavour fractions as a function of multiplicity, and total cross section. Report the numbers; do not just assert a p-value threshold.

### 8.5 Tier 4 — regression fixtures

Freeze the Tier 1–2 reference outputs as committed test fixtures. Record the Julia version and package versions used to generate them.

---

## 9. New code required

**`kinematics.py`.** For each decay a → bc, sample isotropically in the parent rest frame with

|p| = √((m_a² − (m_b+m_c)²)(m_a² − (m_b−m_c)²)) / (2m_a)

build the two four-vectors, boost to the lab frame using the parent's momentum, and recurse. The chain root takes its momentum from the production mode (Higgs with a realistic p_T spectrum, or direct ggF). Assert four-momentum conservation at every node and that invariant masses reconstruct the parent.

**`lhe.py`.** Emit the SM-level partons as an LHE record for Pythia to shower and hadronize. **Colour-connect locally:** each φ → qq̄ is a colour singlet, so colour flow belongs to that decay alone and must not be connected across the cascade. Getting this wrong produces spurious colour strings spanning the event and materially changes the hadronic activity.

**Lifetimes.** Sum all partial widths per scalar, convert to cτ, and report the distribution across the spectrum. Decide promptness per benchmark rather than assuming it — the sub-GeV tail of a broad spectrum can be displaced, which matters because L1 tracking is prompt.

**Constraint check.** Assert Σ BR(h → φφ) sits within the Higgs signal-strength bound (roughly ≲ 0.1 from μ = 1.03 ± 0.06) and print it for every benchmark.

---

## 10. Benchmarks to produce

| Point | Production | Config | Purpose |
|---|---|---|---|
| L-A | direct ggF | shipped driver parameters as-is | reproduces the authors' result; softest final state |
| L-B | h → φφ | `ProductionProbjustHiggsDecaytwomasses`, λ retuned | headline; higher energy per particle |
| L-C | h → φφ | as L-B with λ′/λ ≈ 10⁻⁶ | **negative control** |
| L-D | as L-B | 3–5 independent spectrum seeds | realization-to-realization systematic |

L-C is a free, built-in negative control: at λ′/λ ≲ 10⁻⁶ the scalars decay directly to the SM in two-body final states and existing searches are already sensitive. Same model, same code, one parameter changed, flipping from uncovered to covered. Do not skip it.

Downstream, every point goes through PU 200 overlay → Phase-2 L1 emulation, with **L1 menu decision bits retained per event**. The whole argument is "AD finds this, the menu does not," which has to be demonstrable event by event.

Default 100k events per point; more for L-B.

---

## 11. Deliverables

1. Python port with tests at all four tiers of §8.
2. `kinematics.py`, `lhe.py`, lifetime and constraint utilities.
3. Multiplicity and flavour-composition plots, Python vs Julia overlaid.
4. LHE files per benchmark, plus Pythia fragments.
5. Cross-section normalization and assumed BR(h → BSM) per point.
6. README per benchmark: parameters, spectrum seed, lifetime distribution, which trigger seeds it should fail, and any §7 flags set away from default.
7. A short written record of the §7 deviations with numerical impact quantified where measurable.

Match existing repo conventions for layout and naming; inspect the repo first and follow what is there rather than imposing this document's structure.

---

## 12. Suggested order

1. Tier 1 tests and `widths.py` / `branching.py` — get the deterministic core provably right first.
2. `cascade.py` with injectable RNG, then Tier 2. Do not proceed past this until element-by-element equality holds.
3. `kinematics.py` — the first genuinely new physics code.
4. `lhe.py` and a Pythia round-trip on a small sample; check colour flow by inspecting hadronic activity.
5. Benchmarks L-A and L-B, then L-C and L-D.