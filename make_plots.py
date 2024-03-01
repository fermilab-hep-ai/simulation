import numpy as np
import matplotlib.pyplot as plt
import matplotlib
import uproot
import argparse
import yaml
import os
from fnmatch import fnmatch

matplotlib.use("agg")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--path", "-p", type=str, required=True)
    parser.add_argument("--val-config", "-v", type=str, default="./validation_config.yaml")
    args = parser.parse_args()

    root_file = None
    for file in os.listdir(os.path.join(args.path)):
        if fnmatch(file, "*.root"):
            root_file = file
            break
    if root_file is None:
        raise RuntimeError("Cannot Find Root Event!")
    print("Found the following event record: ", root_file)

    event = uproot.open(os.path.join(args.path, root_file))["Delphes;1"]

    with open(args.val_config) as f:
        val_config = yaml.safe_load(f)

    if not os.path.exists(os.path.join(args.path, "validation_plots")):
        os.makedirs(os.path.join(args.path, "validation_plots"))
    for name, config in val_config.items():
        observables = np.asarray(event[name].array()).squeeze()
        fig, ax = plt.subplots()
        if config["discrete"]:
            bins = np.arange(round(np.quantile(observables, 0.99)) + 2)
        else:
            bins = np.linspace(0, np.quantile(observables, 0.99), 51)
        ax.hist(observables, bins = bins, alpha = 0.7)
        ax.set_xlabel(config["x_label"])
        ax.set_ylabel("Event counts")
        fig.savefig(os.path.join(args.path, "validation_plots", config["save_name"]))

if __name__ == "__main__":
    main()