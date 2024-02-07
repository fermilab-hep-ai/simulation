#!/bin/bash

proc=$1
nevts=$2
seed=$3
outdir=$4

apptainer exec --bind $outdir --nv /cvmfs/unpacked.cern.ch/registry.hub.docker.com/jmduarte/mapyde:latest sh run.sh $proc $nevts $seed $outdir