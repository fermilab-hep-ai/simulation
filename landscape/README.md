# AIDA-Scout S1b — landscape scalar cascades

Signal generation for the landscape model of R. T. D'Agnolo, M. Ettengruber and
L.-T. Wang, *Landscapes at Colliders* ([arXiv:2512.18001]). Specification:
[`instructions_landscape_signal.md`](../instructions_landscape_signal.md) at the
repository root.

N ~ 200 light singlet scalars mix with the Higgs (coupling λ, mixing angle θ)
and couple to one another through a quartic λ′. When λ′ is not tiny a scalar
prefers to decay into two lighter scalars rather than into the Standard Model,
so a single production seeds a **cascade** that only terminates when it reaches
scalars too light to split again. Those terminal scalars decay through their
Higgs admixture, giving SM-Higgs-like branching ratios at a few GeV.

**Why it is an anomaly-detection target.** A Higgs-initiated cascade puts a
median of **12 partons at a median 12 GeV each** into the event, sharing 125 GeV.
Measured through the full chain, that gives HT = 121 GeV and a leading jet of
67 GeV against Phase-2 L1 floors of PuppiHT 450 and SinglePuppiJet 230 — missed
in ~97% of events. The signal also spreads across many final states, each with a
tiny branching ratio, so no single channel is targetable by a cut-based search.

**Unlike the rest of the campaign, this is not a card-writing task.** The
authors shipped Julia, not a MadGraph model, and that Julia tracks *masses only*
— no four-vectors, no lifetimes, no LHE, no cross-section normalisation check.
So this directory is a verified Python port of the model plus the physics it was
missing, ending in an LHE that Pythia reads.

### Start here

| I want to… | Go to |
|---|---|
| know what the benchmark points are | [The benchmarks](#the-benchmarks) |
| generate one LHE by hand | [Making a sample](#making-a-sample) |
| run a point through PU 200 + Delphes | [PU 200 and Delphes](#pu-200-and-delphes) |
| trust the port | [Verification against the Julia](#verification-against-the-julia) |
| know where the port departs from the Julia | [Deliberate deviations](#deliberate-deviations-from-the-julia) |
| know what is *not* done | [Not yet implemented](#not-yet-implemented) |

Seven process directories are generated from here, all on the `pythia` branch of
`run.sh` with an LHE pre-step: `processes/landscape_LA_direct`,
`landscape_LB_higgs`, `landscape_LB_higgs_displaced`, `landscape_LC_control`,
`landscape_LD_spectrum{1,2,3}`. Each carries its own README with parameters,
lifetimes, measured numbers and the seeds it should and should not fire.

[arXiv:2512.18001]: https://arxiv.org/abs/2512.18001

### Layout

Ported from `scalarattributesshare.jl`, `ScalarProductionshare.jl` and
`ScalarScanningshare.jl` at the repository root.

| Module | Contents |
|---|---|
| `params.py` | `SMConstants`, `ModelParams`, the two Higgs cross sections, the direct-production grid, benchmark points |
| `widths.py` | Partial widths: scalar→scalar pairs (general quartic), fermions, WW, ZZ, photons, pions, gluons |
| `branching.py` | Ordered branching-ratio vector, total width, cτ |
| `production.py` | Higgs-portal and direct production probabilities and cross sections |
| `cascade.py` | The decay chain, flat and tree-valued, with an injectable uniform stream |
| `kinematics.py` | Four-vectors, sequential isotropic two-body decay, validation |
| `lifetimes.py` | Total widths → cτ, proper-time sampling, lab-frame decay vertices |
| `hardprocess.py` | gg → X initial state: gluon-luminosity rapidity sampling, x₁/x₂ |
| `lhe.py` | Les Houches output, colour flow, the Pythia settings fragment |
| `generate.py` | The event loop tying all of the above together |
| `make_lhe.py` | Command-line entry point, one benchmark per invocation |
| `retune.py` | Solving for λ against the Higgs signal-strength bound, and proving what it does and does not move |
| `make_processes.py` | Writes the `processes/landscape_*` directories that `run.sh` consumes |
| `measured.py` | Measured numbers quoted in the per-point READMEs, kept apart from the generator |
| `analyse_lhe.py` | Parton-level summary of a written LHE, read back independently |
| `pythia/roundtrip.cc` | Standalone diagnostic: shower an LHE and report what survived |
| `pythia/analyse.cc` | Benchmark analysis: anti-kT jets, HT, L1 seed rates, displacement |

## Making a sample

```bash
apptainer exec --bind $simdir \
  /cvmfs/unpacked.cern.ch/registry.hub.docker.com/jmduarte/mapyde:latest \
  python3 -m landscape.make_lhe --benchmark L-A --nevents 10000 \
      --out LA.lhe --fragment LA.cmnd
```

Run it inside the container: `hardprocess.GluonLuminosity` needs LHAPDF.
`--approx-pdf` drops that requirement but substitutes an analytic gluon shape
that is only qualitatively right, and stamps that fact into the file header so
a sample made with it can always be identified afterwards. There is no silent
fallback.

The hard process is 2 → 1, so the root has **zero pT in the LHE and its
longitudinal boost comes entirely from x₁/x₂**. That is the correct convention,
not a simplification: the resonance's real pT is initial-state radiation, and
Pythia generates it when it showers. Writing a hand-rolled pT spectrum into the
LHE would double count.

The cascade comes in two forms. `decay_chain_general_quartic` returns the flat
list of masses the Julia returns, which is what the paper's plots need;
`decay_tree_general_quartic` walks the identical loop and draws from the stream
in the identical order but keeps the parent/child structure, which is what
kinematics needs — you cannot boost a daughter without its parent. Tier 5
asserts the two agree product for product and uniform for uniform, so the tree
inherits everything Tiers 1–3 established.

Kinematics and lifetimes each draw from their **own** `UniformStream`, separate
from the cascade's. Sharing one would make the Tier 2 replay depend on how many
angles were drawn; keeping them apart also lets a sample be re-generated with
different angles but an identical decay topology.

## Running

```bash
cd <repo root>
python3 -m unittest discover -s landscape/tests -t . -v
```

Pure standard library except for `branching_ratios_general_quartic_fast`, which
uses numpy.

## Verification against the Julia

The port is checked at eight tiers, **64 tests**. Tiers 1-4 compare against the
Julia; tiers 5-8 cover code and parameter choices that have no Julia
counterpart. Reference outputs live in `julia_ref/fixtures/`, generated by the
`julia_ref/dump_tier*.jl` scripts; see `julia_ref/ENVIRONMENT.md` for versions
and how to regenerate.

Each tier asks a weaker question than the one before, and the sequence is forced
by what is knowable: exact agreement where a reference exists, physics
invariants where it does not, and invariance arguments for the parameter choices
we made ourselves.

**Tier 1 — exact numerics.** Every width and branching ratio at fixed inputs,
compared entry by entry *in the Julia's channel order* (the cascade indexes the
branching vector positionally, so the ordering is part of the interface, not a
presentation detail).

* widths: 94 mass points, worst relative deviation **4.2e-16**
* branching: 10 mass points, 829 channel entries in order
* pair width: 216 combinations (77 below threshold)
* production: 12 scalars; Higgs pairs: 144 pairs, ΣBR(h→BSM) = 2.751e-07

**Tier 2 — exact cascade.** Both implementations are driven by the *same*
pre-generated stream of uniforms, so the chains must agree structurally, not
just statistically. This is what pins down the `Distributions.Categorical`
convention (one uniform per draw, left-cumulative inverse CDF) and the
photon/gluon split.

* 10000 chains identical element by element, 45272 products, 40490 uniforms
  consumed in lockstep

**Tier 3 — statistical backstop.** Independent RNGs on both sides, 10⁵ events at
the shipped benchmark (N = 200), to catch anything the fixed stream could have
masked.

* multiplicity: python mean 4.056 vs julia 4.048, both median 4, max 12;
  KS statistic 0.00238 (p = 0.94), PMF χ²/ndf = 4.84/6
* flavour fractions agree to **≤ 0.001** absolute
* production probabilities: worst relative deviation 3.5e-16
* total cross section: 1.218214e-08 b on both sides (rel dev 1.4e-16)

**Tier 4 — regression lock.** `MANIFEST.sha256` pins the fixtures, and the test
also fails if a new fixture is added without being listed, so the earlier tiers
cannot quietly start comparing against a different reference.

**Tier 5 — kinematics.** No Julia counterpart exists (the model tracks masses
only), so this is checked against physics invariants instead.

* tree and flat cascades identical over 2000 chains, same uniforms consumed
* four-momentum conservation: worst residual **3.8e-12 GeV** with the root at
  rest, **3.9e-9 GeV** with the root at pT = 60 GeV
* on-shell closure |Δm²|/E² ≤ **1.1e-13**
* isotropy: cos θ* χ²/ndf = 0.77, φ χ²/ndf = 0.65 over 2×10⁵ decays

**Tier 6 — lifetimes and vertices.** cτ = ħc/Γ from the Tier 1 widths;
exponential proper-time draws (mean 2.498 mm against cτ = 2.5, σ = 0.006);
vertices displaced along the parent momentum by exactly βγτ.

**Tier 7 — the LHE record.** Colour flow and the displaced vertices are the two
things that would silently change the physics, so both are asserted directly:

* every colour tag used exactly twice, once as colour and once as anticolour
* **639 colour lines checked, none spanning different decays** — each φ → qq̄ is
  its own singlet and each φ → gg its own closed loop, so no string runs across
  the cascade
* intermediate scalars carry VTIMUP, final-state particles do not
* π± (isospin factor 2) to π⁰ ratio 130:68 = 1.91, against the expected 2
* momentum residual 8.4e-8 GeV; write/read round trip through the file format

**Tier 8 — the λ retuning.** L-B is generated at a λ we chose, not the shipped
one, so this tier defends the choice rather than the arithmetic: that raising λ
by 27× changes the rate and the lifetimes and *nothing else*. See
[Retuning λ](#retuning-λ).

* the closed form inverts exactly in both BR conventions
* tuning the Julia's own BR to the bound overshoots physically (0.166 > 0.1)
* the hidden-sector fraction of every scalar's width moves by at most **5.0e-5**
* 400 cascades on the same uniform stream come out element-for-element identical
* cτ below the hidden-pair threshold scales as λ⁻², to 1e-9

**Pythia round trip** (`pythia/roundtrip.cc`, 300 events each): 300/300 showered
for both L-A and L-B, no colour or mass complaints.

The A/B that proves the lifetimes survive: with `LesHouches:setLifetime = 1`
(the default) the hidden-scalar decay vertices reach 3.6 mm at the 90th
percentile and 232 mm at most; set it to 2 and **every one collapses to exactly
zero**. That setting is in the generated fragment, and it is the single point of
failure that would silently make the whole sample prompt.

### What the numbers mean

Tiers 1 and 2 are exact agreement — deviations at 1e-16 are double-precision
rounding, not physics. Tier 3 is a statistics test and is expected to fluctuate;
the pulls above are all within ±1.5. In Tier 5, note that a *relative* test on a
reconstructed mass is the wrong figure of merit: m² = E² − |p|² is a difference
of nearly equal numbers, so a strange quark at γ ≈ 2000 shows ~1e-9 and a photon
shows a meaningless number, both purely from cancellation. `max_mass2_closure`
normalises to E², which has a real floor; `max_momentum_violation` is the test
that would actually catch a wrong boost.

## Deliberate deviations from the Julia

Each is a flag on `ModelParams`, defaulting to the Julia's behaviour so the
verification above is meaningful. Turning one on is a physics choice, and the
port will then no longer match the fixtures.

| Flag | Default | Effect |
|---|---|---|
| `photon_gluon_split` | `"code"` | The authors' `BR[l-1]/BR[l]` conditional split. `"standard"` uses `BR[l-1]/(BR[l-1]+BR[l])`. |
| `zz_uses_mW` | `True` | The ZZ kinematic factor uses m_W as written in the Julia. Only matters above 2m_Z ≈ 182 GeV. |
| `mixing_mass_dependent` | `False` | Mixing denominator m_h² (the m_φ ≪ m_h limit) rather than \|m_h² − m_φ²\|. |
| `spectrum_per_event` | `False` | The driver redraws the spectrum every event, marginalising over landscape realisations. Default here is one fixed realisation per sample — we live in one vacuum, and marginalising smears the structure an anomaly detector keys on. **Declared but not implemented**: `Generator` raises rather than silently producing a fixed-spectrum sample. See [Not yet implemented](#not-yet-implemented). |

Two further points worth knowing:

* **Two Higgs cross sections** appear in the Julia — `ProductionProb` uses
  21.39e-12 b, `Crosssections` and the Higgs-decay variants use 48.51e-12 b.
  Both are exposed as named constants (`SIGMA_H_PRODUCTIONPROB`,
  `SIGMA_H_CROSSSECTIONS`) rather than inlined, so every call path reports which
  one it used.
* **The direct-production grid is extrapolated, not clamped.** Julia's
  `Gridded(Linear())` with `Line()` extrapolation continues the end slope
  outside the grid; `numpy.interp` would hold the endpoint value instead. That
  is why `production._interp_linear_extrap` exists.

## The shipped benchmark is not prompt

The Julia never computes a total width, so nothing in it outputs a cτ. Summing
the partial widths shows the spectrum splits sharply at the hidden-pair
threshold 2·min(spectrum) = 1.549 GeV:

| Population | Count | Median cτ |
|---|---|---|
| above threshold (φ → φφ open) | 182 | 4.2e-11 mm |
| below threshold (Higgs mixing only) | 18 (9%) | 2.7 mm |

The split is twelve orders of magnitude, because below threshold the only
channels left are suppressed by θ² ≈ 1e-6. And **every cascade terminates on a
sub-threshold scalar** — that is what ends the chain — so the light population
is enormously over-represented among the decays that actually produce visible
particles. Measured over 2×10⁴ events at N = 200 with the root transversely at
rest:

* **74% of visible particles come from a vertex displaced by more than 100 μm**
* median r_xy = 0.40 mm, 29% beyond 1 mm, 95th percentile 4.2 mm

That is a lower bound: with realistic production pT the boost, and so the
displacement, is larger. It matters because Phase-2 L1 tracking is prompt, so
this is a property of the signal to carry downstream, not a detail — and it
means the LHE has to carry the scalars themselves so Pythia can place the
displaced vertices, rather than emitting a flat list of partons.

The sub-threshold cτ is **independent of λ′** (those scalars have no hidden
channel open, so their width is pure mixing, ∝ λ²) but scales as **λ⁻²**. Both
facts matter downstream:

* switching λ′ off, as the negative control L-C does, closes the hidden channel
  for *every* scalar, so the heavy ones become long-lived too rather than the
  light ones becoming short-lived;
* raising λ, as the L-B retuning does, shortens **every** scalar's lifetime,
  which is what turns L-B prompt and what makes L-C a genuinely prompt control.

Both are worked through under "Retuning λ" below.

## Retuning λ

The shipped λ = 1e-4 puts BR(h → BSM) at 7.6e-5 and σ × BR at 3.7e-3 pb — three
orders of magnitude below the Higgs signal-strength bound, so the Higgs channel
is invisible at the shipped point. §10 of the specification asks for L-B with
λ retuned.
`retune.py` does it in closed form, because Γ(h → φφ) ∝ λ² and nothing else in
the production chain depends on λ.

**Two BR conventions, differing by a factor 2.** The Julia normalises to
Γ_bb(pole) × 1.89 = 8.13e-3 GeV where the true SM Higgs width is 4.1e-3
(deviation 7d). Tuning *its* number to 0.1 lands at a physical BR of **0.166** —
over the bound. `lambda_for_br` therefore defaults to the physical convention,
and `make_lhe.py` applies the constraint check to the physical number.

**λ = 2.7e-3** gives physical BR(h → BSM) = 0.0994 and σ × BR = **2.70 pb**, a
factor 729 above the shipped point.

### What the retuning moves, and what it does not

λ′ is deliberately **not** scaled with λ. Every hidden-sector width carries λ′²
and every SM width carries θ² ∝ λ², so raising λ alone reweights hidden against
SM. But the hidden channels already hold at least 1 − 6.9e-8 of every
above-threshold scalar's width at the shipped point, and 729× in λ² leaves them
at 1 − 5.0e-5:

| | shipped λ = 1e-4 | retuned λ = 2.7e-3 |
|---|---|---|
| max change in hidden fraction over the 200 scalars | — | **5.0e-5** |
| parton multiplicity, mean (2000 events) | 12.39 | 12.38 |
| flavour composition | π± 38%, s 19%, g 18%, π⁰ 18%, μ 8% | π± 38%, s 18%, g 18%, π⁰ 18%, μ 8% |
| charged multiplicity after showering, median | 113 | 113 |
| HT, median | 119 GeV | 121 GeV |
| **median sub-threshold cτ** | **2.7 mm** | **3.7 µm** |
| **signal charged displaced > 0.1 mm** | **99.4%** | **17.8%** |
| σ × BR | 3.7e-3 pb | 2.70 pb |

Cascades driven by the same uniform stream come out element-for-element
identical between the two, so this is not a statistical statement. The cascade
is invariant; the **lifetime is not**, because below the hidden-pair threshold a
scalar's width is pure mixing and cτ ∝ λ⁻².

So the retuned point is prompt where the shipped one is displaced. That is a
real change in signature, not a weaker version of the same sample, which is why
both are kept: **`L-B` (retuned, prompt) and `L-B-displaced` (shipped λ)**.
They agree on every other measured quantity, which makes the pair an unusually
clean handle on "what does displacement alone change".

Tier 8 (`tests/test_tier8_retune.py`, 16 tests) asserts all of this: the
closed form inverts exactly in both conventions, tuning the Julia's BR to the
bound overshoots physically, the hidden fraction is invariant, 400 cascades are
identical, and cτ scales as λ⁻².

## A cross-section term that does not have units of a cross section

`ProductionProb` and `Crosssections` add three terms
(`ScalarProductionshare.jl` lines 66–81 and 143–153). Two are cross sections in
barns. The third, `1e-3 * bmesondecay` with
`bmesondecay = θ² · pms · F / m_B`, is a dimensionless branching-ratio-like
quantity added straight to them. At the shipped point:

| term | contribution |
|---|---|
| h → φφ | 3.70e-3 pb |
| direct ggF | 2.92 pb |
| **B meson** | **1.12e4 pb** |

A factor 3800 over genuine direct production, and because it is nonzero only
below 4.7 GeV it also skews *which* scalar L-A produces, not just the
normalisation. It is reproduced as written, because it is what defines the
authors' L-A sample; `--no-bmeson-term` drops it, and every LHE header carries
the three-term breakdown so the number is never read at face value. **Affects
L-A only** — the Higgs benchmarks use `CrosssectionsjustHiggsDecay`, which has
no such term.

## The benchmarks

| Point | Process directory | Production | λ | λ′ | Spectrum seed | σ × BR |
|---|---|---|---|---|---|---|
| L-A | `landscape_LA_direct` | direct ggF | 1e-4 | 1e-4 | 424242 | 1.12e4 pb¹ |
| **L-B** | `landscape_LB_higgs` | h → φφ | 2.7e-3 | 1e-4 | 424242 | 2.70 pb |
| **L-B-displaced** | `landscape_LB_higgs_displaced` | h → φφ | 1e-4 | 1e-4 | 424242 | 3.70e-3 pb |
| L-C | `landscape_LC_control` | h → φφ | 2.7e-3 | 2.7e-9 | 424242 | 2.70 pb |
| L-D1/2/3 | `landscape_LD_spectrum{1,2,3}` | h → φφ | 2.7e-3 | 1e-4 | 515151 / 606060 / 717171 | 2.70 pb |

¹ dominated by the B-meson term above; 2.92 pb without it.

L-C is pinned to the **ratio** λ′/λ = 1e-6 rather than to an absolute λ′, so it
tracks the retuning. It now shares L-B's production, coupling and cross section
exactly, with one parameter separating uncovered from covered.

Generated at 2000 events each, N = 200. Numbers below are truth-level Pythia
with **no pileup and no detector**, so they are an upper bound on what any
trigger could see; the same points at PU 200 go through `run.sh` (below).

```bash
python3 -m landscape.make_lhe --benchmark L-B --nevents 2000 --fast-branching \
    --out landscape/samples/LB.lhe --fragment landscape/samples/LB.cmnd
python3 -m landscape.analyse_lhe landscape/samples/LB.lhe        # parton level
PYTHIA8DATA=/usr/local/share/Pythia8/xmldoc \
    ./landscape/samples/analyse landscape/samples/LB.run.cmnd LB # showered
```

`landscape/samples/` is gitignored; regenerate rather than committing LHEs.
`PYTHIA8DATA` must be pinned to the container's copy — an inherited value from
a local MG5 install aborts Pythia at init with a version mismatch.

### Parton level — this is where the paper's figures are

| | L-A | **L-B** | L-B-displaced | L-C |
|---|---|---|---|---|
| multiplicity, mean / median | 4.01 / 4 | **12.38 / 12** | 12.39 / 12 | 4.00 / 4 |
| parton energy, median | 8.1 GeV | **12.4 GeV** | 12.3 GeV | 47.8 GeV |
| Σp reconstructs | 2.57 GeV (root mass) | **125.1100** | **125.1100** | **125.1100** |
| spread on that | 7.5 GeV² | 2.6e-6 GeV | 2.9e-6 GeV | 4.0e-6 GeV |
| flavour | π± 38%, s 19%, g 18%, π⁰ 18%, μ 7% | π± 38%, s 18%, g 18%, π⁰ 18%, μ 8% | π± 38%, s 19%, π⁰ 18%, g 18%, μ 8% | **c 54%, τ 18%, g 14%, s 5%, b 4%** |
| parton r_xy, median | 0.41 mm | 0.02 mm | **13.3 mm** | 0.00 mm |
| displaced > 0.1 mm | 74.2% | 10.9% | **99.1%** | 5.3% |

**L-B reproduces the paper's headline directly**: median 12 partons at a median
12 GeV each, sharing 125 GeV. That was not tuned for — it falls out of the
ported widths and branching ratios.

The invariant mass of all final partons is **125.1100 GeV with a spread of
2.6e-6 GeV over 2000 events**, and the net pT is below 1.1e-8 GeV. That single
number closes the whole chain at once: cascade → four-vectors → recursive
boosts → LHE formatting and back out through an independent reader.

### Showered, with jets

anti-kT R = 0.4, jets pT > 30 GeV and |η| < 2.4; charged particles |η| < 4,
pT > 0.1 GeV.

| | L-A | **L-B** | L-B-displaced | L-C |
|---|---|---|---|---|
| charged multiplicity, median | 33 | 113 | 113 | 113 |
| of which from the hard process | 2 | 4 | 4 | 2 |
| signal charged Σp_T, median | 1.2 GeV | 31.3 GeV | 31.3 GeV | 18.8 GeV |
| whole-event Σp_T, median | 32.5 GeV | 265.5 GeV | 264.7 GeV | 258.6 GeV |
| jets above 30 GeV, median | 0 | 2 | 2 | 2 |
| HT, median | 0 GeV | 121 GeV | 119 GeV | 108 GeV |
| leading jet pT, median | 0 GeV | 67 GeV | 65 GeV | 62 GeV |
| **hidden-scalar decay r_xy, median / 90% / max** | 0.00 / 3.8 / 38 mm | **0.00 / 0.08 / 0.40 mm** | **2.6 / 60 / 266 mm** | 0.00 / 0.04 / 0.43 mm |
| signal charged displaced > 0.1 mm | 96.4% | 17.8% | **99.4%** | 80.5% |
| same, underlying event | 10.0% | 10.7% | 14.2% | 12.1% |

**Phase-2 L1 floors, truth level, no pileup:**

| | L-A | **L-B** | L-B-displaced | L-C |
|---|---|---|---|---|
| HT > 450 | 0.10% | 2.70% | 2.90% | 2.25% |
| any jet > 230 | 0.15% | 2.15% | 2.35% | 1.65% |
| HT > 300 | 0.15% | 7.35% | 8.25% | 6.35% |
| any jet > 30 at all | 3.2% | 91.4% | 91.4% | 88.0% |
| **DoubleTkMuon 4,4**² | **0.0%** | **18.6%** | **19.9%** | 3.3% |
| DoubleTkMuon 2,2, \|η\| < 1.5² | 0.0% | 15.5% | 15.8% | 1.9% |
| DoubleTkElectron 25,12² | 0.0% | 0.0% | 0.0% | 0.0% |

² parton level, from the LHE, before showering — the muons come straight from
φ → μμ so their parton pT is essentially final. The BPH seed's opposite-sign,
dR and dz requirements are **not** applied and no L1 muon efficiency is folded
in, so these are upper bounds.

**The muon seed is live for L-B, and this is the one place the "untriggerable"
claim needs qualifying.** φ → μμ carries ~8% of the terminal decays, and two
muons above 4 GeV appear in 19% of events. L-B is untriggerable *hadronically* —
which is the claim the analysis rests on — but not across the whole menu.

The 2.7% of L-B events that do pass PuppiHT 450 pass on **initial-state
radiation, not on signal**: the cascade contributes ~31 GeV of charged pT
against a whole-event 265 GeV. That rate is essentially the rate for any 125 GeV
gluon-fusion event.

L-A does not merely fail the seeds — **only 3.2% of its events contain a single
30 GeV jet**. There is nothing in the event to trigger on at all.

### L-B versus L-B-displaced: a controlled pair

Read the two middle columns of every table above. They agree on parton
multiplicity (12.38 vs 12.39), flavour, charged multiplicity (113 vs 113), HT
(121 vs 119 GeV), leading jet pT (67 vs 65 GeV) and every hadronic L1 rate to
within half a point. The hidden-scalar decay vertices differ by **four orders
of magnitude** — median 0.00 vs 2.6 mm, maximum 0.40 vs 266 mm — and the
displaced signal-charged fraction by 17.8% vs 99.4%.

Nothing else in the repository isolates displacement this cleanly, because
nothing else can change a lifetime by 729× without touching a branching ratio.

### L-C as a control — the earlier caveat is resolved

At the shipped λ, L-C was **not** prompt: with λ′ switched off the hidden
channel closes for every scalar, so all of them decayed through θ²-suppressed
mixing at millimetre lifetimes, and "already covered by prompt searches" needed
qualifying. The retuning fixed that as a side effect. L-C now tracks L-B's λ, so
its scalars decay at a median r_xy of **0.00 mm with a maximum of 0.43 mm** —
prompt where it claims to be.

80% of its *charged* particles still come from beyond 100 μm, but that is
ordinary charm and τ lifetime (c is 54% of its final state), not the model.
Prompt h → aa → 4c searches are built for exactly that.

What remains true is that **at jet level L-C and L-B are nearly identical** —
HT 108 vs 121 GeV, leading jet 62 vs 67, charged multiplicity the same. The
control separates from the signal in flavour, multiplicity and substructure,
not in trigger-level energy flow. It is a control for what the anomaly detector
keys on, not for what the menu sees.

### L-D — realisation-to-realisation systematic

Three independent spectrum seeds, 2000 events each, otherwise identical to L-B:

| | L-B (424242) | L-D1 (515151) | L-D2 (606060) | L-D3 (717171) |
|---|---|---|---|---|
| parton multiplicity, mean | 12.38 | 11.72 | 11.68 | 12.04 |
| parton energy, median | 12.4 GeV | 12.8 GeV | 12.9 GeV | 12.5 GeV |
| gluon fraction | 18.0% | **23.8%** | 18.4% | 17.5% |
| π± fraction | 38.0% | **30.0%** | 38.9% | 37.2% |
| charged multiplicity, median | 113 | 113 | 113 | 113 |
| HT, median | 121 GeV | 122 GeV | 121 GeV | 120 GeV |
| leading jet pT, median | 67 GeV | 66 GeV | 66 GeV | 66 GeV |
| HT > 450 | 2.70% | 3.20% | 2.80% | 2.95% |
| any jet > 30 | 91.4% | 90.6% | 90.6% | 90.5% |
| Σp closure | 125.1100 | 125.1100 | 125.1100 | 125.1100 |

Bulk energy flow is stable to a few percent, so the trigger conclusions do not
depend on which vacuum you draw. What moves is **multiplicity (~6%) and flavour
composition (~30% relative on the gluon fraction)** — precisely the quantities
an anomaly detector keys on.

This is the argument for the fixed-spectrum default (deviation 7g): the driver
redraws the spectrum every event, which averages these four columns together
and washes out the structure.

## PU 200 and Delphes

The landscape points run through the **existing** chain — `run.sh`, the same
`cards/delphes_card.dat`, the same on-the-fly PU 200 — with one step added in
front:

```
landscape.make_lhe ── LHE ── main_signal.cc ── HepMC ── DelphesHepMC2 ── parquet
                                                  └─ PU 200 overlay, PUPPI
```

`landscape/make_processes.py` writes seven process directories under
`processes/`, each with a `*_pythia_card.dat` (`Beams:frameType = 4`,
`Beams:LHEF = _LHEFILE_`) and a `*_lhe_args.dat`. The presence of the latter is
what makes `run.sh` do the LHE pre-step; everything downstream is the existing
pythia branch untouched, so these samples are directly comparable with the rest
of the campaign.

```bash
python3 -m landscape.make_processes        # regenerate the process directories

apptainer exec --bind $simdir \
  /cvmfs/unpacked.cern.ch/registry.hub.docker.com/jmduarte/mapyde:latest \
  sh $simdir/run.sh landscape_LB_higgs 10000 101 $simdir False
```

Three things about the job:

* **The spectrum seed does not come from the job seed.** A landscape sample is
  one vacuum realisation, so every parallel job of a point must share one
  spectrum; that seed is part of the benchmark definition in `params.py`. The
  job seed varies the events within the realisation. L-D varies the
  realisation, and does it by being separate benchmarks.
* **`outdir/parton_level.txt`** is written before showering. It is the only
  place the cascade multiplicity and the decay displacement are visible before
  PU 200 buries them.
* **`outdir/cross_section.txt`** comes back through Pythia from the LHE's
  `XSECUP`, so it is the number `make_lhe` computed. Verified: 2.699 pb for
  L-B, matching `cross_sections_higgs_only` exactly.

Validated end to end on `landscape_LA_direct`, `landscape_LB_higgs` and
`landscape_LB_higgs_displaced`, 30 events each at PU 200: LHE → Pythia → HepMC
→ Delphes → ~6.5 MB parquet with 263 columns, ~30 s of Pythia + Delphes per
point, all three exiting 0.

**The truth-level trigger conclusions survive pileup.** `L1T_JetPuppiAK4`, 30
events each:

| | L-A | L-B | L-B-displaced |
|---|---|---|---|
| HT over jets > 30 GeV, median | **0 GeV** | 77 GeV | 89 GeV |
| leading L1T PUPPI jet, median | **0 GeV** | 51 GeV | 55 GeV |
| events over PuppiHT 450 | 0/30 | 1/30 | 0/30 |
| events over SinglePuppiJet 230 | 0/30 | 1/30 | 0/30 |

L-A has a median L1T PUPPI HT of **zero with 200 pileup vertices in the event** —
PUPPI removes the pileup and there is nothing underneath it. That is a stronger
statement than the truth-level one.

Note L-A's `outdir/cross_section.txt` reads 1.125e4 pb: that is the B-meson term
above, propagated faithfully. Use 2.92 pb, or regenerate with
`--no-bmeson-term`, if you want the genuine direct-production rate.

### The displacement survives into Delphes

This is the check the whole `VTIMUP` / `LesHouches:setLifetime` chain exists
for: does a proper decay length written into the LHE actually come out the other
end as an impact parameter? Comparing the prompt and displaced points, both at
PU 200, on `L1T_PUPPIPart_D0`:

| L1T PUPPI charged candidates | L-B (prompt) | L-B-displaced |
|---|---|---|
| per event, pT > 2 GeV | 48.0 | 47.3 |
| of those, \|d0\| > 1 mm | 0.30 (0.6%) | **1.47 (3.1%)** |
| per event, pT > 5 GeV | 7.6 | 7.5 |
| of those, \|d0\| > 1 mm | 0.17 (2.2%) | **0.83 (11.2%)** |

A 5× enhancement in displaced L1 tracks that survives 200 pileup vertices. The
candidate lists are otherwise the same size, as they must be — the two points
differ only in λ.

The dilution is worth seeing: at truth level 99.4% of the *signal's* charged
particles are displaced, but the signal contributes a handful of candidates
against ~1000 from pileup, so the whole-event displaced fraction is 3%, not
99%. Any analysis using displacement here has to work per-track, not per-event.

**But see the d0 caveat under "Not yet implemented".** Delphes' L1T tracking
efficiencies have no d0 dependence, so this chain shows the displaced tracks
being *reconstructed* — the real L1 would lose most of them. The comparison
above is an upper bound on how much displacement survives to L1, not a
prediction.

## Not yet implemented

* **L1 menu decision bits per event**, which the spec asks for and which the
  repo has no CMSSW emulator to produce. The Delphes card gives L1T objects
  (`L1T_JetPuppiAK4_*`, `L1T_ScalarHT_HT`, `L1T_Muon*`, `L1T_PUPPIPart_*`) from
  which the seeds above can be computed offline, and each point's README lists
  which it should and should not fire.
* **Production-scale samples.** Cards, process directories and the full chain
  are in place and validated at 30 events; the 100k-per-point runs have not been
  launched.
* **A d0-dependent L1 tracking efficiency.** `cards/delphes_card.dat` has none —
  `L1TChargedHadronTrackingEfficiency` and friends are functions of pT and η
  only. `landscape_LB_higgs_displaced` and `landscape_LA_direct` will therefore
  have their L1 survival **overestimated** by this chain, and the ~20% muon-seed
  rate quoted for the displaced point is the number most affected.
* **The marginalised spectrum mode** (deviation 7g), which the specification
  wants for reproducing the paper's own figures. `ModelParams.spectrum_per_event`
  exists as a flag but nothing reads it; `Generator` raises `NotImplementedError`
  rather than quietly handing back a fixed-spectrum sample. L-D covers the
  physics question it was for — how much the answer moves between realisations —
  by measuring the spread instead of averaging it away.
* **The pairing variant of the hidden-sector decay.**
  `widths.width_scalar_to_scalar_pairing` is ported, but the branching-ratio
  assembly and cascade around it are not, and it has no Tier 1 fixture. The
  paper's results and the driver both use the general quartic (they differ by
  24N² ≈ 10⁶ at N = 200), so this is a different model variant rather than an
  option on ours — specification §2.
