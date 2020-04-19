#!/usr/bin/env bash
#
# Script that creates an output from a dhall file and a set of dependencies
#
DEBUG=0

while getopts "v" arg; do
  case "$arg" in
    v)
      DEBUG=1
      ;;
  esac
done
shift $((OPTIND - 1))

if [ $# -lt 3 ]; then
  echo "Usage: $0 <dhall-output-binary> <output-file> <dhall-input-file> [<dep-tar-file> ...]"
  exit 2
fi

DHALL_TO_YAML_BIN=$1
OUTPUT_FILE=$2
DHALL_FILE=$3
shift 3
TARS=$*
TMP_CACHE=$PWD/$XDG_CACHE_HOME

[ $DEBUG -eq 1 ] && echo Working directory is ${PWD}
[ $DEBUG -eq 1 ] && echo Using cache at ${XDG_CACHE_HOME}

unpack_tars() {
  for tar in $*; do
    [ $DEBUG -eq 1 ] && echo Unpacking $tar into $TMP_CACHE
    tar -xf $tar --strip-components=2 -C $TMP_CACHE/dhall .cache
  done
}
dump_cache() {
  if [ $DEBUG -eq 1 ]; then
    echo DUMPING CACHE $1 START $2
    ls -l $2
    echo DUMPING CACHE $1 STOP
  fi
}

mkdir -p $TMP_CACHE/dhall

unpack_tars $TARS
dump_cache BEFORE_GEN $TMP_CACHE/dhall

[ $DEBUG -eq 1 ] && echo Generating $OUTPUT_FILE
$DHALL_TO_YAML_BIN --file $DHALL_FILE >$OUTPUT_FILE
