#!/usr/bin/env python3
"""
Check the parquet file run.sh writes, for the CI pipeline test.

    python3 check_parquet.py outdir/event.parquet --max-events N

Exits 1 unless the file
  * holds between 1 and N events (MLM-matched samples lose some to the veto),
  * has the full-reco, L1T, generator and vertex columns the converter writes,
  * has PUPPI candidates in both views and the PU 200 vertices in every event,
    which is what goes missing when the pile-up overlay silently fails,
  * has generator masses in GeV: finite, and the known masses of stable
    particles.
"""

import argparse
import sys

import numpy as np
import pyarrow.compute as pc
import pyarrow.parquet as pq

# One column per collection family that process_root_parquet.py writes.  A
# column disappears when its Delphes branch is renamed or no longer read.
REQUIRED_COLUMNS = [
    "FullReco_PUPPIPart_PT",
    "FullReco_JetAK4_PT",
    "FullReco_MET_MET",
    "L1T_PUPPIPart_PT",
    "L1T_JetAK4_PT",
    "L1T_MET_MET",
    "Gen_Part_PT",
    "Vertex_Z",
    "L1T_PV_FastHistoZ",
    "L1T_PV_TruthZ",
    "L1T_PV_TruthIndex",
]

# Per-event values (not lists) that every event must have: the L1 vertex
# finder always reports one primary vertex.
NO_NULLS = ["L1T_PV_FastHistoZ", "L1T_PV_TruthZ", "L1T_PV_TruthIndex"]

# Per-event minimum number of entries.  PileUpMerger overlays Poisson(200)
# interactions, each written as a Vertex, so far fewer than 200 vertices means
# the overlay did not happen.
MIN_PER_EVENT = {
    "FullReco_PUPPIPart_PT": 1,
    "L1T_PUPPIPart_PT": 1,
    "Vertex_Z": 100,
}

# Generator masses in GeV of stable particles, by |PID|.  Delphes leaves the
# hard-scatter masses in MeV, the unit of the HepMC file, and
# process_root_parquet.py converts them.  Every event has protons, the beams
# if nothing else, so the check always has something to look at; the others
# are checked when the sample has them.  The tolerance allows for the float16
# the masses are stored as.
GEN_MASS_COLUMNS = ("Gen_Part_Mass", "Gen_Part_PID")
GEN_MASSES = {2212: 0.938272, 211: 0.139570, 13: 0.105658, 11: 0.000511}
GEN_MASS_REQUIRED = (2212,)
GEN_MASS_RTOL = 0.01


def check_gen_masses(pf, names):
    """Return the errors in the generator masses: not finite, or not in GeV."""
    missing = [c for c in GEN_MASS_COLUMNS if c not in names]
    if missing:
        return ["missing columns: " + ", ".join(missing)]

    table = pf.read(columns=list(GEN_MASS_COLUMNS))
    mass = pc.list_flatten(table["Gen_Part_Mass"]).to_numpy().astype(np.float64)
    pid = np.abs(pc.list_flatten(table["Gen_Part_PID"]).to_numpy())

    errors = []
    bad = ~np.isfinite(mass)
    print(f"  Gen_Part_Mass: {mass.size} particles, {bad.sum()} not finite")
    if bad.any():
        errors.append(f"Gen_Part_Mass: {bad.sum()} values are not finite")

    for code, expected in GEN_MASSES.items():
        m = mass[pid == code]
        if m.size == 0:
            if code in GEN_MASS_REQUIRED:
                errors.append(f"Gen_Part_Mass: no |PID| {code} particles to check")
            continue
        lo, hi = m.min(), m.max()
        print(f"  Gen_Part_Mass of |PID| {code}: {lo:.6g} to {hi:.6g} GeV "
              f"over {m.size} particles, expected {expected}")
        if max(abs(lo - expected), abs(hi - expected)) > GEN_MASS_RTOL * expected:
            errors.append(f"Gen_Part_Mass of |PID| {code}: {lo:.6g} to {hi:.6g}, "
                          f"expected {expected} GeV")
    return errors


def main():
    ap = argparse.ArgumentParser(description="Check a run.sh parquet file.")
    ap.add_argument("parquet")
    ap.add_argument("--max-events", type=int, required=True)
    args = ap.parse_args()

    try:
        pf = pq.ParquetFile(args.parquet)
    except Exception as exc:
        print(f"FAIL: cannot read {args.parquet}: {exc}")
        return 1

    nevents = pf.metadata.num_rows
    names = set(pf.schema_arrow.names)
    print(f"{args.parquet}: {nevents} events, {len(names)} columns")

    errors = []
    if not 1 <= nevents <= args.max_events:
        errors.append(f"expected 1 to {args.max_events} events, found {nevents}")

    missing = [c for c in REQUIRED_COLUMNS if c not in names]
    if missing:
        errors.append("missing columns: " + ", ".join(missing))

    present = [c for c in MIN_PER_EVENT if c in names]
    table = pf.read(columns=present) if present else None
    for col in present:
        counts = pc.list_value_length(table[col]).to_pylist()
        counts = [0 if c is None else c for c in counts]
        lowest = min(counts, default=0)
        print(f"  {col}: {lowest} to {max(counts, default=0)} entries per event")
        if lowest < MIN_PER_EVENT[col]:
            errors.append(f"{col}: an event has {lowest} entries, "
                          f"expected at least {MIN_PER_EVENT[col]}")

    for col in NO_NULLS:
        if col in names:
            nulls = pf.read(columns=[col])[col].null_count
            print(f"  {col}: {nulls} events without a value")
            if nulls:
                errors.append(f"{col}: {nulls} events have no value")

    errors += check_gen_masses(pf, names)

    for err in errors:
        print(f"FAIL: {err}")
    if errors:
        return 1
    print("OK")
    return 0


if __name__ == "__main__":
    sys.exit(main())
