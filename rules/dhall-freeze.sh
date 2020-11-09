#!/usr/bin/env bash
#
# Script that outputs frozen dhall
#

set -euo pipefail

DEBUG=0

DHALL_BIN=$(realpath -s @@DHALL_BIN@@)
ENTRYPOINT=@@ENTRYPOINT@@
DEPS=@@DEPS@@
export XDG_CACHE_HOME="$PWD/.cache"

if [ $DEBUG -eq 1 ]; then
  echo Working directory: ${PWD}
  echo Cache: ${XDG_CACHE_HOME}
  echo Dhall binary: ${DHALL_BIN}
  echo Package deps: ${DEPS[@]}
fi

unpack_tarfile() {
  DEP_TARFILE=$1
  DEST_DIR=$2
  [ $DEBUG -eq 1 ] && echo ${TARFILE} Unpacking $DEP_TARFILE into $DEST_DIR
  tar -xf $DEP_TARFILE -C $DEST_DIR
}

unpack_tars() {
  for (( i=0; i<${#DEPS[@]} ; i+=2 ));
  do
    tar="${DEPS[i+1]}"
    name="${DEPS[i]}"
    [ $DEBUG -eq 1 ] && echo Unpacking $tar into $XDG_CACHE_HOME && tar -tvf $tar
    tar -xf $tar --strip-components=2 -C $XDG_CACHE_HOME/dhall .cache
    tar -xOf $tar source.dhall > $name
    export "DHALLBAZEL_$name=$PWD/$name"
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

unpack_tars

dump_cache BEFORE_GEN $XDG_CACHE_HOME/dhall

cd $(dirname ${ENTRYPOINT})
filename="$(basename ${ENTRYPOINT})"

[ $DEBUG -eq 1 ] && echo Freezing: ${DHALL_BIN} freeze --all \< "${filename}"
exec ${DHALL_BIN} freeze --all < "${filename}"
