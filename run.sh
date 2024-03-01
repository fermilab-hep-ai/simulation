#!/bin/bash

set -x

proc=$1
nevts=$2
seed=$3
outdir=$4
simdir=$5

mkdir -p $outdir/tmp-${proc}-${nevts}-${seed}
cd $outdir/tmp-${proc}-${nevts}-${seed}

workdir=$(pwd)
proc_outdir="${outdir}/${proc}-${nevts}-${seed}"
echo $proc_outdir

echo "workdir: $workdir"
echo "args: $@"

# locate run cards
if [ ! -d ${simdir}/processes/${proc} ]; then
  echo ${simdir}/processes/${proc} " does not exist!"
  exit 1
fi

if [ ! -e ${simdir}/processes/${proc}/${proc}_proc_card.dat ]; then
  echo ${simdir}/processes/${proc}/${proc}_proc_card.dat " does not exist!"
  exit 1
fi

if [ ! -e ${simdir}/processes/${proc}/${proc}_run_card.dat ]; then
  echo ${simdir}/processes/${proc}/${proc}_run_card.dat " does not exist!"
  exit 1
fi


# run MadGraph event generation
mkdir -p ${proc_outdir}/
rm -r ${proc_outdir}/*
cp ${simdir}/processes/${proc}/${proc}_proc_card.dat ${proc_outdir}/proc_card.dat
sed -i -e "s@_OUTDIR_@$proc_outdir@g" ${proc_outdir}/proc_card.dat
/usr/local/MG5_aMC_v3_5_3/bin/mg5_aMC ${proc_outdir}/proc_card.dat

# write run cards
cp ${simdir}/cards/* ${proc_outdir}/Cards/
cp ${simdir}/processes/${proc}/${proc}_run_card.dat ${proc_outdir}/Cards/run_card.dat
if [ -e ${simdir}/processes/${proc}/${proc}_cuts.f ]; then
  echo "copying custom cuts.f file"
  cp ${simdir}/processes/${proc}/${proc}_cuts.f ${proc_outdir}/SubProcesses/cuts.f
fi

if [ -e ${simdir}/processes/${proc}/${proc}_FKS_params.dat ]; then
  echo "copying custom FKS_params.dat file"
  cp ${simdir}/processes/${proc}/${proc}_FKS_params.dat ${proc_outdir}/Cards/FKS_params.dat
fi

if [ -e ${simdir}/processes/${proc}/${proc}_setscales.f ]; then
  echo "copying custom setscales.f file"
  cp ${simdir}/processes/${proc}/${proc}_setscales.f ${proc_outdir}/SubProcesses/setscales.f
fi

if [ -e ${simdir}/processes/${proc}/${proc}_reweight_xsec.f ]; then
  echo "copying custom reweight_xsec.f file"
  cp ${simdir}/processes/${proc}/${proc}_reweight_xsec.f ${proc_outdir}/SubProcesses/reweight_xsec.f
fi

if [ -e ${simdir}/processes/${proc}/${proc}_reweight_card.dat ]; then
  echo "copying custom reweight file"
  cp ${simdir}/processes/${proc}/${proc}_reweight_card.dat ${proc_outdir}/Cards/reweight_card.dat
fi

if [ -e ${simdir}/processes/${proc}/${proc}_param_card.dat ]; then
  echo "copying custom params file"
  cp ${simdir}/processes/${proc}/${proc}_param_card.dat ${proc_outdir}/Cards/param_card.dat
fi

if [ -e ${simdir}/processes/${proc}/${proc}_madspin_card.dat ]; then
  cp ${simdir}/processes/${proc}/${proc}_madspin_card.dat ${proc_outdir}/Cards/madspin_card.dat
  sed -i -e "s@_OUTDIR_@$proc_outdir@g" ${proc_outdir}/Cards/madspin_card.dat
fi

echo "set nevents ${nevts}" >> ${proc_outdir}/Cards/launchrun.dat
if [ -e ${simdir}/processes/${proc}/${proc}_customizecards.dat ]; then
        cat ${simdir}/processes/${proc}/${proc}_customizecards.dat | sed '/^$/d;/^#.*$/d' >> ${proc_outdir}/Cards/launchrun.dat
        echo "" >> ${proc_outdir}/Cards/launchrun.dat
fi
echo "done" >> ${proc_outdir}/Cards/launchrun.dat

sed -i -e "s@_NEVENTS_@$nevts@g" ${proc_outdir}/Cards/run_card.dat
sed -i -e "s@_PileUpFile_@$simdir/MinBias_100k.pileup@g" ${proc_outdir}/Cards/delphes_card.dat
sed -i -e "s@_ISEED_@$seed@g" ${proc_outdir}/Cards/run_card.dat

${proc_outdir}/bin/madevent ${proc_outdir}/Cards/launchrun.dat
# make validation plots
python3 ${simdir}/make_plots.py -p ${proc_outdir}/ -v ${simdir}/validation_config.yaml
# clean up tmp directories
rm -r $outdir/tmp-${proc}-${nevts}-${seed}
# remove other artifacts
cd ${proc_outdir}
mv Events/*/*.root .
ls . | grep -xvi "validation_plots\|.*root" | xargs rm -r
# all done
echo Done!