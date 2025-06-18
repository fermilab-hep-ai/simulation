#!/bin/bash

set -x

proc=$1
nevts=$2
seed=$3
simdir=$4
is_test=$5

if [ "$is_test" = "True" ]; then
   start_time="$(date -u +%s)"
fi

workdir=$(pwd)
mkdir tmpdir
mkdir outdir
mkdir tmpdir/Cards
mkdir tmpdir/Events
mkdir tmpdir/bin
mkdir tmpdir/QCD
mkdir tmpdir/QCD/results
BASEDIR=$(pwd)
echo "BASEDIR: $BASEDIR"

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

cp ${simdir}/processes/${proc}/${proc}_proc_card.dat tmpdir/proc_card.dat
sed -i -e "s@_OUTDIR_@tmpdir@g" tmpdir/proc_card.dat
/usr/local/MG5_aMC_v3_5_6/bin/mg5_aMC tmpdir/proc_card.dat
ls -l tmpdir/bin/
ls tmpdir/bin/madevent
if [ "$is_test" = "True" ]; then
    end_time_madgraph="$(date -u +%s)"
fi
# write run cards
cp ${simdir}/cards/* tmpdir/Cards/
cp ${simdir}/processes/${proc}/${proc}_run_card.dat tmpdir/Cards/run_card.dat
if [ -e ${simdir}/processes/${proc}/${proc}_cuts.f ]; then
  echo "copying custom cuts.f file"
  cp ${simdir}/processes/${proc}/${proc}_cuts.f tmpdir/SubProcesses/cuts.f
fi

if [ -e ${simdir}/processes/${proc}/${proc}_FKS_params.dat ]; then
  echo "copying custom FKS_params.dat file"
  cp ${simdir}/processes/${proc}/${proc}_FKS_params.dat tmpdir/Cards/FKS_params.dat
fi

if [ -e ${simdir}/processes/${proc}/${proc}_setscales.f ]; then
  echo "copying custom setscales.f file"
  cp ${simdir}/processes/${proc}/${proc}_setscales.f tmpdir/SubProcesses/setscales.f
fi

if [ -e ${simdir}/processes/${proc}/${proc}_reweight_xsec.f ]; then
  echo "copying custom reweight_xsec.f file"
  cp ${simdir}/processes/${proc}/${proc}_reweight_xsec.f tmpdir/SubProcesses/reweight_xsec.f
fi

if [ -e ${simdir}/processes/${proc}/${proc}_reweight_card.dat ]; then
  echo "copying custom reweight file"
  cp ${simdir}/processes/${proc}/${proc}_reweight_card.dat tmpdir/Cards/reweight_card.dat
fi

if [ -e ${simdir}/processes/${proc}/${proc}_param_card.dat ]; then
  echo "copying custom params file"
  cp ${simdir}/processes/${proc}/${proc}_param_card.dat tmpdir/Cards/param_card.dat
fi

if [ -e ${simdir}/processes/${proc}/${proc}_madspin_card.dat ]; then
  cp ${simdir}/processes/${proc}/${proc}_madspin_card.dat tmpdir/Cards/madspin_card.dat
  sed -i -e "s@_OUTDIR_@tmpdir@g" tmpdir/Cards/madspin_card.dat
fi

if [ -e ${simdir}/main43.cc ]; then
  mkdir -p tmpdir/QCD/  # Create the directory if it doesn't exist
  mkdir -p tmpdir/QCD/results/  # Create the directory if it doesn't exist
  cp ${simdir}/main43.cc tmpdir/QCD/main43.cc
  PYTHIA8=/usr/local HEPMC_DIR=/usr/local LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH g++ -o tmpdir/QCD/main43 tmpdir/QCD/main43.cc \
      -I/usr/local/include/Pythia8 -L/usr/local/lib -lpythia8 \
      -I/usr/local/include/HepMC -L/usr/local/lib -lHepMC \
      -ldl -std=c++11
  LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH ./tmpdir/QCD/main43 PileUp_MC ${seed}
  /usr/local/share/delphes/Delphes-3.5.0/hepmc2pileup tmpdir/QCD/results/SoftQCD.pileup tmpdir/QCD/results/hepmcout_SoftQCD_MC_${seed}.data
fi

echo "set nevents ${nevts}" >> tmpdir/Cards/launchrun.dat
if [ -e ${simdir}/processes/${proc}/${proc}_customizecards.dat ]; then
        cat ${simdir}/processes/${proc}/${proc}_customizecards.dat | sed '/^$/d;/^#.*$/d' >> tmpdir/Cards/launchrun.dat
        echo "" >> tmpdir/Cards/launchrun.dat
fi
echo "done" >> tmpdir/Cards/launchrun.dat

# change delphes source code delphes/external/PUPPI/PuppiContainer.cc and replace if(pWeight == 0) continue; with //if(pWeight == 0) continue;
# sed -i -e "s@if(pWeight == 0) continue;@//if(pWeight == 0) continue;@g" /usr/local/share/delphes/Delphes-3.5.0/external/PUPPI/PuppiContainer.cc

sed -i -e "s@_NEVENTS_@$nevts@g" tmpdir/Cards/run_card.dat
## Using 100k pileup file ##
#sed -i -e "s@_PileUpFile_@$simdir/MinBias_100k.pileup@g" tmpdir/Cards/delphes_card.dat

#sed -i -e "s@_PileUpFile_@/afs/cern.ch/user/e/emoreno/foundation/simulation/results/SoftQCD.pileup@g" tmpdir/Cards/delphes_card.dat

# list contents of tmpdir/QCD/results

## Using on-the-fly pileup from  tmpdir/QCD/results/SoftQCD.pileup##
sed -i -e "s@_PileUpFile_@$workdir/tmpdir/QCD/results/SoftQCD.pileup@g" tmpdir/Cards/delphes_card.dat
sed -
echo xxxxxxxxx
cat tmpdir/Cards/delphes_card.dat
sed -i -e "s@_ISEED_@$seed@g" tmpdir/Cards/run_card.dat

if [ "$is_test" = "True" ]; then
    start_time_pythia_delphes="$(date -u +%s)"
fi
tmpdir/bin/madevent tmpdir/Cards/launchrun.dat
if [ "$is_test" = "True" ]; then
    end_time_pythia_delphes="$(date -u +%s)"
fi


# transfer generated events
mv tmpdir/Events/*/*.root outdir/event.root

python3 ${simdir}/process_root_withL1T.py \
        -i outdir/event.root \
        -o outdir/event_skim.root     

# If you would rather **replace** the original, uncomment the next line
# mv -f outdir/event_skim.root outdir/event.root

if [ "$is_test" = "True" ]; then
    # make validation plots
    python3 ${simdir}/make_plots.py -p outdir/ -v ${simdir}/validation_config.yaml

    # timing monitor dump
    end_time="$(date -u +%s)"
    elapsed_madgraph="$(($end_time_madgraph-$start_time_madgraph))"
    elapsed_pythia_delphes="$(($end_time_pythia_delphes-$start_time_pythia_delphes))"
    elapsed_total="$(($end_time-$start_time))"
    echo "Time madgraph: $elapsed_madgraph seconds" >> outdir/timing.txt
    echo "Time pythia+delphes: $elapsed_pythia_delphes seconds" >> outdir/timing.txt
    echo "Time end-to-end execution: $elapsed_total" >> outdir/timing.txt
fi

# all done
echo Done!

#rm -rf /eos/user/e/emoreno/foundational_model/pileup_files/SoftQCDtest.pileup