#!/usr/bin/env bash
#
# Script that outputs dhall library docs
#

set -euo pipefail

DEBUG=0
DHALL_DOCS_BIN=$(realpath -s $1)
INPUT=$(realpath -s $2)
OUTPUT=$(realpath -s $3)
export XDG_CACHE_HOME="$PWD/.cache"
export HOME="$PWD"

if [ $DEBUG -eq 1 ]; then
  echo Working directory: ${PWD}
  echo Cache: ${XDG_CACHE_HOME}
  echo Dhall binary: ${DHALL_DOCS_BIN}
  echo Input Dir: ${INPUT}
  echo Output file: ${OUTPUT}
fi

TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT
cd $TMPDIR

$DHALL_DOCS_BIN --input "$INPUT"
tar -chzf "${OUTPUT}" .
