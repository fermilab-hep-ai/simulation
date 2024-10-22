import numpy as np 
import os
import argparse
def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-d','--dir', type=str, required=True,
        help="directory to be measured")
    args = parser.parse_args()
    timings = {}

    for event in os.listdir(args.dir):
        path = os.path.join(args.dir, event, "timing.txt")
        proc = event.split("-")[0]
        timings[proc] = timings.get(proc, [])
        with open(path, "r") as f:
            content = f.readlines()
            timings[proc].append(int(content[-1].split(":")[1])) 

    for name in timings:
        timings[name] = np.array(timings[name])
        print(f"{name}: {timings[name].mean():.0f} ± {timings[name].std():.0f}")   

if __name__ == "__main__":
    main()