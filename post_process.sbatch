#!/bin/bash
#SBATCH --job-name=post_process
#SBATCH --output=post_process.out
#SBATCH --error=post_process.err
#SBATCH --time=06:00:00
#SBATCH --nodes=1
#SBATCH --account=laionize
#SBATCH --partition=batch

python3 -u post_process.py /p/scratch/laionize/ploner1/full_production_1percent