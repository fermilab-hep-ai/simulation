## Usage
To use the package, first run:
```
git clone https://github.com/ryanliu30/simulation.git
cd simulation
conda create -n simulation python=3.11
conda activate simulation
pip install -r requirement
```
Then, export your madgraph installation path and download the MinBias events:
```
export MADGRAPH="YOUR/MADGRAPH/INSTALLATION/PATH"
wget https://cernbox.cern.ch/remote.php/dav/public-files/IyG0C0tfkXW7ifF/MinBias_100k.pileup
```
Finally, run the `run.sh` command:
```
sh run.sh $process $nevents $seed
```
You can define new processes by creating a file named `proc_${process_name}` under the `processes` folder. 
This script will also generate some validation plots under the `events/${process_name}/validation_plots` folder.
