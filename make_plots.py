import numpy as np
import matplotlib.pyplot as plt
import matplotlib
import uproot
import argparse
import yaml
import os

matplotlib.use("agg")

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--path", "-p", type=str, required=True)
    parser.add_argument("--val_config", "-v", type=str, default="./validation_config.yaml")
    args = parser.parse_args()

    latest_run = sorted(os.listdir(os.path.join(args.path, "Events")))[-1]

    event = uproot.open(os.path.join(args.path, "Events", latest_run, "tag_1_delphes_events.root"))["Delphes;1"]

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