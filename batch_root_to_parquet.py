"""
Converts all .root files found in the input folder to a corresponding .parquet file using process_root_parquet.py
"""
import os
import argparse


def list_root_files(input):
    """List all .root files in the input directory and its subdirectories."""
    root_files = []
    for dirpath, dirnames, filenames in os.walk(input):
        for filename in filenames:
            if filename.endswith(".root"):
                root_files.append(os.path.join(dirpath, filename))
    return root_files

def list_parquet_targets(root_files, suffix=None):
    """List all .parquet file targets corresponding to the given .root files. Can also append a suffix to the Parquet file name if given."""
    parquet_targets = []
    for root_file in root_files:
        parquet_file = root_file.replace(".root", ".parquet")
        if suffix:
            parquet_file = parquet_file.replace(".parquet", f"_{suffix}.parquet")
        parquet_targets.append(parquet_file)
    return parquet_targets

def main(args):
    """Main function to convert all .root files in the input directory to .parquet files."""
    root_files = list_root_files(args.input)
    parquet_targets = list_parquet_targets(root_files, args.suffix)
    if not root_files:
        print("No .root files found in the input directory.")
        return
    for root_file, parquet_file in zip(root_files, parquet_targets):
        os.system(f"python3 process_root_parquet.py {root_file} {parquet_file}")
        if os.path.exists(parquet_file):
            print(f"Successfully converted {root_file} to {parquet_file}")
        else:
            print(f"Failed to convert {root_file} to {parquet_file}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Convert .root files to .parquet files.")
    parser.add_argument("input", help="Input directory containing .root files.")
    parser.add_argument("--suffix", help="Optional suffix to append to the .parquet file names.", default=None)
    args = parser.parse_args()
    main(args)
