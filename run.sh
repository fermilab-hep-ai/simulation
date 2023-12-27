#!/bin/bash

set -x

workdir=$(pwd)

echo "workdir: $workdir"
echo "args: $@"

proc=$1
nevts=$2
seed=$3


# run MadGraph event generation

/usr/local/MG5_aMC_v3_5_1/bin/mg5_aMC ./processes/proc_${proc}.dat

cp ./cards/* ./events/${proc}/Cards/
if test -f ./processes/run_${proc}.dat; then
  cp ./processes/run_${proc}.dat ./events/${proc}/Cards/run_card.dat
fi

sed -i -e "s@_NEVENTS_@$nevts@g" ./events/${proc}/Cards/run_card.dat
sed -i -e "s@_NEVENTS_@$nevts@g" ./events/${proc}/Cards/launch.dat
sed -i -e "s@_PileUpFile_@$workdir/MinBias_100k.pileup@g" ./events/${proc}/Cards/delphes_card.dat
sed -i -e "s@_ISEED_@$seed@g" ./events/${proc}/Cards/run_card.dat

events/${proc}/bin/madevent ./events/${proc}/Cards/launch.dat
