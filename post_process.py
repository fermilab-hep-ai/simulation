import os
import argparse
import shutil

PROCESS_LIST = [
    "ggHZZ",
    "ttH_incl",
    "WJetsToLNu_13TeV-madgraphMLM-pythia8",
    "VBFHZZ",
    "WZ_semileptonic",
    "tt0123j_5f_ckm_LO_MLM_hadronic",
    "VVV_incl",
    "WW_leptonic",
    "ZJetsTovv_13TeV-madgraphMLM-pythia8",
    "WZ_hadronic",
    "ZZ_semileptonic",
    "tt0123j_5f_ckm_LO_MLM_semiLeptonic",
    "ZJetsTobb_13TeV-madgraphMLM-pythia8",
    "HH_bbgammagamma",
    "ggHbb",
    "QCD_HT50toInf",
    "QCD_HT50tobb",
    "DYJetsToLL_13TeV-madgraphMLM-pythia8",
    "ZJetsToQQ_13TeV-madgraphMLM-pythia8",
    "WW_hadronic",
    "WW_semileptonic",
    "HH_4b",
    "ZZ_leptonic",
    "WJetsToQQ_13TeV-madgraphMLM-pythia8",
    "ggHgluglu",
    "VBFHcc",
    "VBFHgammagamma",
    "VBFHWW",
    "ggHgammagamma",
    "gamma",
    "HH_bbZZ",
    "ttZ_incl",
    "ttW_incl",
    "ZZ_hadronic",
    "VBFHbb",
    "ggHtautau",
    "VH_incl",
    "ggHWW",
    "tt0123j_5f_ckm_LO_MLM_leptonic",
    "WZ_leptonic",
    "tttt_incl",
    "VBFHgluglu",
    "gamma_V",
    "VBFHtautau",
    "HH_bbtautau",
    "HH_bbWW",
    "ZJetsTocc_13TeV-madgraphMLM-pythia8",
    "ggHcc"
]

def find_empty_subfolders(input):
    """Parse the all subfolders of input and print empty directories"""
    empty_dirs = []
    for dirpath, dirnames, filenames in os.walk(input):
        if not dirnames and not filenames:  # folder is truly empty
            empty_dirs.append(dirpath)

    if empty_dirs:
        for d in empty_dirs:
            print(f"This folder is empty: {d} — Check why!")
    else:
        print("No empty subdirectories found.")
    

def list_root_files(input):
    """List all .root files in the input directory and its subdirectories."""
    root_files = []
    for dirpath, dirnames, filenames in os.walk(input):
        for filename in filenames:
            if filename.endswith("event.root"):
                root_files.append(os.path.join(dirpath, filename))
    return root_files

def list_event_parquet_files(input):
    """List all event.parquet files in the input directory and its subdirectories."""
    parquet_files = []
    for dirpath, dirnames, filenames in os.walk(input):
        for filename in filenames:
            if filename.endswith("event.parquet"):
                parquet_files.append(os.path.join(dirpath, filename))
    return parquet_files

def list_parquet_files_to_gather(input):
    """List all .parquet files in the input directory and its subdirectories, except the ones in PROCESS_LIST (which is already the correct place)."""
    parquet_files = []
    for dirpath, dirnames, filenames in os.walk(input):
        dirnames[:] = [d for d in dirnames if d != "tmpdir"]
        for filename in filenames:
            if filename.endswith(".parquet"):
                parent_folder = os.path.basename(dirpath)
                if parent_folder not in PROCESS_LIST:
                    parquet_files.append(os.path.join(dirpath, filename))
    return parquet_files

def list_parquet_targets(root_files):
    """List all .parquet file targets corresponding to the given .root files."""
    parquet_targets = []
    for root_file in root_files:
        parquet_file = root_file.replace(".root", ".parquet")
        parquet_targets.append(parquet_file)
    return parquet_targets

def remaining_root_to_parquet(input):
    """Main function to convert all remaining .root files in the input directory to .parquet files. Removes root files if successful."""
    root_files = list_root_files(input)
    parquet_targets = list_parquet_targets(root_files)
    
    if not root_files:
        print("No .root files found in the input directory.")
        return
    print(f"Found {len(root_files)} .root files to convert to .parquet.")
    for root_file, parquet_file in zip(root_files, parquet_targets):
        os.system(f"python3 process_root_parquet.py {root_file} {parquet_file}")
        if os.path.exists(parquet_file):
            print(f"Successfully converted {root_file} to {parquet_file}")
            os.remove(root_file)
        else:
            print(f"Failed to convert {root_file} to {parquet_file}")
            
def get_process_nevents_seed_from_parquet(parquet_file):
    """Given an event.parquet file as produced by the workflow, extract the process name from parent folder that follows PROCESS-NEVENTS-SEED pattern."""
    parent_name = os.path.basename(os.path.dirname(parquet_file))
    process, nevents, seed = parent_name.rsplit("-", 2)
    return process, nevents, seed

def adapt_naming(input):
    """Changes the names of all event.parquet files to PROCESS-NEVENTS-SEED.parquet"""
    parquet_files = list_event_parquet_files(input)
    for parquet_file in parquet_files:
        process, nevents, seed = get_process_nevents_seed_from_parquet(parquet_file)
        new_name = f"{process}-NEVENT{nevents}-RS{seed}.parquet"
        new_path = os.path.join(os.path.dirname(parquet_file), new_name)
        os.rename(parquet_file, new_path)
    print("Renaming completed.")
    
def gather_same_process(input):
    """Gathers all .parquet files with the same process name in one folder."""
    parquet_files = list_parquet_files_to_gather(input)
    process_groups = {}
    for parquet_file in parquet_files:
       process, _, _ = get_process_nevents_seed_from_parquet(parquet_file)
       if process not in process_groups:
           process_groups[process] = []
       process_groups[process].append(parquet_file)
    for process, files in process_groups.items():
       process_dir = os.path.join(input, process)
       os.makedirs(process_dir, exist_ok=True)
       for file in files:
            dest = os.path.join(process_dir, os.path.basename(file))
            if os.path.exists(dest):
                print(f"⚠️ Skipping {file}, already exists at {dest}")
                continue

            shutil.move(file, dest)
            print(f"Moved {file} → {dest}")
            parent_dir = os.path.dirname(file)
            try:
                os.rmdir(parent_dir)  # works only if empty
                print(f"Removed empty folder: {parent_dir}")
            except OSError:
                pass
    print("Gathering completed.")
    
def adapt_and_gather(input):
    """Main function to change the naming of parquet files and gather the ones with the same process."""
    adapt_naming(input)
    gather_same_process(input)
    
def clean_empty_folders(input):
    """Cleans up empty subfolders named tmpdir and afterwards empty folders in the input path"""
    for dirpath, dirnames, filenames in os.walk(input, topdown=False):
        for d in dirnames:
            if d == "tmpdir":
                tmpdir_path = os.path.join(dirpath, d)
                if not os.listdir(tmpdir_path):
                    os.rmdir(tmpdir_path)
                    print(f"Deleted empty tmpdir: {tmpdir_path}")
    for entry in os.scandir(input):
        if entry.is_dir() and not os.listdir(entry.path):
            os.rmdir(entry.path)
            print(f"Deleted empty folder: {entry.path}")

def main(input, show):
    if show:
        find_empty_subfolders(input)
    else:
        find_empty_subfolders(input)
        remaining_root_to_parquet(input)
        adapt_and_gather(input)
        clean_empty_folders(input)
    
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Post-process simulation output: convert remaining .root files to .parquet, rename and gather them.")
    parser.add_argument("input", help="Input directory containing simulation output subfolders with .root files and/or .parquet files.")
    parser.add_argument("-show", help="Only print empty folders and do nothing else", action='store_true')
    args = parser.parse_args()
    main(args.input, args.show)