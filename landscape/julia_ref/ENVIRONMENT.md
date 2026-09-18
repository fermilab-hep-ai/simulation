# Reference environment for the landscape fixtures

The files in `fixtures/` are the Julia reference outputs that the Python port in
`landscape/` is validated against. They were produced on lxplus (RHEL 9.8,
kernel 5.14.0-687.26.1.el9_8) with:

| Component | Version |
|---|---|
| Julia | 1.10.3 (`/cvmfs/sft.cern.ch/lcg/releases/julia/1.10.3-46329/x86_64-el9-gcc11-opt`) |
| Distributions.jl | 0.25.130 |
| StatsBase.jl | 0.34.12 |
| Interpolations.jl | 0.16.3 |
| DelimitedFiles.jl | 1.9.1 |
| Python | 3.9.25 |
| numpy | 1.23.5 (used only by the vectorised branching path) |

Depot used: `/afs/cern.ch/work/o/oamram/public/.julia_depot` (outside this
repository — set `JULIA_DEPOT_PATH` to wherever you install the packages).

The Julia source being ported is `scalarattributesshare.jl`,
`ScalarProductionshare.jl` and `ScalarScanningshare.jl` at the repository root.
The dump scripts load them through `include_stripped()`, which blanks the
`using` / `Pkg.add` / `include(` lines so the unused heavy dependencies of the
originals (BAT, Neurthino, HDF5, ValueShapes, DensityInterface, QuadGK,
TypedTables) are not needed to reproduce the references. Nothing else in those
files is modified.

## Why the versions matter

Two things in the reference outputs are version sensitive:

* **`Distributions.Categorical`** — the port reproduces its sampling convention
  exactly (one uniform per draw, left-cumulative inverse CDF, 1-based). Tier 2
  drives both sides from the same uniform stream and so would catch a change in
  that convention, but only if the fixtures are regenerated.
* **`Interpolations.Gridded(Linear())` with `Line()` extrapolation** — used for
  the direct production cross section grid. `numpy.interp` clamps outside the
  grid instead of extrapolating, so `production._interp_linear_extrap` matches
  the Julia behaviour by hand.

Floating-point results are otherwise reproduced to ~1e-16 relative, i.e. to
double-precision rounding, so a patch-level bump in any of these packages is
not expected to move the fixtures.

## Regenerating

```bash
export JULIA_DEPOT_PATH=/path/to/depot
J=/cvmfs/sft.cern.ch/lcg/releases/julia/1.10.3-46329/x86_64-el9-gcc11-opt/bin/julia
$J landscape/julia_ref/dump_tier1.jl landscape/julia_ref/fixtures
$J landscape/julia_ref/dump_tier2.jl landscape/julia_ref/fixtures 10000
$J landscape/julia_ref/dump_tier3.jl landscape/julia_ref/fixtures 100000
python3 -m unittest discover -s landscape/tests -t . -v
sha256sum -c landscape/julia_ref/fixtures/MANIFEST.sha256
```

All three dumps use fixed seeds, recorded in the scripts and echoed into the
`*_meta.csv` / `*_summary.csv` outputs, so a rerun in the same environment
reproduces the fixtures byte for byte.

`dump_tier3.jl` also writes `tier3_events.csv` (~5 MB, one row per event). That
file is deliberately not committed; the committed `tier3_summary.csv` is the
multiplicity histogram plus flavour totals, which is a sufficient statistic for
both the KS comparison and the flavour fractions.
