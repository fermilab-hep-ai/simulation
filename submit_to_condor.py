import os
import argparse
import time


if __name__ == '__main__':

    parser = argparse.ArgumentParser()

    parser.add_argument('-o','--output', type=str, required=True,
        help='output EOS directory')

    parser.add_argument('-t', '--toys', type=int, default=1,
        help='number of toys to be processed')

    parser.add_argument('-n', '--nevents', type=int, default=1000,
        help='number of toys to be processed')

    parser.add_argument('-p', '--process', type=str, default='WJetsToLNu_13TeV-madgraphMLM-pythia8',
        help='name of the process to generate')

    parser.add_argument('--seed', default=0,
        help='seed for simulation')

    parser.add_argument('--simdir', default=os.getcwd(),
        help='path to the shared simulation folder')

    parser.add_argument('-l','--local', action='store_true',
        help='if to be run locally')

    args = parser.parse_args()

    # folder to save the outputs of the sh script
    outputdir = os.path.realpath(args.output)
    simdir = os.path.realpath(args.simdir)
    os.system(f'mkdir -p {outputdir}')
    print(f'Created output directory {outputdir}')

    # change permission to the submission folder so that we could copy it
    os.system(f'chmod a+x {os.getcwd()}')

    # parse the paths to avoid double binding.
    binding_paths = os.path.commonpath([outputdir, simdir])
    if binding_paths == "/":
        binding_paths = f"{outputdir},{simdir}"
    print(f"Binding {binding_paths} to the container.")

    if args.local:
        os.system(f'apptainer exec \
            --bind {binding_paths}  \
            /cvmfs/unpacked.cern.ch/registry.hub.docker.com/jmduarte/mapyde:latest \
            sh {simdir}/run.sh {args.process} {args.nevents} {args.seed} {outputdir} {simdir}\n')
    else:
        # folder to save the outputs of each condor job (file.out, file.log, file.err)
        label = f'{args.output.split("/")[-1]}_{args.process}_{args.nevents}_{time.time()}'
        os.system(f'mkdir -p {label}')
        print(f'Created Condor output directory {label}')
        for i in range(args.toys):

            # define job label and generation seed
            joblabel = f'{label}/{i}'

            # src file
            script_src = open(f'{joblabel}.src', 'w')
            script_src.write('#!/bin/bash\n')
            script_src.write(f'apptainer exec \
                --bind {binding_paths} \
                /cvmfs/unpacked.cern.ch/registry.hub.docker.com/jmduarte/mapyde:latest \
                sh {simdir}/run.sh {args.process} {args.nevents} {args.seed} {outputdir} {simdir}\n')

            script_src.close()
            os.system(f'chmod a+x {joblabel}.src')

            # condor file
            script_condor = open(f'{joblabel}.condor', 'w')
            script_condor.write(f'executable = {joblabel}.src\n')
            script_condor.write('universe = vanilla\n')
            script_condor.write(f'output = {joblabel}.out\n')
            script_condor.write(f'error = {joblabel}.err\n')
            script_condor.write(f'log = {joblabel}.log\n')
            script_condor.write('+MaxRuntime = 500000\n')
            script_condor.write('queue\n')
            script_condor.close()

            # condor file submission
            os.system(f'condor_submit {joblabel}.condor')
