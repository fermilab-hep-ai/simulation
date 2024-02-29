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
apptainer exec --bind $outdir,$simdir /cvmfs/unpacked.cern.ch/registry.hub.docker.com/jmduarte/mapyde:latest sh {simdir}/run.sh $process $nevents $seed $outdir $simdir
```
`$outdir` should NOT contain the process name you want to run. A folder will be automatically created for you. `$simdir` should be the directory where the simulation repository is. Note that it is a known bug that if `$outdir` and `$simdir` are both on eos, OS Error 35 can be triggered and should be avoided 

Alternatively, use the `submit_to_condor.py`:
```
python3 submit_to_condor.py -o $outdir -p $proc --simdir $simdir --seed $seed -n $nevents
```
Set the `-l` flag if you want to run locally, otherwise it will be submitted as a condor job.