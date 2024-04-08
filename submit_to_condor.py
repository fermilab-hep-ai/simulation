import os
import argparse
import csv

def submit_to_condor(process, nevents, seed, outdir, simdir, istest):

    # parse the paths to avoid double binding.
    binding_paths = os.path.commonpath([outdir, simdir])
    if binding_paths == "/":
        binding_paths = f"{outdir},{simdir}"

    # folder to save the outputs of each condor job (file.out, file.log, file.err)
    label = f'{process}-{nevents}-{seed}'
    os.system(f'mkdir -p logs/{label}')
    print(f'Created Condor output directory {label}')
    label = f'{simdir}/logs/{label}/{label}'
    # src file
    script_src = open(f'{label}.src', 'w')
    script_src.write('#!/bin/bash\n')
    script_src.write(f'apptainer exec \
        --bind {binding_paths} \
        /cvmfs/unpacked.cern.ch/registry.hub.docker.com/jmduarte/mapyde:latest \
        sh {simdir}/run.sh {process} {nevents} {seed} {outdir} {simdir} {istest}\n')

    script_src.close()
    os.system(f'chmod a+x {label}.src')

    # condor file
    script_condor = open(f'{label}.condor', 'w')
    script_condor.write(f'executable = {label}.src\n')
    script_condor.write('universe = vanilla\n')
    script_condor.write('requirements = (Arch == "X86_64") && (OpSys == "LINUX")\n')
    script_condor.write('request_cpus = 1\n')
    script_condor.write('request_memory = 4G\n')
    script_condor.write('request_disk = 10000000\n')
    script_condor.write(f'output = {label}.out\n')
    script_condor.write(f'error = {label}.err\n')
    script_condor.write(f'log = {label}.log\n')
    script_condor.write('+MaxRuntime = 500000\n')
    script_condor.write('queue\n')
    script_condor.close()

    # condor file submission
    os.system(f'condor_submit {label}.condor')

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

    parser.add_argument('-l','--local', action='store_true',
        help='if to be run locally')

    parser.add_argument('-t','--test', action='store_true',
        help='if testing mode (timing and plots returned)')
    args = parser.parse_args()

    # change permission to the submission folder so that we could copy it
    os.system(f'chmod a+x {os.getcwd()}')

    if args.local:

        # folder to save the outputs of the sh script
        outdir = os.path.realpath(args.outdir)
        simdir = os.path.realpath(args.simdir)
        os.system(f'mkdir -p {outdir}')
        print(f'Created output directory {outdir}')

        # parse the paths to avoid double binding.
        binding_paths = os.path.commonpath([outdir, simdir])
        if binding_paths == "/":
            binding_paths = f"{outdir},{simdir}"
        print(f"Binding {binding_paths} to the container.")

        os.system(f'apptainer exec \
            --bind {binding_paths}  \
            /cvmfs/unpacked.cern.ch/registry.hub.docker.com/jmduarte/mapyde:latest \
            sh {simdir}/run.sh {args.process} {args.nevents} {args.seed} {outdir} {simdir} {args.test}\n')

    elif args.csv:
        with open(args.csv, 'r') as csvfile:
            reader = csv.reader(csvfile, delimiter=',')
            reader.__next__()
            for process, nevents, seed in reader:
                submit_to_condor(process, int(nevents), int(seed), args.outdir, args.simdir, args.test)
    else:
        submit_to_condor(args.process, args.nevents, args.seed, args.outdir, args.simdir, args.test)
