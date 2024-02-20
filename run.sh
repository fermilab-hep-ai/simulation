#!/bin/bash

set -x

workdir=$(pwd)

echo "workdir: $workdir"
echo "args: $@"

proc=$1
nevts=$2
seed=$3
outdir=$4
simultaiondir=$5

# locate run cards
if [ ! -d ${simultaiondir}/processes/${proc} ]; then
  echo ${simultaiondir}/processes/${proc} " does not exist!"
  exit 1
fi

if [ ! -e ${simultaiondir}/processes/${proc}/${proc}_proc_card.dat ]; then
  echo ${simultaiondir}/processes/${proc}/${proc}_proc_card.dat " does not exist!"
  exit 1
fi

if [ ! -e ${simultaiondir}/processes/${proc}/${proc}_run_card.dat ]; then
  echo ${simultaiondir}/processes/${proc}/${proc}_run_card.dat " does not exist!"
  exit 1
fi


# run MadGraph event generation
mkdir -p ${outdir}/${proc}/
cp ${simultaiondir}/processes/${proc}/${proc}_proc_card.dat ${outdir}/${proc}/proc_card.dat
sed -i -e "s@_OUTDIR_@$outdir@g" ${outdir}/${proc}/proc_card.dat
/usr/local/MG5_aMC_v3_5_1/bin/mg5_aMC ${outdir}/${proc}/proc_card.dat

# write run cards
cp ${simultaiondir}/cards/* ${outdir}/${proc}/Cards/
cp ${simultaiondir}/processes/${proc}/${proc}_run_card.dat ${outdir}/${proc}/Cards/run_card.dat
if [ -e ${simultaiondir}/processes/${proc}/${proc}_cuts.f ]; then
  echo "copying custom cuts.f file"
  cp ${simultaiondir}/processes/${proc}/${proc}_cuts.f ${outdir}/${proc}/SubProcesses/cuts.f
fi

if [ -e ${simultaiondir}/processes/${proc}/${proc}_FKS_params.dat ]; then
  echo "copying custom FKS_params.dat file"
  cp ${simultaiondir}/processes/${proc}/${proc}_FKS_params.dat ${outdir}/${proc}/Cards/FKS_params.dat
fi

if [ -e ${simultaiondir}/processes/${proc}/${proc}_setscales.f ]; then
  echo "copying custom setscales.f file"
  cp ${simultaiondir}/processes/${proc}/${proc}_setscales.f ${outdir}/${proc}/SubProcesses/setscales.f
fi

if [ -e ${simultaiondir}/processes/${proc}/${proc}_reweight_xsec.f ]; then
  echo "copying custom reweight_xsec.f file"
  cp ${simultaiondir}/processes/${proc}/${proc}_reweight_xsec.f ${outdir}/${proc}/SubProcesses/reweight_xsec.f
fi

if [ -e ${simultaiondir}/processes/${proc}/${proc}_reweight_card.dat ]; then
  echo "copying custom reweight file"
  cp ${simultaiondir}/processes/${proc}/${proc}_reweight_card.dat ${outdir}/${proc}/Cards/reweight_card.dat
fi

if [ -e ${simultaiondir}/processes/${proc}/${proc}_param_card.dat ]; then
  echo "copying custom params file"
  cp ${simultaiondir}/processes/${proc}/${proc}_param_card.dat ${outdir}/${proc}/Cards/param_card.dat
fi

if [ -e ${simultaiondir}/processes/${proc}/${proc}_madspin_card.dat ]; then
  cp ${simultaiondir}/processes/${proc}/${proc}_madspin_card.dat ${outdir}/${proc}/Cards/madspin_card.dat
  sed -i -e "s@_OUTDIR_@$outdir/$proc@g" ${outdir}/${proc}/Cards/madspin_card.dat
fi

echo "set nevents ${nevts}" >> ${outdir}/${proc}/Cards/launchrun.dat
if [ -e ${simultaiondir}/processes/${proc}/${proc}_customizecards.dat ]; then
        cat ${simultaiondir}/processes/${proc}/${proc}_customizecards.dat | sed '/^$/d;/^#.*$/d' >> ${outdir}/${proc}/Cards/launchrun.dat
        echo "" >> ${outdir}/${proc}/Cards/launchrun.dat
fi
echo "done" >> ${outdir}/${proc}/Cards/launchrun.dat

sed -i -e "s@_NEVENTS_@$nevts@g" ${outdir}/${proc}/Cards/run_card.dat
sed -i -e "s@_PileUpFile_@$workdir/MinBias_100k.pileup@g" ${outdir}/${proc}/Cards/delphes_card.dat
sed -i -e "s@_ISEED_@$seed@g" ${outdir}/${proc}/Cards/run_card.dat

${outdir}/${proc}/bin/madevent ${outdir}/${proc}/Cards/launchrun.dat
# make validation plots
python3 ${simultaiondir}/make_plots.py -p ${outdir}/${proc}/