import os
import argparse
import csv

def submit_to_condor(process, nevents, seed, outdir, simdir, istest):

    # create outdir
    outdir = os.path.realpath(outdir)

    # folder to save the outputs of each condor job (file.out, file.log, file.err)
    label = f'{process}-{nevents}-{seed}'
    os.makedirs(os.path.join("logs", label), exist_ok=True)
    log_path = os.path.realpath(os.path.join("logs", label))
    print(f"Created Condor output directory {label}")
    # src file
    script_src = open(f'{log_path}/{label}.src', 'w')

    script_src.write("#!/bin/bash\n")
    script_src.write("set -x\n")
    script_src.write(f"mkdir -p {outdir}/{label}\n")
    script_src.write("if [ $? -eq 0 ]; then\n")
    script_src.write("  echo create output directory succeeded\n")
    script_src.write("else\n")
    script_src.write("  echo create output directory failed\n")
    script_src.write("  exit 1\n")
    script_src.write("fi\n")   
    script_src.write(f"apptainer exec --bind {simdir} /cvmfs/unpacked.cern.ch/registry.hub.docker.com/jmduarte/mapyde:latest sh {simdir}/run.sh {process} {nevents} {seed} {simdir} {istest}\n")
    script_src.write(f"xrdcp -r outdir/* {outdir}/{label}\n") 
    script_src.write(f"xrdcp -r tmpdir {outdir}/{label}\n") 
    script_src.close()

    os.system(f'chmod a+x {log_path}/{label}.src')

    # condor file
    script_condor = open(f'{log_path}/{label}.condor', 'w')
    script_condor.write(f'executable = {log_path}/{label}.src\n')
    script_condor.write('universe = vanilla\n')
    script_condor.write('requirements = (Arch == "X86_64") && (OpSys == "LINUX") && (Machine =!= LastRemoteHost)\n')
    script_condor.write('request_cpus = 1\n')
    script_condor.write('request_memory = 4G\n')
    script_condor.write('request_disk = 20G\n')
    script_condor.write(f'output = {log_path}/{label}.out\n')
    script_condor.write(f'error = {log_path}/{label}.err\n')
    script_condor.write(f'log = {log_path}/{label}.log\n')
    script_condor.write(f'transfer_output_files=""\n')
    # script_condor.write('use_x509userproxy = true\n')
    script_condor.write('WhenToTransferOutput = ON_EXIT\n')
    script_condor.write('want_graceful_removal = true\n')
    script_condor.write('on_exit_remove = (ExitBySignal == False) && (ExitCode == 0)\n')
    script_condor.write('max_retries = 3\n')
    script_condor.write('+MaxRuntime = 500000\n')
    script_condor.write('queue\n')
    script_condor.close()

    # condor file submission
    os.system(f'condor_submit {log_path}/{label}.condor')

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
                submit_to_condor(process, int(nevents), int(seed), args.outdir, args.simdir, args.test)
    else:
        submit_to_condor(args.process, args.nevents, args.seed, args.outdir, args.simdir, args.test)
