#!/bin/bash

set -x

workdir=$(pwd)

echo "workdir: $workdir"
echo "args: $@"

proc=$1
nevts=$2
seed=$3


# run MadGraph event generation

${MADGRAPH}/bin/mg5_aMC ./processes/proc_${proc}.dat

cp ./cards/* ./events/${proc}/Cards/

sed -i -e "s@_NEVENTS_@$nevts@g" ./events/${proc}/Cards/run_card.dat
sed -i -e "s@_NEVENTS_@$nevts@g" ./events/${proc}/Cards/launch.dat
sed -i -e "s@_PileUpFile_@$workdir/MinBias_100k.pileup@g" ./events/${proc}/Cards/delphes_card.dat
sed -i -e "s@_ISEED_@$seed@g" ./events/${proc}/Cards/run_card.dat

events/${proc}/bin/madevent ./events/${proc}/Cards/launch.dat

# make validation plots
python ./make_plots.py -p ./events/${proc}/
