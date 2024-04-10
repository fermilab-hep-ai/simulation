#!/bin/bash

set -x

proc=$1
nevts=$2
seed=$3
outdir=$4
simdir=$5
is_test=$6

if [ "$is_test" = "True" ]; then
   start_time="$(date -u +%s)"
fi
workdir=$(pwd)
tmp="${workdir}/tmp"
echo $tmp

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
if [ "$is_test" = "True" ]; then
    start_time_madgraph="$(date -u +%s)"
fi
mkdir -p ${tmp}/
rm -r ${tmp}/*
cp ${simdir}/processes/${proc}/${proc}_proc_card.dat ${tmp}/proc_card.dat
sed -i -e "s@_OUTDIR_@$tmp@g" ${tmp}/proc_card.dat
/usr/local/MG5_aMC_v3_5_3/bin/mg5_aMC ${tmp}/proc_card.dat
if [ "$is_test" = "True" ]; then
    end_time_madgraph="$(date -u +%s)"
fi
# write run cards
cp ${simdir}/cards/* ${tmp}/Cards/
cp ${simdir}/processes/${proc}/${proc}_run_card.dat ${tmp}/Cards/run_card.dat
if [ -e ${simdir}/processes/${proc}/${proc}_cuts.f ]; then
  echo "copying custom cuts.f file"
  cp ${simdir}/processes/${proc}/${proc}_cuts.f ${tmp}/SubProcesses/cuts.f
fi

if [ -e ${simdir}/processes/${proc}/${proc}_FKS_params.dat ]; then
  echo "copying custom FKS_params.dat file"
  cp ${simdir}/processes/${proc}/${proc}_FKS_params.dat ${tmp}/Cards/FKS_params.dat
fi

if [ -e ${simdir}/processes/${proc}/${proc}_setscales.f ]; then
  echo "copying custom setscales.f file"
  cp ${simdir}/processes/${proc}/${proc}_setscales.f ${tmp}/SubProcesses/setscales.f
fi

if [ -e ${simdir}/processes/${proc}/${proc}_reweight_xsec.f ]; then
  echo "copying custom reweight_xsec.f file"
  cp ${simdir}/processes/${proc}/${proc}_reweight_xsec.f ${tmp}/SubProcesses/reweight_xsec.f
fi

if [ -e ${simdir}/processes/${proc}/${proc}_reweight_card.dat ]; then
  echo "copying custom reweight file"
  cp ${simdir}/processes/${proc}/${proc}_reweight_card.dat ${tmp}/Cards/reweight_card.dat
fi

if [ -e ${simdir}/processes/${proc}/${proc}_param_card.dat ]; then
  echo "copying custom params file"
  cp ${simdir}/processes/${proc}/${proc}_param_card.dat ${tmp}/Cards/param_card.dat
fi

if [ -e ${simdir}/processes/${proc}/${proc}_madspin_card.dat ]; then
  cp ${simdir}/processes/${proc}/${proc}_madspin_card.dat ${tmp}/Cards/madspin_card.dat
  sed -i -e "s@_OUTDIR_@$tmp@g" ${tmp}/Cards/madspin_card.dat
fi

echo "set nevents ${nevts}" >> ${tmp}/Cards/launchrun.dat
if [ -e ${simdir}/processes/${proc}/${proc}_customizecards.dat ]; then
        cat ${simdir}/processes/${proc}/${proc}_customizecards.dat | sed '/^$/d;/^#.*$/d' >> ${tmp}/Cards/launchrun.dat
        echo "" >> ${tmp}/Cards/launchrun.dat
fi
echo "done" >> ${tmp}/Cards/launchrun.dat

sed -i -e "s@_NEVENTS_@$nevts@g" ${tmp}/Cards/run_card.dat
sed -i -e "s@_PileUpFile_@$simdir/MinBias_100k.pileup@g" ${tmp}/Cards/delphes_card.dat
sed -i -e "s@_ISEED_@$seed@g" ${tmp}/Cards/run_card.dat

if [ "$is_test" = "True" ]; then
    start_time_pythia_delphes="$(date -u +%s)"
fi
${tmp}/bin/madevent ${tmp}/Cards/launchrun.dat
if [ "$is_test" = "True" ]; then
    end_time_pythia_delphes="$(date -u +%s)"
fi

if [ "$is_test" = "True" ]; then
    # make validation plots
    python3 ${simdir}/make_plots.py -p ${tmp}/ -v ${simdir}/validation_config.yaml

    # timing monitor dump
    end_time="$(date -u +%s)"
    elapsed_madgraph="$(($end_time_madgraph-$start_time_madgraph))"
    elapsed_pythia_delphes="$(($end_time_pythia_delphes-$start_time_pythia_delphes))"
    elapsed_total="$(($end_time-$start_time))"
    echo "Time madgraph: $elapsed_madgraph seconds" >> ${tmp}/timing.txt
    echo "Time pythia+delphes: $elapsed_pythia_delphes seconds" >> ${tmp}/timing.txt
    echo "Time end-to-end execution: $elapsed_total" >> ${tmp}/timing.txt
    # transfer testing results
    mv ${tmp}/timing.txt ${outdir}/timing.txt
    mv ${tmp}/validation_plots ${outdir}/validation_plots
fi

# transfer generated events
mv ${tmp}/Events/*/*.root ${outdir}/event.root

# all done
echo Done!
