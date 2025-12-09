#!/usr/bin/env python3
"""
process_root_parquet.py

Convert Delphes .root output containing both full‑reconstruction ("FullReco")
and Level‑1 trigger ("L1T") branches into a single Parquet file.

The script extracts
  • PF candidates with PUPPI
  • EFlowTracks / NeutralHadrons / Photons
  • Electron / Muon / Photon collections (cross‑checked against tracks/photons)
  • Jets (anti‑kT R=0.4 & 0.8, PF and PUPPI)
  • Missing ET and PUPPI‑MET
  • GenParticles and GenJets
  • Primary & Secondary vertices

Every branch is written twice: once with prefix FullReco and once with prefix L1T.

Usage
------
    python3 process_root_parquet.py input.root output.parquet   # default chunk=10 000 events
    python3 process_root_parquet.py -h                          # full CLI help
"""

import argparse
import logging
from pathlib import Path
import numpy as np
import awkward as ak
import uproot

# ---------------------------------------------------------------------
# Space–saving helper: cast high‑dynamic‑range float columns to float16
# without touching variables that need sub‑GeV precision.
#
# Feel free to extend SAFE_FLOAT16 if you later add more branches that
# are O(1–10^4) in magnitude.
# ---------------------------------------------------------------------
SAFE_FLOAT16 = {
    "PT", "ET", "Eta", "Phi", "Mass", "E", "MET", "PuppiW"
}

SAFE_INT8 = {
    "Charge", "IsPU", "BTag", "BTagPhys", "Status"
}

SAFE_INT16 = {
    "ConstituentsIdx", 
}

SAFE_UINT32 = {
    "fUniqueID", "Constituents"
}

SAFE_INT32 = {
    "PID"
}

# Keep only the N highest‑pT PF candidates **per event** to control file size.
MAX_PF_PER_EVENT = 200 #128 for L1T 
PF_COLLECTION_KEYS = ()
# PF_COLLECTION_KEYS = ("PFCand", "PUPPIPart")  # collections to be trimmed

logging.basicConfig(
    format="%(asctime)s — %(levelname)s — %(message)s",
    level=logging.INFO,
)

################################################################################
#                                CONFIGURATION                                 #
################################################################################

# -- Mapping of logical collection names to Delphes branch prefixes -----------
# Adapt as needed for your custom Delphes card.
# If you want to add an index mapping, specify "constit_target" with the name
# of the collection whose fUniqueIDs correspond to the ones in the Constituents array. 
COLLECTIONS = {
    #"PFCand": {
    #    "prefix": "EFlowCHS",
    #    "vars": [
    #        "PT", "Eta", "Phi", "PID", "Charge", "Mass",
    #        "D0", "DZ", "ErrorD0", "ErrorDZ", "fUniqueID",
    #        "PuppiW", "IsPU"
    #    ],
    #},
    # "EFlowTrack": {
    #     "prefix": "EFlowTrack",
    #     "vars": [
    #         "PT", "Eta", "Phi", "Charge", "Mass",
    #         "D0", "DZ", "ErrorD0", "ErrorDZ", #"IsPU"
    #     ],
    # },
    # "EFlowNeutralHadron": {
    #     "prefix": "EFlowNeutralHadron",
    #     "vars": ["ET", "Eta", "Phi", "E", "Eem", "Ehad"],
    # },
    # "EFlowPhoton": {
    #     "prefix": "EFlowPhoton",
    #     "vars": ["ET", "Eta", "Phi", "E", "Eem", "Ehad"],
    # }, 
    "PUPPIPart": {
        "prefix": "EFlowPuppi",
        "vars": [
            "PT", "Eta", "Phi", "Charge", "Mass", "PID",
            "D0", "DZ", "ErrorD0", "ErrorDZ", "fUniqueID", "PuppiW", "IsPU"
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
    #"JetAK4":               {"prefix": "Jet",               "vars": ["PT", "Eta", "Phi", "Mass", "BTag", "BTagPhys", "Charge", "Constituents"]},
    #"JetAK8":               {"prefix": "JetAK8",            "vars": ["PT", "Eta", "Phi", "Mass", "BTag", "BTagPhys", "Charge", "Constituents"]},
    #"JetPuppiLoose":          {"prefix": "JetPUPPILoose",          "vars": ["PT", "Eta", "Phi", "Mass", "BTag", "BTagPhys", "Charge", "Constituents"],
    #                           "constit_target": "PUPPIPart"},
    #"JetPuppiTight":          {"prefix": "JetPUPPITight",          "vars": ["PT", "Eta", "Phi", "Mass", "BTag", "BTagPhys", "Charge", "Constituents"], 
    #                           "constit_target": "PUPPIPart"},
    
    "JetPuppiAK4":          {"prefix": "JetPUPPI",          "vars": ["PT", "Eta", "Phi", "Mass", "BTag", "BTagPhys", "Charge", "Constituents"],
                              "constit_target": "PUPPIPart"},
    "JetPuppiAK8":          {"prefix": "JetPUPPIAK8",       "vars": ["PT", "Eta", "Phi", "Mass", "BTag", "BTagPhys", "Charge", "Constituents"],
                              "constit_target": "PUPPIPart"},
    
    # MET
    "MET":                  {"prefix": "MissingET",         "vars": ["MET", "Phi", "Eta"]},
    "PUPPIMET":             {"prefix": "PuppiMissingET",    "vars": ["MET", "Phi", "Eta"]},
    
    "GenMissingET":         { "prefix": "GenMissingET",     "vars": ["MET", "Eta", "Phi"] },

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


def branch(tree, br_name):
    """Return awkward array if branch exists, else None."""
    try:
        ret = tree[br_name].array(library="ak")
        # logging.warning("Branch %s found.", br_name)
        return ret
        
    except KeyError:
        logging.warning("Branch %s not found, skipping.", br_name)
        return None

def sort_collection(jagged_arrays, sort_key):
    """
    Used for pT sorting of collections.
    jagged_arrays: dict {var_name: awkward_array}
    sort_key: awkward array used to generate sort order
    Returns dict of sorted arrays.
    """
    # Only sort per event (axis=1: object-level)
    idx = ak.argsort(sort_key, axis=1, ascending=False)

    # Apply permutation to all arrays
    return {k: v[idx] for k, v in jagged_arrays.items()}

def add_index_mapping(constituent_arr, fUniqueID_arr):
    """
    Given a jagged array of constituents (with fUniqueID values) and a jagged
    array of object (particle/vertex) fUniqueID values, build an additional index mapping with
    the same function

    Returns an Awkward array of the same shape as constituent_arr,
    filled with object (particles/vertices) indices or -1.
    """

    out = []

    # Loop over events
    for constits, uids in zip(constituent_arr, fUniqueID_arr):

        # Convert to numpy for speed
        uids_np = np.asarray(uids)

        # Sort PF fUniqueIDs; they do NOT need to be sorted beforehand
        sort_idx = np.argsort(uids_np)
        uids_sorted = uids_np[sort_idx]

        # Constituents → flat numpy
        const_np = ak.to_numpy(ak.flatten(constits))

        # Vectorized binary search
        pos = np.searchsorted(uids_sorted, const_np)

        # Check validity: searchsorted gives "insert position", must verify match
        mask_valid = (
            (pos < len(uids_sorted)) &
            (uids_sorted[pos] == const_np)
        )

        # Map from sorted index → original PF index, or -1
        idx_flat = np.where(mask_valid, sort_idx[pos], -1)

        # Reshape back to jagged structure
        idx_jagged = ak.unflatten(idx_flat, ak.num(constits, axis=1))

        out.append(idx_jagged)

    return ak.Array(out)




def write_collection(tree, table_data, l1t=False):
    """
    Extract every collection listed in CONFIGURATION and add the branches as values of the table_data dictionary.
    If `l1t` is True, use the L1T view of the collection, otherwise use the FullReco view.
    """
    tag = "L1T" if l1t else "FullReco"
    prefix = "L1T" if l1t else ""
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
        if tag == "L1T" and coll_key in PF_COLLECTION_KEYS:
            pt_array = branch(tree, f"{full_prefix}.PT")
            if pt_array is not None:
                # argsort returns ascending → take tail and build boolean mask
                #rank = ak.argsort(pt_array, axis=1, ascending=False)
                sorted_indices = ak.argsort(pt_array, axis=1, ascending=False)
                #keep_mask = rank < MAX_PF_PER_EVENT
                ranks = ak.argsort(sorted_indices, axis=1)
                keep_mask = ranks < MAX_PF_PER_EVENT

        logging.debug(" • %s", coll_key)

        # ---------------------------------------------------------------
        # Load all variables for this collection into a temporary dict
        # ---------------------------------------------------------------
        arrays = {}

        for var in vars_:
            br = f"{full_prefix}.{var}"
            arr = branch(tree, br)

            if arr is None:
                continue

            if var == "Constituents":
                arr = arr.refs  # strip ROOT wrapper

            # Apply PF thinning mask before sorting
            if keep_mask is not None:
                arr = arr[keep_mask]

            arrays[var] = arr

        # Skip empty collections
        if not arrays:
            continue

        # ---------------------------------------------------------------
        # Choose sort variable for this collection and sort
        # ---------------------------------------------------------------
        if coll_key == "PrimaryVertex":
            sort_var = "SumPT2"
        else:
            sort_var = "PT"

        if sort_var not in arrays:
            logging.warning(f"Sort variable {sort_var} missing in {coll_key}, skipping sort.")
            sorted_arrays = arrays
        else:
            sorted_arrays = sort_collection(arrays, arrays[sort_var])

        # ---------------------------------------------------------------
        # If this collection has a variable "Constituents", build index mapping
        # ---------------------------------------------------------------
        constit_target = cfg.get("constit_target", None)

        if "Constituents" in sorted_arrays and constit_target is not None:
            # The PF candidate array for this tag should already exist in table_data
            target_key = f"{tag}_{constit_target}_fUniqueID"

            if target_key not in table_data:
                logging.warning(
                    f"{coll_key} specifies constit_target={constit_target} "
                    f"but particle fUniqueID array {target_key} is not available."
                )
            else:
                try:
                    idx_map = add_index_mapping(
                        sorted_arrays["Constituents"],
                        table_data[target_key]
                    )
                    sorted_arrays["ConstituentsIdx"] = idx_map
                except Exception as e:
                    logging.error(
                        f"Failed to compute ConstituentIdx for {coll_key}: {e}"
                    )

        
        # ---------------------------------------------------------------
        # Cast types *after* sorting and store in table_data
        # ---------------------------------------------------------------
        for var, arr in sorted_arrays.items():

            if var in SAFE_FLOAT16:
                arr = ak.values_astype(arr, np.float16)

            if var in SAFE_INT8:
                arr = ak.values_astype(arr, np.int8)
                
            if var in SAFE_INT16:
                arr = ak.values_astype(arr, np.int16)
                
            if var in SAFE_INT32:
                arr = ak.values_astype(arr, np.int32)
                
            if var in SAFE_UINT32:
                arr = ak.values_astype(arr, np.uint32)

            if coll_key.startswith("Gen"):
                colname = f"{coll_key}_{var}"
                colname = colname.replace("Gen", "Gen_")
                print(colname)
            
            #make separate collection also for vertex
            elif coll_key.startswith("PrimaryVertex"):
                colname = f"PrimaryVertex_{var}" 
                print(colname)
            else:
                colname = f"{tag}_{coll_key}_{var}"
                print(colname)
                
            table_data[colname] = arr            
            
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
    table_data= {}
    
    # ── Full‑reco view ═══════════════════════════════════════════════════════
    write_collection(tree, table_data, l1t=False)

    # ── Level‑1 Trigger view ═════════════════════════════════════════════════
    write_collection(tree, table_data, l1t=True)

    """
    # ── Build the PyArrow table from the dictionary ══════════════════════════
    table = pa.table(table_data)

    # ── Add Global metadata ══════════════════════════════════════════════════
    metadata = {
        "source_root": str(root_path),
        "nEvents": str(tree.num_entries),
    }
    table = table.replace_schema_metadata(metadata)
    
    # ── Write to Parquet file ════════════════════════════════════════════════
    pq.write_table(table, 
                   out_path,
                   compression="zstd",  
                   row_group_size=1000000)
    """
    # Build awkward record and write to Parquet
    # Convert dictionary to awkward record
    record = ak.zip(table_data, depth_limit=1)
    
    # Add metadata as parameter
    metadata = {"source_root": str(root_path), "nEvents": str(tree.num_entries)}
    record = ak.with_parameter(record, "__metadata__", metadata)

    # Write to Parquet file
    ak.to_parquet(record, 
                  out_path,
                  compression="zstd",
                  row_group_size=1000000)
    
    
    logging.info("✓ finished. Parquet size = %.1f MB", out_path.stat().st_size / 1e6)

################################################################################
#                                 CLI PARSER                                   #
################################################################################

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Convert Delphes ROOT → Parquet.")
    parser.add_argument("input",  help="Input Delphes .root file")
    parser.add_argument("output", help="Output .parquet file")
    parser.add_argument("-v", "--verbose", action="store_true", help="More logging")
    args = parser.parse_args()

    if args.verbose:
        logging.getLogger().setLevel(logging.DEBUG)

    main(args)