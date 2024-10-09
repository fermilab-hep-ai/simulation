import os
import argparse
import csv

def submit_to_slurm(process, nevents, seed, outdir, simdir, istest):

    # create outdir
    outdir = os.path.realpath(outdir)

    # folder to save the outputs of each condor job (file.out, file.log, file.err)
    label = f'{process}-{nevents}-{seed}'
    os.makedirs(os.path.join("logs", label), exist_ok=True)
    log_path = os.path.realpath(os.path.join("logs", label))
    print(f"Created Slurm output directory {label}")

    script_slurm = open(f'{log_path}/{label}.sbatch', 'w')
    script_slurm.write(f'#!/bin/bash\n')
    script_slurm.write(f'#SBATCH --job-name={label}\n')
    script_slurm.write(f'#SBATCH --requeue\n')
    script_slurm.write(f'#SBATCH --output={log_path}/{label}.out\n')
    script_slurm.write(f'#SBATCH --error={log_path}/{label}.err\n')
    script_slurm.write(f'#SBATCH --time=3:00:00\n')
    script_slurm.write(f'#SBATCH --mem=4G\n')
    script_slurm.write(f'#SBATCH --nodes=1\n')
    script_slurm.write(f'#SBATCH --ntasks-per-node=2\n')
    script_slurm.write(f'#SBATCH --cpus-per-task=1\n')
    script_slurm.write(f'#SBATCH --partition=main\n')

    # load environment in cluster which supports singularity
    script_slurm.write(f'module purge\n')
    script_slurm.write(f'module load singularity/3.1.0\n')


    script_slurm.write(f"mkdir -p {outdir}/{label}\n")
    script_slurm.write("if [ $? -eq 0 ]; then\n")
    script_slurm.write("  echo create output directory succeeded\n")
    script_slurm.write("else\n")
    script_slurm.write("  echo create output directory failed\n")
    script_slurm.write("  exit 1\n")
    script_slurm.write("fi\n") 

    # download docker image from https://registry.hub.docker.com/r/jmduarte/mapyde
    # replace path to sif file
    script_slurm.write(f"singularity exec --bind {simdir} /scratch/rd804/mapyde_latest.sif {simdir}/run.sh {process} {nevents} {seed} {simdir} {istest}\n")
    
    
    script_slurm.write(f"mv outdir/* {outdir}/{label}\n")
    # for a safe version of cp for eos, comment the line above and uncomment the line below
    # script_slurm.write(f"xrdcp -r outdir/* {outdir}/{label}\n")

    script_slurm.close()

    # change permission
    os.system(f'chmod a+x {log_path}/{label}.sbatch')
    os.system(f'chmod a+x {simdir}/run.sh')

    # slurm file submission
    os.system(f'sbatch {log_path}/{label}.sbatch')  

if __name__ == '__main__':

    parser = argparse.ArgumentParser()

    parser.add_argument('-o','--outdir', type=str, required=True,
        help='output EOS directory')

    parser.add_argument('-n', '--nevents', type=int, default=1000,
        help='number of events to be processed')

    parser.add_argument('-p', '--process', type=str, default='WJetsToLNu_13TeV-madgraphMLM-pythia8',
        help='name of the process to generate')

    parser.add_argument('--seed', default=0,
        help='seed for simulation')

    parser.add_argument('--simdir', default=os.getcwd(),
        help='path to the shared simulation folder')

    parser.add_argument('--csv', default=None,
        help='path to the jobs.csv to use')

    parser.add_argument('-t','--test', action='store_true',
        help='if testing mode (timing and plots returned)')
    args = parser.parse_args()

    # change permission to the submission folder so that we could copy it
    os.system(f'chmod a+x {os.getcwd()}')

    if args.csv:
        with open(args.csv, 'r') as csvfile:
            reader = csv.reader(csvfile, delimiter=',')
            reader.__next__()
            for process, nevents, seed in reader:
                submit_to_slurm(process, int(nevents), int(seed), args.outdir, args.simdir, args.test)
    else:
        submit_to_slurm(args.process, args.nevents, args.seed, args.outdir, args.simdir, args.test)
