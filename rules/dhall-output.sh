#!/usr/bin/env bash
#
# Script that creates an output from a dhall file and a set of dependencies
#
DEBUG=0

TARS=""
RESOURCES=""
while getopts "vd:r:" arg; do
  case "$arg" in
    v)
      DEBUG=1
      ;;
    d)
      TARS="$TARS $OPTARG"
      ;;
    r)
      RESOURCES="$RESOURCES $OPTARG"
      ;;
  esac
done
shift $((OPTIND - 1))

if [ $# -lt 3 ]; then
  echo "Usage: $0 [-v] [-d <dep-tar-file>] <dhall-output-binary> <output-file> <dhall-input-file>"
  exit 2
fi

DHALL_TO_YAML_BIN=$1
OUTPUT_FILE=$2
DHALL_FILE=$3
export XDG_CACHE_HOME="$PWD/.cache"

if [ $DEBUG -eq 1 ]; then
  echo Working directory: ${PWD}
  echo Cache: ${XDG_CACHE_HOME}
  echo Dhall output binary: ${DHALL_TO_YAML_BIN}
fi

unpack_tars() {
  for tar in $*; do
    [ $DEBUG -eq 1 ] && echo Unpacking $tar into $XDG_CACHE_HOME
    tar -xf $tar --strip-components=2 -C $XDG_CACHE_HOME/dhall .cache
  done
}
copy_resources() {
  for resource in $*; do
    source=$(cut -d':' -f 1 <<< $resource)
    target=$(cut -d':' -f 2 <<< $resource)

    [ $DEBUG -eq 1 ] && echo Copying $source to $target
    cp -f $source $target
  done
}

dump_cache() {
  if [ $DEBUG -eq 1 ]; then
    echo DUMPING CACHE $1 START 
    ls -l $2
    echo DUMPING CACHE $1 STOP
  fi
}

mkdir -p $XDG_CACHE_HOME/dhall

unpack_tars $TARS

copy_resources $RESOURCES

dump_cache BEFORE_GEN $XDG_CACHE_HOME/dhall

[ $DEBUG -eq 1 ] && echo Generating $OUTPUT_FILE
$DHALL_TO_YAML_BIN ${_DHALL_ARGS} --file $DHALL_FILE >$OUTPUT_FILE
RES=$?
if [ $RES -ne 0 ]; then 
  exit $RES
fi

