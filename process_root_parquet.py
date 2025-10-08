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
    "Charge", "PID", "IsPU", "BTag", "BTagPhys", "Status"
}

# Keep only the N highest‑pT PF candidates **per event** to control file size.
MAX_PF_PER_EVENT = 999999 #128 for L1T 
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
COLLECTIONS = {
    "PFCand": {
        "prefix": "EFlowCHS",
        "vars": [
            "PT", "Eta", "Phi", "PID", "Charge", "Mass",
            "D0", "DZ", "ErrorD0", "ErrorDZ", "fUniqueID",
            "PuppiW", #"IsPU"
        ],
    },
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
            "D0", "DZ", "ErrorD0", "ErrorDZ", "fUniqueID", "PuppiW", #"IsPU"
        ],
    }, #MAYBE REMOVE 

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
    "JetAK4":               {"prefix": "Jet",               "vars": ["PT", "Eta", "Phi", "Mass", "BTag", "BTagPhys", "Charge", "Constituents"]},
    "JetAK8":               {"prefix": "JetAK8",            "vars": ["PT", "Eta", "Phi", "Mass", "BTag", "BTagPhys", "Charge", "Constituents"]},
    "JetPuppiAK4":          {"prefix": "JetPUPPI",          "vars": ["PT", "Eta", "Phi", "Mass", "BTag", "BTagPhys", "Charge", "Constituents"]},
    "JetPuppiAK8":          {"prefix": "JetPUPPIAK8",       "vars": ["PT", "Eta", "Phi", "Mass", "BTag", "BTagPhys", "Charge", "Constituents"]},
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

        for var in vars_:
            br = f"{full_prefix}.{var}"
            arr = branch(tree, br)
            if var == 'Constituents' and arr is not None:
                # This array is stored by root as a dictionary with .refs containing the constituent indices
                # The rest of the dictionary is useless
                arr=arr.refs 
            if arr is None:
                continue

            # Apply thinning mask consistently to every column
            if keep_mask is not None:
                arr = arr[keep_mask]
            
            # Cast to float16 if applicable
            if var in SAFE_FLOAT16:
                arr = ak.values_astype(arr, np.float16)

            # Cast to int8 if applicable
            if var in SAFE_INT8:
                arr = ak.values_astype(arr, np.int8)

            column_name = f"{tag}_{coll_key}_{var}"
            table_data[column_name] = arr
            logging.debug("  • %s", column_name)
            
            
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