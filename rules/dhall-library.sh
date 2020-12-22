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

function debug_log() {
 if [ $DEBUG -eq 1 ]
 then
    echo "$(basename "$0") DEBUG: $1" >&2
  fi
}

DEBUG=0

TARS=""
RESOURCES=""
while getopts "vd:r:" arg; do
  # We handle the rest of the arguments below
  # shellcheck disable=SC2220
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

if [ $# -ne 3 ]; then
  echo "Usage: $0 [-v] [-d <dep-tar-file>] [-r <source_path>:<target_path>] <dhall-binary> <output-tarfile> <dhall-input-file> "
  exit 2
fi

DHALL_BIN=$1
TARFILE=$2
if ! DHALL_FILE=$(_realpath "$3")
then
  echo "Unable to canonicalize path for $3! Builds could fail on macOS. Falling back to the non-canonical path."
  DHALL_FILE=$3
fi

export XDG_CACHE_HOME="$PWD/.cache"

debug_log "Working directory: ${PWD}"
debug_log "Cache: ${XDG_CACHE_HOME}"
debug_log "Dhall binary: ${DHALL_BIN}"
debug_log "Package deps: ${TARS}"
debug_log "Resources: ${RESOURCES}"

unpack_tarfile() {
  DEP_TARFILE=$1
  DEST_DIR=$2
  debug_log "${TARFILE} Unpacking $DEP_TARFILE into $DEST_DIR"
  tar -xf "$DEP_TARFILE" -C "$DEST_DIR"
}

unpack_tars() {
  for tar in $*; do
    debug_log "Unpacking $tar into $XDG_CACHE_HOME"
    tar -xf "$tar" --strip-components=2 -C "$XDG_CACHE_HOME/dhall" .cache
  done
}
copy_resources() {
  for resource in $*; do
    source=$(cut -d':' -f 1 <<< "${resource}")
    target=$(cut -d':' -f 2 <<< "${resource}")

    debug_log "Copying $source to $target"
    cp -f "$source" "$target"
  done
}

dump_cache() {
  if [ $DEBUG -eq 1 ]
  then
    echo "DUMPING CACHE $1 START" >&2
    ls -l "$2" >&2
    echo "DUMPING CACHE $1 STOP" >&2
  fi
}

mkdir -p "$XDG_CACHE_HOME/dhall"

unpack_tars "$TARS"

copy_resources "$RESOURCES"

dump_cache "BEFORE_GEN" "$XDG_CACHE_HOME/dhall"

debug_log "Generating source.dhall"
if ! ${DHALL_BIN} --alpha --file "${DHALL_FILE}" > source.dhall
then
  exit $?
fi

SHA_HASH=$(${DHALL_BIN} hash --file source.dhall)

HASH_FILE="${SHA_HASH/sha256:/1220}"

debug_log "Hash is $HASH_FILE"
if ! ${DHALL_BIN} encode --file source.dhall > "$XDG_CACHE_HOME/dhall/$HASH_FILE"
then
  exit $?
fi

dump_cache "AFTER_GEN" "$XDG_CACHE_HOME/dhall"

debug_log "Creating tarfile $TARFILE"
tar -cf "$TARFILE" -C "$PWD" ".cache/dhall/$HASH_FILE"
tar -rf "$TARFILE" source.dhall
echo "missing $HASH_FILE" > binary.dhall
tar -rf "$TARFILE" binary.dhall

debug_log "Removing source.dhall"
rm source.dhall
