#!/usr/bin/env python3
"""
delphes_to_h5.py

Convert Delphes .root output containing both full‑reconstruction ("FullReco")
and Level‑1 trigger ("L1T") branches into a single HDF5 file.

The script extracts
  • PF candidates with PUPPI
  • EFlowTracks / NeutralHadrons / Photons
  • Electron / Muon / Photon collections (cross‑checked against tracks/photons)
  • Jets (anti‑kT R=0.4 & 0.8, PF and PUPPI)
  • Missing ET and PUPPI‑MET
  • GenParticles and GenJets
  • Primary & Secondary vertices

Every branch is written twice: once under /FullReco and once under /L1T.
The output now also carries an explicit jet → PF‑candidate map (`Constituents_data` / `Constituents_offsets`) that makes it trivial to recover the list of PF indices for every jet.

Usage
------
    python3 process_root_h5.py input.root output.h5        # default chunk=10 000 events
    python3 process_root_h5.py -h                          # full CLI help
"""


import argparse
import logging
from pathlib import Path
import numpy as np
import awkward as ak
import uproot
import h5py

# ---------------------------------------------------------------------
# Space–saving helper: cast high‑dynamic‑range float columns to float16
# without touching variables that need sub‑GeV precision.
#
# Feel free to extend SAFE_FLOAT16 if you later add more branches that
# are O(1–10^4) in magnitude.
# ---------------------------------------------------------------------
SAFE_FLOAT16 = {
    # 4‑vectors & MET
    # "PT", "ET", "Eta", "Phi", "Mass", "E", "MET",
    # # jet & PF extras
    # "PuppiW",
}

# Keep only the N highest‑pT PF candidates **per event** to control file size.
MAX_PF_PER_EVENT = 200
PF_COLLECTION_KEYS = ("PFCand", "PUPPIPart")  # collections to be trimmed

def _cast_maybe_half(name: str, arr: np.ndarray) -> np.ndarray:
    """
    Down‑cast to float16 if the branch name is in SAFE_FLOAT16 and the
    dtype is floating.  Otherwise return the array unchanged.
    """
    if name in SAFE_FLOAT16 and np.issubdtype(arr.dtype, np.floating):
        return arr.astype(np.float16, copy=False)
    return arr

logging.basicConfig(
    format="%(asctime)s — %(levelname)s — %(message)s",
    level=logging.INFO,
)

################################################################################
#                                CONFIGURATION                                 #
################################################################################

# -- Mapping of logical collection names to Delphes branch prefixes -----------
# Adapt as needed for your custom Delphes card.
COLLECTIONS = {
    "PFCand": {
        "prefix": "EFlowCHS",
        "vars": [
            "PT", "Eta", "Phi", "PID", "Charge", "Mass",
            "D0", "DZ", "ErrorD0", "ErrorDZ",
            "PuppiW", #"IsPU"
        ],
    },
    "EFlowTrack": {
        "prefix": "EFlowTrack",
        "vars": [
            "PT", "Eta", "Phi", "Charge", "Mass",
            "D0", "DZ", "ErrorD0", "ErrorDZ", #"IsPU"
        ],
    },
    "EFlowNeutralHadron": {
        "prefix": "EFlowNeutralHadron",
        "vars": ["ET", "Eta", "Phi", "E", "Eem", "Ehad"],
    },
    "EFlowPhoton": {
        "prefix": "EFlowPhoton",
        "vars": ["ET", "Eta", "Phi", "E", "Eem", "Ehad"],
    },
    "PUPPIPart": {
        "prefix": "EFlowPuppi",
        "vars": [
            "PT", "Eta", "Phi", "Charge", "Mass", "PID"
            "D0", "DZ", "ErrorD0", "ErrorDZ", "PuppiW", "IsPU"
        ],
    },
    "Electron": {
        "prefix": "Electron",
        "vars": [
            "PT", "Eta", "Phi",
            "EhadOverEem", "IsolationVarRhoCorr"
        ],
    },
    # Muons
    # "MuonLoose": {
    #     "prefix": "MuonLoose",
    #     "vars": [
    #         "PT", "Eta", "Phi",
    #         "IsolationVarRhoCorr"
    #     ],
    # },
    "MuonTight": {
        "prefix": "MuonTight",
        "vars": [
            "PT", "Eta", "Phi",
            "IsolationVarRhoCorr"
        ],
    },
    # Photons
    # "PhotonLoose": {
    #     "prefix": "PhotonLoose",
    #     "vars": ["PT", "Eta", "Phi"],
    # },
    "PhotonTight": {
        "prefix": "PhotonTight",
        "vars": ["PT", "Eta", "Phi"],
    },
    # Jets
    "JetAK4":               {"prefix": "Jet",               "vars": ["PT", "Eta", "Phi", "Mass", "BTag", "BTagPhys", "Charge" "Constituents"]},
    "JetAK8":               {"prefix": "JetAK8",            "vars": ["PT", "Eta", "Phi", "Mass", "BTag", "BTagPhys", "Charge"]},# "Constituents"]},
    "JetPuppiAK4":          {"prefix": "JetPUPPI",          "vars": ["PT", "Eta", "Phi", "Mass", "BTag", "BTagPhys", "Charge"]},# "Constituents"]},
    "JetPuppiAK8":          {"prefix": "JetPUPPIAK8",       "vars": ["PT", "Eta", "Phi", "Mass", "BTag", "BTagPhys", "Charge"]},# "Constituents"]},
    # MET
    "MET":                  {"prefix": "MissingET",         "vars": ["MET", "Phi", "Eta"]},
    "PUPPIMET":             {"prefix": "PuppiMissingET",    "vars": ["MET", "Phi", "Eta"]},
    
    "GenMissingET":         { "prefix": "GenMissingET",     "vars": ["MET", "Eta", "Phi"] }

    # Gen info
    "GenPart":              {"prefix": "Particle",          "vars": ["PT", "Eta", "Phi", #"Mass",
                                                                     "PID", "M1", "M2", "D1", "D2",
                                                                     "Status", "IsPU",]},# "X", "Y", "Z", "T"]},
    "GenJetAK4":            {"prefix": "GenJet",            "vars": ["PT", "Eta", "Phi", "Mass"]},
    "GenJetAK8":            {"prefix": "GenJetAK8",         "vars": ["PT", "Eta", "Phi", "Mass"]},
    # Vertices
    "PrimaryVertex":        {"prefix": "Vertex",            "vars": ["X", "Y", "Z", "T", "SumPT2"
                                                                     # Not found
                                                                     # "Chi2", "Status",
                                                                    ]},
    # Not found
    # "SecondaryVertex":      {"prefix": "SecondaryVertex",   "vars": ["X", "Y", "Z", "NDF", "Chi2"]},
}

# Add any mapping of branch names that differ between FullReco and L1T trees if
# they are not simply the same with a different prefix.
# e.g.   L1TJet.PT   vs Jet.PT
L1T_RENAME = {
    # "Jet": "L1TJet",   # <example>

    # "L1TParticle" not found
    # "L1TGenJet" not found
    # "L1TGenJetAK8" not found
    # "L1TVertex" not found
}

################################################################################
#                               CORE  UTILITIES                                #
################################################################################

def make_dataset(group: h5py.Group, name: str, jagged: ak.Array):
    """
    Store a jagged Awkward array in two flat datasets.

    Generic case (shape = [event][object][…]):
        <name>_data     – flattened values
        <name>_offsets  – event‑level offsets (len = nEvents+1)

    Special case ``name == "Constituents"``:
        • Decode ROOT ``TRefArray`` words into zero‑based PF‑candidate
          indices:  idx = (ref & 0x3FFFFF) – 1
        • Write
            Constituents_data     – flattened PF indices
            Constituents_offsets  – offsets **per jet** (len = nJets+1)

       Rebuild later with::

           start, stop = offsets[j], offsets[j+1]
           pf_idx      = data[start:stop]   # numpy slice of PF indices
    """
    try:
        # ────────────────────────────────────────────────────────────────
        # Jet‑constituent map  (TRefArray → PF index)
        # ────────────────────────────────────────────────────────────────
        if name == "Constituents":
            # jagged layout: [event][jet] dict{fName,fSize,refs}
            refs = jagged.refs                                # uint32 list
            idx  = ak.values_astype((refs & 0x3FFFFF), np.int64) - 1  # 0‑based
            flat      = ak.to_numpy(ak.flatten(idx, axis=None))                # all indices
            
            jet_sizes = ak.to_numpy(ak.flatten(ak.num(idx, axis=2)))# cands per‑jet
            offsets   = np.concatenate(([0], np.cumsum(jet_sizes))) # jet offsets

            group.create_dataset(f"{name}_data",
                                 data=flat,
                                 compression="gzip",
                                 compression_opts=4,
                                 shuffle=True)
            group.create_dataset(f"{name}_offsets",
                                 data=offsets,
                                 compression="gzip",
                                 compression_opts=4,
                                 shuffle=True)
            logging.debug("  ⤷ wrote %s (constituent map, %d indices)",
                          name, len(flat))
            return  # special case handled – exit here
        # ────────────────────────────────────────────────────────────────
        # Generic jagged branch
        # ────────────────────────────────────────────────────────────────
        flat = _cast_maybe_half(name, ak.to_numpy(ak.flatten(jagged, axis=None)))
        counts = ak.to_numpy(ak.num(jagged, axis=1))          # objects/event
        offsets = np.concatenate(([0], np.cumsum(counts)))    # event offsets

        group.create_dataset(f"{name}_data",
                             data=flat,
                             compression="gzip",
                             compression_opts=4,
                             shuffle=True)
        group.create_dataset(f"{name}_offsets",
                             data=offsets,
                             compression="gzip",
                             compression_opts=4,
                             shuffle=True)
        logging.debug("  ⤷ wrote %s (%d entries)", name, len(flat))

    except Exception as e:
        logging.warning("Skipping %s - cannot process: %s", name, str(e))
        return


def branch(tree, br_name):
    """Return awkward array if branch exists, else None."""
    try:
        ret = tree[br_name].array(library="ak")
        # logging.warning("Branch %s found.", br_name)
        return ret
        
    except KeyError:
        logging.warning("Branch %s not found, skipping.", br_name)
        return None


def write_collection(tree, h5group, prefix="", l1t=False):
    """
    Extract every collection listed in CONFIGURATION and write into an HDF5
    group.  `prefix` is either "" for FullReco or "L1T" for trigger objects.
    """
    tag = "L1T" if l1t else "FullReco"
    logging.info("Processing %s collections …", tag)

    for coll_key, cfg in COLLECTIONS.items():
        coll_prefix = cfg["prefix"]
        vars_ = cfg["vars"]

        # If we're on the L1T view, rewrite the Delphes collection prefix if needed
        tree_prefix = L1T_RENAME.get(coll_prefix, coll_prefix)
        full_prefix = f"{prefix}{tree_prefix}"

        # -----------------------------------------------------------------
        # Optional PF thinning: keep top‑N candidates by pT per event
        # -----------------------------------------------------------------
        keep_mask = None
        if coll_key in PF_COLLECTION_KEYS:
            pt_array = branch(tree, f"{full_prefix}.PT")
            if pt_array is not None:
                # argsort returns ascending → take tail and build boolean mask
                rank = ak.argsort(pt_array, axis=1, ascending=False)
                keep_mask = rank < MAX_PF_PER_EVENT

        subgroup = h5group.require_group(coll_key)
        logging.debug(" • %s", coll_key)

        for var in vars_:
            br = f"{full_prefix}.{var}"
            arr = branch(tree, br)
            if arr is None:
                continue

            # Apply thinning mask consistently to every column
            if keep_mask is not None:
                arr = arr[keep_mask]
            make_dataset(subgroup, var, arr)

    logging.info("Done with %s", tag)

################################################################################
#                                  MAIN LOOP                                   #
################################################################################

def main(args):
    root_path = Path(args.input).expanduser().resolve()
    out_path  = Path(args.output).expanduser().resolve()

    logging.info("Input:  %s", root_path)
    logging.info("Output: %s", out_path)

    # Open input and output files
    tree = uproot.open(root_path)["Delphes"]
    with h5py.File(out_path, "w") as h5:

        # ── Full‑reco view ════════════════════════════════════════════════════════
        full_grp = h5.require_group("FullReco")
        write_collection(tree, full_grp, prefix="", l1t=False)

        # ── Level‑1 Trigger view ═════════════════════════════════════════════════
        l1t_grp  = h5.require_group("L1T")
        write_collection(tree, l1t_grp, prefix="L1T", l1t=True)

        # ── Global metadata ══════════════════════════════════════════════════════
        h5.attrs["source_root"] = str(root_path)
        h5.attrs["nEvents"]     = len(tree)

    logging.info("✓ finished. HDF5 size = %.1f MB", out_path.stat().st_size / 1e6)

################################################################################
#                                 CLI PARSER                                   #
################################################################################

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Convert Delphes ROOT → HDF5.")
    parser.add_argument("input",  help="Input Delphes .root file")
    parser.add_argument("output", help="Output .h5 file")
    parser.add_argument("-v", "--verbose", action="store_true", help="More logging")
    args = parser.parse_args()

    if args.verbose:
        logging.getLogger().setLevel(logging.DEBUG)

    main(args)