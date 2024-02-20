import os
import argparse
import time
from datetime import datetime


if __name__ == '__main__':

    parser = argparse.ArgumentParser()

    parser.add_argument('-o','--output', type=str, required=True,
        help='output  EOS directory')

    parser.add_argument('-s','--shscript', type=str, default='run.sh',
        help='name of python script to execute')

    parser.add_argument('-t', '--toys', type=int, default=1,
        help='number of toys to be processed')

    parser.add_argument('-n', '--nevents', type=int, default=1000,
        help='number of toys to be processed')

    parser.add_argument('-p', '--process', type=str, default='WJetsToLNu_13TeV-madgraphMLM-pythia8',
        help='name of the process to generate')

    parser.add_argument('--seed', default=None,
        help='seed for simulation')

    # eosdir = '/eos/cms/store/cmst3/user/egovorko/simulation/'
    parser.add_argument('--eosdir', default='./',
        help='path to the shared simulation folder')

    parser.add_argument('-l','--local', action='store_true',
        help='if to be run locally')

    args = parser.parse_args()

    # folder to save the outputs of the sh script
    outputdir = f'{args.output}/'
    os.system(f'mkdir -p {outputdir}')
    print(f'Created output directory {outputdir}')

    # folder to save the outputs of each condor job (file.out, file.log, file.err)
    label = f'{args.output.split("/")[-1]}_{args.process}_{args.nevents}_{time.time()}'
    os.system(f'mkdir -p {label}')
    print(f'Created Condor output directory {label}')

    # change permission to the submission folder so that we could copy it
    os.system(f'chmod a+x {os.getcwd()}')

    if args.local:
        os.system(f'apptainer exec \
            --bind {outputdir}:/output \
            --bind {args.eosdir}:/simulation \
            --nv /cvmfs/unpacked.cern.ch/registry.hub.docker.com/jmduarte/mapyde:latest \
            sh /simulation/{args.shscript} {args.process} {args.nevents} 42 /output /simulation\n')
    else:
        for i in range(args.toys):

            # define job label and generation seed
            joblabel = f'{label}/{i}'
            seed = datetime.now().microsecond+datetime.now().second+datetime.now().minute \
                if not args.seed else args.seed

            # src file
            script_src = open(f'{joblabel}.src', 'w')
            script_src.write('#!/bin/bash\n')
            script_src.write(f'apptainer exec \
                --bind {outputdir}:/output \
                --bind {args.eosdir}:/simulation \
                --nv /cvmfs/unpacked.cern.ch/registry.hub.docker.com/jmduarte/mapyde:latest \
                sh /simulation/{args.shscript} {args.process} {args.nevents} {seed} /output /simulation\n')

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
