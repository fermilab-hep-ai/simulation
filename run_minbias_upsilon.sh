#!/bin/bash

set -x

proc=$1
nevts=$2
seed=$3
simdir=$4
outdir=$5
is_test=$6
label=$7

if [ "$is_test" = "True" ]; then
   start_time="$(date -u +%s)"
fi

workdir=$(pwd)
tmpdir="${outdir}/tmpdir/${label}"
outdir="${outdir}/${label}"
mkdir -p "$tmpdir"
mkdir -p "$outdir"
mkdir -p "$tmpdir/Cards"
mkdir -p "$tmpdir/Events"
mkdir -p "$tmpdir/bin"
mkdir -p "$tmpdir/QCD"
mkdir -p "$tmpdir/QCD/results"
BASEDIR=$(pwd)
echo "BASEDIR: $BASEDIR"

echo "workdir: $workdir"
echo "args: $@"

# locate run cards
if [ ! -d ${simdir}/processes/${proc} ]; then
  echo ${simdir}/processes/${proc} " does not exist!"
  exit 1
fi

root_file="${tmpdir}/event.root"
pythia_card=$(find ${simdir}/processes/${proc} -name "*pythia*")
mkdir -p ${tmpdir}/Cards
cp ${simdir}/cards/* $tmpdir/Cards/
cp ${pythia_card} ${tmpdir}/Cards/pythia_card.dat
delphes_card="${tmpdir}/Cards/delphes_card.dat"
pythia_card="${tmpdir}/Cards/pythia_card.dat"
sed -i "s|NSEED|${seed}|g" ${pythia_card}
sed -i "s|NEVENTS|${nevts}|g" ${pythia_card}

apptainer exec --bind ${simdir} container.sif bash -c "
  if [ -e ${simdir}/main43.cc ]; then
    mkdir -p $tmpdir/QCD/  # Create the directory if it doesn't exist
    mkdir -p $tmpdir/QCD/results/  # Create the directory if it doesn't exist
    cp ${simdir}/main43.cc $tmpdir/QCD/main43.cc
    PYTHIA8=/usr/local HEPMC_DIR=/usr/local LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH g++ -o $tmpdir/QCD/main43 $tmpdir/QCD/main43.cc \
        -I/usr/local/include/Pythia8 -L/usr/local/lib -lpythia8 \
        -I/usr/local/include/HepMC -L/usr/local/lib -lHepMC \
        -ldl -std=c++11
    LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH $tmpdir/QCD/main43 PileUp_MC ${seed} $tmpdir/QCD/results/hepmcout_SoftQCD_MC_${seed}.data
    #LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH ./$tmpdir/QCD/main43 PileUp_MC ${seed} $tmpdir/QCD/results/hepmcout_SoftQCD_MC_${seed}.data
    /usr/local/share/delphes/Delphes-3.5.0/hepmc2pileup $tmpdir/QCD/results/SoftQCD.pileup $tmpdir/QCD/results/hepmcout_SoftQCD_MC_${seed}.data
  fi
  "

sed -i -e "s@_PileUpFile_@$tmpdir/QCD/results/SoftQCD.pileup@g" ${delphes_card}

apptainer exec --env PYTHIA8DATA=/opt/Delphes-3.5.0/pythia8313/share/Pythia8/xmldoc \
    delphespythia.sif /opt/Delphes-3.5.0/DelphesPythia8 \
    ${delphes_card} ${pythia_card} ${root_file}

# transfer generated events
mv $root_file $outdir/event.root
rm -r $tmpdir

# convert root output file to parquet
python3 ${simdir}/process_root_parquet.py $outdir/event.root $outdir/event.parquet

# check if python3 script executed without error
if [ $? -eq 0 ]; then
    echo "Conversion to parquet finished successfully, deleting root file!"
    rm -f $outdir/event.root
else
    echo "Conversion to parquet failed, keeping root file to run it again!"
fi


if [ "$is_test" = "True" ]; then
  apptainer exec --bind ${simdir} container.sif bash -c "
    # make validation plots
    # python3 ${simdir}/make_plots.py -p $outdir/ -v ${simdir}/validation_config.yaml
    python3 ${simdir}/make_validation_plots_parquet.py $outdir
    "
fi


# all done
echo Done!

#rm -rf /eos/user/e/emoreno/foundational_model/pileup_files/SoftQCDtest.pileup