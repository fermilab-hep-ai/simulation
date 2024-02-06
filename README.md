## Usage
To use the package, first run:
```
git clone https://github.com/ryanliu30/simulation.git
cd simulation
```
Then, download the MinBias events:
```
wget https://cernbox.cern.ch/remote.php/dav/public-files/IyG0C0tfkXW7ifF/MinBias_100k.pileup
```
Finally, run the `run.sh` command with the docker image: (you can also build the image using the dockerfile under `/docker`)
```
apptainer exec --bind $outdir --nv /cvmfs/unpacked.cern.ch/registry.hub.docker.com/jmduarte/mapyde:latest sh run.sh $process $nevents $seed $outdir
```
Or alternatively, use the `submit.sh`:
```
sh submit.sh $process $nevents $seed $outdir
```
Note that `$outdir` should NOT contain the process name you want to run. A folder will be automatically created for you.