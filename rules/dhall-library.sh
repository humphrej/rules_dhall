#!/usr/bin/env bash
#
# Script that creates a tarfile of the encoded input plus all dependencies
#

# This function canonicalizes a path, including resolving symlinks
# Behavior is equivalent to `realpath` from Linux or brew coreutils
# https://stackoverflow.com/a/18443300
function _realpath() {
  local OURPWD=$PWD
  cd "$(dirname "$1")" || return 1
  local LINK
  LINK=$(readlink "$(basename "$1")")
  while [ "$LINK" ]; do
    cd "$(dirname "$LINK")" || return 1
    LINK=$(readlink "$(basename "$1")")
  done
  local REALPATH
  REALPATH="$PWD/$(basename "$1")"
  cd "$OURPWD" || return 1
  echo "$REALPATH"
  return 0
}

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
  echo "Usage: $0 [-v] [-d <dep-tar-file>] [-r <source_path>:<target_path>] <dhall-binary> <output-tarfile> <dhall-input-file> "
  exit 2
fi

DHALL_BIN=$1
TARFILE=$2
DHALL_FILE=$(_realpath "$3")
export XDG_CACHE_HOME="$PWD/.cache"

if [ $DEBUG -eq 1 ]; then
  echo Working directory: ${PWD}
  echo Cache: ${XDG_CACHE_HOME}
  echo Dhall binary: ${DHALL_BIN}
  echo Package deps: ${TARS}
  echo Resources: ${RESOURCES}
fi

unpack_tarfile() {
  DEP_TARFILE=$1
  DEST_DIR=$2
  [ $DEBUG -eq 1 ] && echo ${TARFILE} Unpacking $DEP_TARFILE into $DEST_DIR
  tar -xf $DEP_TARFILE -C $DEST_DIR
}

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

[ $DEBUG -eq 1 ] && echo Generating source.dhall
${DHALL_BIN} --alpha --file ${DHALL_FILE} >source.dhall
RES=$?
if [ $RES -ne 0 ]; then 
  exit $RES
fi

SHA_HASH=$(${DHALL_BIN} hash --file source.dhall)

HASH_FILE="${SHA_HASH/sha256:/1220}"

[ $DEBUG -eq 1 ] && echo Hash is $HASH_FILE
${DHALL_BIN} encode --file source.dhall >$XDG_CACHE_HOME/dhall/$HASH_FILE
RES=$?
if [ $RES -ne 0 ]; then 
  exit $RES
fi

dump_cache AFTER_GEN $XDG_CACHE_HOME/dhall

[ $DEBUG -eq 1 ] && echo Creating tarfile $TARFILE
tar -cf $TARFILE -C $PWD .cache/dhall/$HASH_FILE
tar -rf $TARFILE source.dhall
echo "missing $HASH_FILE" >binary.dhall
tar -rf $TARFILE binary.dhall

[ $DEBUG -eq 1 ] && echo Removing source.dhall
rm source.dhall
