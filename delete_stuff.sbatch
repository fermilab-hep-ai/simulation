#!/bin/bash
#SBATCH --job-name=delete_stuff
#SBATCH --output=delete_stuff.out
#SBATCH --error=delete_stuff.err
#SBATCH --time=06:00:00
#SBATCH --nodes=1
#SBATCH --account=laionize
#SBATCH --partition=batch

rm -r /p/scratch/laionize/ploner1/production/tmpdir -v