import os
import sys
import argparse
import csv

def submit_to_slurm(process, nevents, seed, outdir, simdir, istest):

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
    if nevents < 10001:
        script_slurm.write(f'#SBATCH --time=2:00:00\n')
    else:
        script_slurm.write(f'#SBATCH --time=6:00:00\n')
    script_slurm.write(f'#SBATCH --mem=4G\n')
    script_slurm.write(f'#SBATCH --nodes=1\n')
    script_slurm.write(f'#SBATCH --ntasks-per-node=1\n')
    script_slurm.write(f'#SBATCH --cpus-per-task=48\n')

    script_slurm.write(f'#SBATCH --account=laionize\n')
    if nevents < 10001:
        script_slurm.write(f'#SBATCH --partition=devel\n')
    else:
        script_slurm.write(f'#SBATCH --partition=batch\n')

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
 #   script_slurm.write(f"apptainer exec --bind {simdir} --bind {simdir}/models:/usr/local/MG5_aMC_v3_5_6/models container.sif {simdir}/run.sh {process} {nevents} {seed} {simdir} {outdir} {istest} {label}\n")
    script_slurm.write(f"apptainer exec --bind {simdir} --bind {simdir}/models:/usr/local/MG5_aMC_v3_5_8/models container.sif {simdir}/run.sh {process} {nevents} {seed} {simdir} {outdir} {istest} {label}\n")
    
    
    # script_slurm.write(f"mv outdir/{label}/* {outdir}/{label}\n")
    # script_slurm.write(f"rm -r outdir/{label}\n")
    # for a safe version of cp for eos, comment the line above and uncomment the line below
    # script_slurm.write(f"xrdcp -r outdir/* {outdir}/{label}\n")

    script_slurm.close()

    # change permission
    os.system(f'chmod a+x {log_path}/{label}.sbatch')
    os.system(f'chmod a+x {simdir}/run.sh')

    # slurm file submission
    os.system(f'sbatch {log_path}/{label}.sbatch')

def submit_one_parallel_job_to_slurm(slurmscript, process, nevents, seed, outdir, simdir, logdir, istest, label, cores=4):
    slurmscript.write(f"srun --exact --output={logdir}/{label}.out --error={logdir}/{label}.err -n 1 -c {cores} apptainer exec --bind {simdir} --bind {simdir}/models:/usr/local/MG5_aMC_v3_5_8/models container.sif {simdir}/run.sh {process} {nevents} {seed} {simdir} {outdir} {istest} {label} &\n")

def submit_multiple_jobs(csvfile, jobname, outdir, simdir, istest, cores_per_process=4, multithreading=False):
    """Submit multiple jobs to SLURM using a CSV file. Uses cores_per_process*n_processes cores in parallel."""

    # get absolute paths
    outdir = os.path.realpath(outdir)
    simdir = os.path.realpath(simdir)

    # read list of processes, nevents and seeds from csv file
    with open(csvfile, 'r') as csvfile:
        reader = csv.reader(csvfile, delimiter=',')
        reader.__next__()
        process_list = []
        nevents_list = []
        seed_list = []
        for process, nevents, seed in reader:
            process_list.append(process.strip())
            nevents_list.append(int(nevents.strip()))
            seed_list.append(int(seed.strip()))

    n_processes = len(process_list)
    print(f"Submitting {n_processes} processes to SLURM with {cores_per_process} cores per process.")

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
        submit_one_parallel_job_to_slurm(script_slurm, process, nevents, seed, outdir, simdir, log_path, istest, label, cores_per_process)
    

    # wait for all processes to finish
    script_slurm.write("wait\n")

    # close the script file
    script_slurm.close()

    # change permission
    os.system(f'chmod a+x {script_file}')
    os.system(f'chmod a+x {simdir}/run.sh')

    # slurm file submission
    os.system(f'sbatch {script_file}')




if __name__ == '__main__':

    parser = argparse.ArgumentParser()

    parser.add_argument('-o','--outdir', type=str, required=True,
        help='output directory for logs')

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

    parser.add_argument('-l','--label', type=str, default='test',
        help='label for the job, used for batch submissions with csv file')
    

    args = parser.parse_args()

    # change permission to the submission folder so that we could copy it
    os.system(f'chmod a+x {os.getcwd()}')

    if args.csv:
            #for process, nevents, seed in reader:
            #   submit_to_slurm(process, int(nevents), int(seed), args.outdir, args.simdir, args.test)
        submit_multiple_jobs(args.csv, args.label, args.outdir, args.simdir, args.test, cores_per_process=4, multithreading=1)

    else:
        submit_to_slurm(args.process, args.nevents, args.seed, args.outdir, args.simdir, args.test)
