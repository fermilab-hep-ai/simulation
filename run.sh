#!/bin/bash

set -x

workdir=$(pwd)

echo "workdir: $workdir"
echo "args: $@"

proc=$1
nevts=$2
seed=$3
outdir=$4


# run MadGraph event generation
mkdir -p ${outdir}/${proc}/
cp ./processes/proc_${proc}.dat ${outdir}/${proc}/proc_${proc}.dat
sed -i -e "s@_OUTDIR_@$outdir@g" ${outdir}/${proc}/proc_${proc}.dat
/usr/local/MG5_aMC_v3_5_1/bin/mg5_aMC ${outdir}/${proc}/proc_${proc}.dat

cp ./cards/* ${outdir}/${proc}/Cards/
if test -f ./processes/run_${proc}.dat; then
  cp ./processes/run_${proc}.dat ${outdir}/${proc}/Cards/run_card.dat
fi

sed -i -e "s@_NEVENTS_@$nevts@g" ${outdir}/${proc}/Cards/run_card.dat
sed -i -e "s@_NEVENTS_@$nevts@g" ${outdir}/${proc}/Cards/launch.dat
sed -i -e "s@_PileUpFile_@$workdir/MinBias_100k.pileup@g" ${outdir}/${proc}/Cards/delphes_card.dat
sed -i -e "s@_ISEED_@$seed@g" ${outdir}/${proc}/Cards/run_card.dat

${outdir}/${proc}/bin/madevent ${outdir}/${proc}/Cards/launch.dat
# make validation plots
# python3 ./make_plots.py -p ${outdir}/${proc}/