#!/bin/bash

set -x

proc=$1
nevts=$2
seed=$3
simdir=$4
is_test=$5

if [ "$is_test" = "True" ]; then
    start_time="$(date -u +%s)"
    # ensure test artifacts live here
    mkdir -p outdir
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

# Two generation modes are supported:
#   madgraph : MG5 hard process -> Pythia8 -> Delphes  (driven by madevent)
#              requires ${proc}_proc_card.dat and ${proc}_run_card.dat
#   pythia   : Pythia8-only hard process -> HepMC -> DelphesHepMC2
#              requires ${proc}_pythia_card.dat
# The pythia mode exists because several signals (Hidden Valley dark showers,
# Higgs-portal, Z') are generated entirely inside Pythia, and because the
# container ships DelphesHepMC2 but no DelphesPythia8 binary.
if [ -e ${simdir}/processes/${proc}/${proc}_pythia_card.dat ]; then
  gen_mode=pythia
else
  gen_mode=madgraph
fi
echo "generation mode: ${gen_mode}"

if [ "$gen_mode" = "madgraph" ]; then
  if [ ! -e ${simdir}/processes/${proc}/${proc}_proc_card.dat ]; then
    echo ${simdir}/processes/${proc}/${proc}_proc_card.dat " does not exist!"
    exit 1
  fi

  if [ ! -e ${simdir}/processes/${proc}/${proc}_run_card.dat ]; then
    echo ${simdir}/processes/${proc}/${proc}_run_card.dat " does not exist!"
    exit 1
  fi
fi


# run MadGraph event generation
if [ "$is_test" = "True" ]; then
    start_time_madgraph="$(date -u +%s)"
fi

if [ "$gen_mode" = "madgraph" ]; then
  cp ${simdir}/processes/${proc}/${proc}_proc_card.dat tmpdir/proc_card.dat
  # _SIMDIR_ lets a proc card import a UFO model vendored in this repository
  # (models/), which the RPV points need -- see models/RPVMSSM_UFO_Wn1.
  # Cards that do not use the placeholder are unaffected.
  sed -i -e "s@_OUTDIR_@tmpdir@g" -e "s@_SIMDIR_@${simdir}@g" tmpdir/proc_card.dat
  /usr/local/MG5_aMC_v3_5_8/bin/mg5_aMC tmpdir/proc_card.dat
  ls -l tmpdir/bin/
  ls tmpdir/bin/madevent
fi
if [ "$is_test" = "True" ]; then
    end_time_madgraph="$(date -u +%s)"
fi
# write run cards
cp ${simdir}/cards/* tmpdir/Cards/
if [ "$gen_mode" = "madgraph" ]; then
  cp ${simdir}/processes/${proc}/${proc}_run_card.dat tmpdir/Cards/run_card.dat
fi
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
  #sed -i -e "s@_OUTDIR_@tmpdir@g" tmpdir/Cards/madspin_card.dat

  #---- NEW: patch the MadSpin grid placeholder ------------------------------
  # The VBFH MadSpin card uses the literal string MADSPINGRID.  Replace it
  # with an absolute path to the grid that will be produced in the MG5 run.
  sed -i -e "s@MADSPINGRID@${workdir}/tmpdir/madspin_grid@g" \
         tmpdir/Cards/madspin_card.dat
  #---------------------------------------------------------------------------
fi

if [ -e ${simdir}/processes/${proc}/${proc}_pythia8_card.dat ]; then
  echo "copying custom pythia8 card"
  cp ${simdir}/processes/${proc}/${proc}_pythia8_card.dat \
     tmpdir/Cards/pythia8_card.dat
fi

if [ -e ${simdir}/main43.cc ]; then
  mkdir -p tmpdir/QCD/  # Create the directory if it doesn't exist
  mkdir -p tmpdir/QCD/results/  # Create the directory if it doesn't exist
  cp ${simdir}/main43.cc tmpdir/QCD/main43.cc
  PYTHIA8=/usr/local HEPMC_DIR=/usr/local LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH g++ -o tmpdir/QCD/main43 tmpdir/QCD/main43.cc \
      -I/usr/local/include/Pythia8 -L/usr/local/lib -lpythia8 \
      -I/usr/local/include/HepMC -L/usr/local/lib -lHepMC \
      -ldl -std=c++11
  # PYTHIA8DATA is pinned to the container's copy.  Without it, a PYTHIA8DATA
  # already set in the caller's environment (e.g. pointing at a local MG5
  # HEPTools install) is inherited by the container and Pythia aborts with
  # "settings file ... not found", leaving an empty pileup file behind.
  LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH \
  PYTHIA8DATA=/usr/local/share/Pythia8/xmldoc \
    ./tmpdir/QCD/main43 PileUp_MC ${seed}
  /usr/local/share/delphes/Delphes-3.5.0/hepmc2pileup tmpdir/QCD/results/SoftQCD.pileup tmpdir/QCD/results/hepmcout_SoftQCD_MC_${seed}.data

  # Fail loudly if the pileup is empty.  Delphes does not error on an empty
  # pileup file -- PileUpMerger simply never finds the 200 vertices it wants and
  # the job hangs at 0% indefinitely, which is very hard to diagnose from logs.
  if [ ! -s tmpdir/QCD/results/SoftQCD.pileup ] || \
     [ ! -s tmpdir/QCD/results/hepmcout_SoftQCD_MC_${seed}.data ]; then
    echo "ERROR: pileup generation produced an empty file; aborting rather than"
    echo "       letting Delphes hang. Check the main43 output above."
    ls -l tmpdir/QCD/results/
    exit 10
  fi
fi

# Bring in extra user commands, stripping blank lines & comments
if [ -e ${simdir}/processes/${proc}/${proc}_customizecards.dat ]; then
    sed '/^$/d;/^[[:space:]]*#/d' \
        ${simdir}/processes/${proc}/${proc}_customizecards.dat \
        >> tmpdir/Cards/launchrun.dat
    echo "" >> tmpdir/Cards/launchrun.dat
fi

if [ -e ${simdir}/processes/${proc}/${proc}_madspin_card.dat ]; then
  echo "madspin=on" >> tmpdir/Cards/launchrun.dat
fi

echo "done" >> tmpdir/Cards/launchrun.dat

# change delphes source code delphes/external/PUPPI/PuppiContainer.cc and replace if(pWeight == 0) continue; with //if(pWeight == 0) continue;
# sed -i -e "s@if(pWeight == 0) continue;@//if(pWeight == 0) continue;@g" /usr/local/share/delphes/Delphes-3.5.0/external/PUPPI/PuppiContainer.cc

if [ "$gen_mode" = "madgraph" ]; then
  sed -i -e "s@_NEVENTS_@$nevts@g" tmpdir/Cards/run_card.dat
fi
## Using 100k pileup file ##
#sed -i -e "s@_PileUpFile_@$simdir/MinBias_100k.pileup@g" tmpdir/Cards/delphes_card.dat

#sed -i -e "s@_PileUpFile_@/afs/cern.ch/user/e/emoreno/foundation/simulation/results/SoftQCD.pileup@g" tmpdir/Cards/delphes_card.dat

# list contents of tmpdir/QCD/results

## Using on-the-fly pileup from  tmpdir/QCD/results/SoftQCD.pileup##
sed -i -e "s@_PileUpFile_@$workdir/tmpdir/QCD/results/SoftQCD.pileup@g" tmpdir/Cards/delphes_card.dat
sed -
echo xxxxxxxxx
cat tmpdir/Cards/delphes_card.dat
if [ "$gen_mode" = "madgraph" ]; then
  sed -i -e "s@_ISEED_@$seed@g" tmpdir/Cards/run_card.dat
fi

if [ "$is_test" = "True" ]; then
    start_time_pythia_delphes="$(date -u +%s)"
fi

if [ "$gen_mode" = "madgraph" ]; then
  tmpdir/bin/madevent tmpdir/Cards/launchrun.dat

  echo "Contents of Events/ after madevent:"
  ls -R tmpdir/Events
else
  # ------------------------------------------------------------------
  # Pythia8-only generation: build the standalone driver, run it to HepMC,
  # then hand the HepMC to Delphes with the same card / same pileup file
  # that the madgraph path uses.
  # ------------------------------------------------------------------
  mkdir -p tmpdir/Events/run_01

  PYTHIA8=/usr/local HEPMC_DIR=/usr/local LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH \
    g++ -o tmpdir/main_signal ${simdir}/main_signal.cc \
        -I/usr/local/include/Pythia8 -L/usr/local/lib -lpythia8 \
        -I/usr/local/include/HepMC -L/usr/local/lib -lHepMC \
        -ldl -std=c++11
  if [ $? -ne 0 ]; then
    echo "main_signal compilation failed"
    exit 7
  fi

  # Substitute NEVENTS / NSEED, the placeholder convention already used by
  # processes/minbias and processes/upsilon_to_leptons.
  cp ${simdir}/processes/${proc}/${proc}_pythia_card.dat tmpdir/Cards/pythia_card.dat
  sed -i -e "s@NEVENTS@$nevts@g" -e "s@NSEED@$seed@g" tmpdir/Cards/pythia_card.dat
  echo "----- pythia card -----"
  cat tmpdir/Cards/pythia_card.dat

  # PYTHIA8DATA is set explicitly: if the caller's environment points at some
  # other Pythia installation it leaks into the container and Pythia aborts at
  # startup with "settings file ... not found".
  # Not piped into tee: run.sh is invoked as "sh run.sh", so PIPESTATUS is not
  # guaranteed to be available and the exit status of the pipeline would be
  # tee's rather than Pythia's.
  LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH \
  PYTHIA8DATA=/usr/local/share/Pythia8/xmldoc \
    ./tmpdir/main_signal tmpdir/Cards/pythia_card.dat tmpdir/signal.hepmc \
    > tmpdir/pythia.log 2>&1
  py_status=$?
  tail -n 40 tmpdir/pythia.log
  if [ "$py_status" -ne 0 ]; then
    echo "Pythia generation failed with status ${py_status}"
    exit 8
  fi

  # Record the cross section next to the events (spec deliverable 5.5).
  grep '^XSEC_PB' tmpdir/pythia.log | tail -n 1 \
      | awk '{print "xsec_pb "$2"\nxsec_pb_err "$3}' > outdir/cross_section.txt
  cat outdir/cross_section.txt

  # Delphes must run from inside Cards/: delphes_card.dat sources its muon
  # resolution / ID helpers by relative path ("./muonMomentumResolution.tcl").
  ( cd tmpdir/Cards && \
    /usr/local/share/delphes/Delphes-3.5.0/DelphesHepMC2 \
        delphes_card.dat \
        ${workdir}/tmpdir/Events/run_01/${proc}.root \
        ${workdir}/tmpdir/signal.hepmc )
  if [ $? -ne 0 ]; then
    echo "DelphesHepMC2 failed"
    exit 9
  fi
  rm -f tmpdir/signal.hepmc
fi

if [ "$is_test" = "True" ]; then
    end_time_pythia_delphes="$(date -u +%s)"
fi


# transfer generated events
#mv tmpdir/Events/*/*.root outdir/event.root

if [ -e ${simdir}/processes/${proc}/${proc}_madspin_card.dat ]; then
    run_dir=run_01_decayed_1
else
    run_dir=run_01
fi

# root_file=$(find "tmpdir/Events/${run_dir}/" -maxdepth 1 -name "*.root" | head -n 1)
# final_root="outdir/event.root"
# mv  "${root_file}"  "${final_root}"

root_file=$(find "tmpdir/Events/${run_dir}/" -maxdepth 1 -name "*.root" | head -n 1)
# Process ROOT in-place from tmpdir; do not move into outdir (saves space)
final_root="${root_file}"



python3 -m pip install --no-cache-dir --upgrade --user pyarrow

python3  "${simdir}/process_root_parquet.py"  \
         "${final_root}"                 \
         "outdir/event.parquet"
conv_status=$?

if [ "$conv_status" -ne 0 ]; then
    echo "Parquet conversion failed with status ${conv_status}"
    exit 6
fi

# Now we have: outdir/event.parquet
LOCAL_PARQUET="outdir/event.parquet"

# where the final production lives
DEST_DIR="/eos/project/f/foundational-model-dataset/samples/production_final/${proc}"

DEST_FILE="${DEST_DIR}/${proc}-NEVENT${nevts}-RS${seed}.parquet"

#mkdir -p "${DEST_DIR}"

if [ "$is_test" = "True" ]; then
    echo "Test mode: keeping ${LOCAL_PARQUET} locally, not copying to ${DEST_FILE}"
else
    echo "Copying ${LOCAL_PARQUET} -> ${DEST_FILE}"
    # cp works since EOS is mounted; swap to xrdcp -f if you prefer
    cp -f "${LOCAL_PARQUET}" "${DEST_FILE}"
fi

# ----------------------------------------------------------------------
# Validation plots  (always, before deletion)
# ----------------------------------------------------------------------
valdir="outdir/validation_plots"
mkdir -p "${valdir}"

# make validation plots only in test mode
if [ "$is_test" = "True" ]; then
    # 3a. Quick one-shot plots (your existing script)
    python3 "${simdir}/make_plots.py" \
            -p outdir/ \
            -v "${simdir}/validation_config.yaml"
    ret_plots=$?

    # 3b. Full validation over *this* ROOT file only
    python3 "${simdir}/make_validation_plots.py" \
            "${final_root}" \
            --outdir "${valdir}"
    ret_val_root=$?

    # 3c. Parquet-based validation (use the Parquet we just wrote)
    python3 "${simdir}/make_validation_plots_parquet.py" \
            "outdir/event.parquet" \
            --outdir "${valdir}"
    ret_val_parquet=$?
fi

# ----------------------------------------------------------------------
# Delete ROOT only after successful conversion and validations (not in test)
# ----------------------------------------------------------------------

if [ "$is_test" = "True" ]; then
    mkdir -p outdir
    label="${proc}-${nevts}-${seed}"
    if [ -n "${final_root}" ] && [ -s "${final_root}" ]; then
        cp -f "${final_root}" "outdir/${label}.root"
        echo "Saved test ROOT to outdir/${label}.root"
    else
        echo "WARNING: (test mode) final_root not found or empty; nothing to copy to outdir/" >&2
    fi
    
else
    if [ ${conv_status} -eq 0 ] && [ -s "outdir/event.parquet" ] \
       && [ ${ret_plots} -eq 0 ] && [ ${ret_val_root} -eq 0 ] && [ ${ret_val_parquet} -eq 0 ]; then
        echo "All validations passed; deleting ROOT file ${final_root}."
        rm -f "${final_root}"
    else
        echo "Conversion or validation failed; keeping ROOT file ${final_root}."
    fi
fi

# ----------------------------------------------------------------------
# Timing monitor dump (only in test mode)
# ----------------------------------------------------------------------
if [ "$is_test" = "True" ]; then
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
