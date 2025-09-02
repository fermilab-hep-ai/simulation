import os
import sys
import argparse
import csv

def submit_one_job_to_slurm(process, nevents, seed, outdir, simdir, istest):

    # create outdir
    outdir = os.path.realpath(outdir)

    # folder to save the outputs of each slurm job (file.out, file.log, file.err)
    label = f'{process}-{nevents}-{seed}'
    os.makedirs(os.path.join("logs", label), exist_ok=True)
    log_path = os.path.realpath(os.path.join("logs", label))
    print(f"Created Slurm output directory {label}")

    script_slurm = open(f'{log_path}/{label}.sbatch', 'w')
    script_slurm.write(f'#!/bin/bash\n')
    script_slurm.write(f'#SBATCH --job-name={label}\n')
    #script_slurm.write(f'#SBATCH --requeue\n')
    script_slurm.write(f'#SBATCH --output={log_path}/{label}.out\n')
    script_slurm.write(f'#SBATCH --error={log_path}/{label}.err\n')
    if nevents < 10000:
        script_slurm.write(f'#SBATCH --time=2:00:00\n')
    else:
        script_slurm.write(f'#SBATCH --time=6:00:00\n')
    script_slurm.write(f'#SBATCH --mem=4G\n')
    script_slurm.write(f'#SBATCH --nodes=1\n')
    script_slurm.write(f'#SBATCH --ntasks-per-node=1\n')
    script_slurm.write(f'#SBATCH --cpus-per-task=48\n')

    script_slurm.write(f'#SBATCH --account=laionize\n')
    if nevents < 10000:
        script_slurm.write(f'#SBATCH --partition=devel\n')
    else:
        script_slurm.write(f'#SBATCH --partition=batch\n')

    # load environment in cluster which supports singularity
    script_slurm.write(f'module purge\n')
    script_slurm.write(f'module load singularity/3.1.0\n')
    script_slurm.write(f'module load GCC/13.3.0\n')


    script_slurm.write(f"mkdir -p {outdir}/{label}\n")
    script_slurm.write("if [ $? -eq 0 ]; then\n")
    script_slurm.write("  echo create output directory succeeded\n")
    script_slurm.write("else\n")
    script_slurm.write("  echo create output directory failed\n")
    script_slurm.write("  exit 1\n")
    script_slurm.write("fi\n") 

    # download docker image from https://registry.hub.docker.com/r/jmduarte/mapyde
    # replace path to sif file
 #   script_slurm.write(f"apptainer exec --bind {simdir} --bind {simdir}/models:/usr/local/MG5_aMC_v3_5_6/models container.sif {simdir}/run.sh {process} {nevents} {seed} {simdir} {outdir} {istest} {label}\n")
    if process in ("minbias", "upsilon_to_leptons"):
        script_slurm.write(f"{simdir}/run_minbias_upsilon.sh {process} {nevents} {seed} {simdir} {outdir} {istest} {label}\n")
    else:
        script_slurm.write(f"apptainer exec --bind {simdir} container.sif {simdir}/run.sh {process} {nevents} {seed} {simdir} {outdir} {istest} {label}\n")


    # script_slurm.write(f"mv outdir/{label}/* {outdir}/{label}\n")
    # script_slurm.write(f"rm -r outdir/{label}\n")
    # for a safe version of cp for eos, comment the line above and uncomment the line below
    # script_slurm.write(f"xrdcp -r outdir/* {outdir}/{label}\n")

    script_slurm.close()

    # change permission
    os.system(f'chmod a+x {log_path}/{label}.sbatch')
    if process in ("minbias", "upsilon_to_leptons"):
        os.system(f'chmod a+x {simdir}/run_minbias_upsilon.sh')
    else:
        os.system(f'chmod a+x {simdir}/run.sh')

    # slurm file submission
    os.system(f'sbatch {log_path}/{label}.sbatch')

def one_parallel_slurm_job_command(slurmscript, process, nevents, seed, outdir, simdir, logdir, istest, label, cores=4):
    """Slurm command for a single job to run on a node, can be called multiple times for parallel jobs."""
    if process in ("minbias", "upsilon_to_leptons"):
        slurmscript.write(f"srun --exact --output={logdir}/{label}.out --error={logdir}/{label}.err -n 1 -c {cores} {simdir}/run_minbias_upsilon.sh {process} {nevents} {seed} {simdir} {outdir} {istest} {label} &\n")
    else:
        slurmscript.write(f"srun --exact --output={logdir}/{label}.out --error={logdir}/{label}.err -n 1 -c {cores} apptainer exec --bind {simdir} container.sif {simdir}/run.sh {process} {nevents} {seed} {simdir} {outdir} {istest} {label} &\n")

def read_csv_file(csvfile):
    """Read a CSV file and return a list of processes, nevents, and seeds."""
    with open(csvfile, 'r') as csvfile:
        reader = csv.reader(csvfile, delimiter=',')
        reader.__next__()  # skip header
        process_list = []
        nevents_list = []
        seed_list = []
        for process, nevents, seed in reader:
            process_list.append(process.strip())
            nevents_list.append(int(nevents.strip()))
            seed_list.append(int(seed.strip()))
    return process_list, nevents_list, seed_list

def submit_multiple_jobs(process_list, nevents_list, seed_list, jobname, outdir, simdir, istest, cores_per_process=8, multithreading=True):
    """Submit multiple jobs to SLURM given a list of jobs. Uses cores_per_process*n_processes cores in parallel."""

    # get absolute paths
    outdir = os.path.realpath(outdir)
    simdir = os.path.realpath(simdir)
    
    n_processes = len(process_list)

    if n_processes*cores_per_process > 96:
        print(f"Warning: {n_processes*cores_per_process} cores is more than 96, which is too much for a single node. Please split the jobs into smaller batches.")
        sys.exit("Exiting script due to excessive resource request.")

    # create label list with all processes, nevents and seeds for output folders
    labels = [f'{process}-{nevents}-{seed}' for process, nevents, seed in zip(process_list, nevents_list, seed_list)]

    # create output folders for logs for each label in labels
    log_paths = []
    for label in labels:
        os.makedirs(os.path.join("logs", label), exist_ok=True)
        log_path = os.path.realpath(os.path.join("logs", label))
        log_paths.append(log_path)
        print(f"Created Slurm output directory {label}")

    # create a single slurm script for all processes
    os.makedirs(f"{simdir}/logs/batchlogs", exist_ok=True)
    script_file = os.path.join(f"{simdir}/logs/batchlogs", f'{jobname}.sbatch')
    script_slurm = open(script_file, 'w')
    script_slurm.write(f'#!/bin/bash\n')
    script_slurm.write(f'#SBATCH --job-name={jobname}\n')
    script_slurm.write(f'#SBATCH --output={simdir}/logs/batchlogs/{jobname}.out\n')
    script_slurm.write(f'#SBATCH --error={simdir}/logs/batchlogs/{jobname}.err\n')
    if max(nevents_list) < 7501:
        script_slurm.write(f'#SBATCH --time=2:00:00\n')
    else:
        script_slurm.write(f'#SBATCH --time=6:00:00\n')
    script_slurm.write(f'#SBATCH --mem=90G\n')
    script_slurm.write(f'#SBATCH --nodes=1\n')
    script_slurm.write(f'#SBATCH --ntasks-per-node={n_processes}\n')
    script_slurm.write(f'#SBATCH --cpus-per-task={cores_per_process}\n')
    if multithreading:
        script_slurm.write(f'#SBATCH --threads-per-core=2\n')
    else:
        script_slurm.write(f'#SBATCH --threads-per-core=1\n')
    script_slurm.write(f'#SBATCH --account=laionize\n')
    if max(nevents_list) < 7501:
        script_slurm.write(f'#SBATCH --partition=devel\n')
    else:
        script_slurm.write(f'#SBATCH --partition=batch\n')
    #script_slurm.write(f'module purge\n')
    #script_slurm.write(f'module load singularity/3.1.0\n')

    # create output folders for data for each label in labels
    for label in labels:
        script_slurm.write(f"mkdir -p {outdir}/{label}\n")
        script_slurm.write("if [ $? -eq 0 ]; then\n")
        script_slurm.write("  echo create output directory succeeded\n")
        script_slurm.write("else\n")
        script_slurm.write("  echo create output directory failed\n")
        script_slurm.write("  exit 1\n")
        script_slurm.write("fi\n")

    # submit each process in parallel
    for process, nevents, seed, label, log_path in zip(process_list, nevents_list, seed_list, labels, log_paths):
        one_parallel_slurm_job_command(script_slurm, process, nevents, seed, outdir, simdir, log_path, istest, label, cores_per_process)
    

    # wait for all processes to finish
    script_slurm.write("wait\n")

    # close the script file
    script_slurm.close()

    # change permission
    os.system(f'chmod a+x {script_file}')
    if process in ("minbias", "upsilon_to_leptons"):
        os.system(f'chmod a+x {simdir}/run_minbias_upsilon.sh')
    else:
        os.system(f'chmod a+x {simdir}/run.sh')

    # slurm file submission
    os.system(f'sbatch {script_file}')
    
def batch_submission_from_csv(args):
    """Read a CSV file and call submit_multiple_jobs appropriately using the correct parallelization and job distribution."""
    process_list, nevents_list, seed_list = read_csv_file(args.csv)
    high_parallel = args.high_parallel
    n_processes = len(process_list)
    if n_processes <= 12:
        print(f"Submitting {n_processes} processes to SLURM")
        submit_multiple_jobs(process_list, nevents_list, seed_list, args.label, args.outdir, args.simdir, args.test, cores_per_process=8, multithreading=True)
    elif n_processes <= 24 and high_parallel:
        print(f"Submitting {n_processes} processes to SLURM")
        submit_multiple_jobs(process_list, nevents_list, seed_list, args.label, args.outdir, args.simdir, args.test, cores_per_process=4, multithreading=1)
    elif high_parallel:
        print(f"Dividing {n_processes} processes into smaller batches of max 24 processes each")
        n_batches = (n_processes + 23) // 24
        for i in range(n_batches):
            start = i * 24
            end = min((i + 1) * 24, n_processes)
            batch_processes = process_list[start:end]
            batch_nevents = nevents_list[start:end]
            batch_seeds = seed_list[start:end]
            print(f"Submitting batch {i+1}/{n_batches} to SLURM with {len(batch_processes)} processes and 4 cores per process.")
            submit_multiple_jobs(batch_processes, batch_nevents, batch_seeds, f"{args.label}_batch_{i+1}", args.outdir, args.simdir, args.test, cores_per_process=4, multithreading=True)
        print(f"Submitted {n_processes} processes to SLURM using {args.csv}.")
    else:
        print(f"Dividing {n_processes} processes into smaller batches of max 12 processes each")
        n_batches = (n_processes + 11) // 12
        for i in range(n_batches):
            start = i * 12
            end = min((i + 1) * 12, n_processes)
            batch_processes = process_list[start:end]
            batch_nevents = nevents_list[start:end]
            batch_seeds = seed_list[start:end]
            print(f"Submitting batch {i+1}/{n_batches} to SLURM with {len(batch_processes)} processes and 8 cores per process.")
            submit_multiple_jobs(batch_processes, batch_nevents, batch_seeds, f"{args.label}_batch_{i+1}", args.outdir, args.simdir, args.test, cores_per_process=8, multithreading=True)
        print(f"Submitted {n_processes} processes to SLURM using {args.csv}.")


if __name__ == '__main__':

    parser = argparse.ArgumentParser()

    parser.add_argument('-o','--outdir', type=str, required=True,
        help='output directory of the jobs')

    parser.add_argument('-n', '--nevents', type=int, default=1000,
        help='number of events to be processed, if ordering a single job')
    
    parser.add_argument('-s', '--seed', default=0,
        help='seed for simulation, if ordering a single job')

    parser.add_argument('-p', '--process', type=str, default='WJetsToLNu_13TeV-madgraphMLM-pythia8',
        help='name of the process to generate, if ordering a single job')

    parser.add_argument('-csv', '--csv', default=None,
        help='path to the .csv containg job submissions to be made, if ordering multiple jobs')
    
    parser.add_argument('--simdir', default=os.getcwd(),
        help='path to the shared simulation folder')

    parser.add_argument('-t','--test', action='store_true',
        help='if testing mode (timing and plots returned)')

    parser.add_argument('-l','--label', type=str, default='test',
        help='label for the job, used for batch submissions with csv file')
    
    parser.add_argument('-hp', '--high_parallel', action='store_true',
        help='enable high parallel mode for multiple jobs, which allows for 24 processes per batch instead of 12.')

    args = parser.parse_args()

    # change permission to the submission folder so that we could copy it
    os.system(f'chmod a+x {os.getcwd()}')

    if args.csv:
        batch_submission_from_csv(args)                

    else:
        submit_one_job_to_slurm(args.process, args.nevents, args.seed, args.outdir, args.simdir, args.test)
        
    
    
    
