#!/usr/bin/env bash
# Run the full generation pipeline -- run.sh: event generation, pile-up,
# Delphes and the parquet conversion -- inside the container for a few events,
# then check the parquet it wrote.
#
#   ci/run_pipeline_test.sh <image> <process> <nevents> [seed]
#
# The repository is mounted at /simulation and passed to run.sh as $simdir, and
# run.sh runs in an empty directory of its own, as on a batch worker.  run.sh
# does not stop on most errors, so the parquet check is what decides whether
# the pipeline worked.  Outputs are left in $RUNNER_TEMP/pipeline/<process>/
# (run.log, check.log, outdir/) for the workflow to upload.
set -euo pipefail

if [ $# -lt 3 ]; then
    echo "usage: $0 <image> <process> <nevents> [seed]" >&2
    exit 2
fi
image=$1
process=$2
nevents=$3
seed=${4:-1}

simdir=$(cd "$(dirname "$0")/.." && pwd)
workdir="${RUNNER_TEMP:-/tmp}/pipeline/${process}"
rm -rf "${workdir}"
mkdir -p "${workdir}"
df -h "${workdir}" | tail -n 1

echo "::group::run.sh ${process}, ${nevents} events, seed ${seed}, in ${image}"
set +e
docker run --rm \
    -v "${simdir}:/simulation" \
    -v "${workdir}:/work" \
    -w /work \
    "${image}" \
    "sh /simulation/run.sh ${process} ${nevents} ${seed} /simulation False" \
    2>&1 | tee "${workdir}/run.log"
status=${PIPESTATUS[0]}
set -e
echo "::endgroup::"
df -h "${workdir}" | tail -n 1

if [ "${status}" -ne 0 ]; then
    echo "::error::run.sh exited with status ${status} for ${process} (see run.log)"
    exit 1
fi

set +e
docker run --rm \
    -v "${simdir}:/simulation:ro" \
    -v "${workdir}:/work:ro" \
    "${image}" \
    "python3 /simulation/ci/check_parquet.py /work/outdir/event.parquet --max-events ${nevents}" \
    2>&1 | tee "${workdir}/check.log"
status=${PIPESTATUS[0]}
set -e

if [ "${status}" -ne 0 ]; then
    echo "::error::the parquet written for ${process} failed its checks (see check.log)"
    exit 1
fi
echo "pipeline test passed for ${process}"
