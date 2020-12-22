#!/usr/bin/env bash
#
# Script that outputs frozen dhall
#
set -euo pipefail

###############
## FUNCTIONS ##
###############
function dump_cache() {
  if [ "$DEBUG" -eq 1 ]
  then
    echo "DUMPING CACHE $1 START" >&2
    ls -l "$2" >&2
    echo "DUMPING CACHE $1 STOP" >&2
  fi
}

function debug_log() {
 if [ "$DEBUG" -eq 1 ]
 then
    echo "$(basename "$0") DEBUG: $1" >&2
  fi
}

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

##########
## MAIN ##
##########

FAST=@@FAST@@
DEBUG=@@DEBUG@@
if ! DHALL_BIN=$(_realpath @@DHALL_BIN@@)
then
  echo "Unable to canonicalize path for @@DHALL_BIN@@! Builds could fail on macOS. Falling back to the non-canonical path."
  DHALL_BIN=@@DHALL_BIN@@
fi
ENTRYPOINT=@@ENTRYPOINT@@
DEPS=@@DEPS@@
export XDG_CACHE_HOME="$PWD/.cache"

IMPORTHASH=()

debug_log "Working directory: ${PWD}"
debug_log "Cache: ${XDG_CACHE_HOME}"
debug_log "Dhall binary: ${DHALL_BIN}"
debug_log "Package deps: ${DEPS[*]}"

unpack_tars_freeze() {
  for (( i=0; i<${#DEPS[@]} ; i+=2 ));
  do
    local tar="${DEPS[i+1]}"
    local name="${DEPS[i]}"
    debug_log "Unpacking $tar into $XDG_CACHE_HOME"
    debug_log "$(tar -tvf $tar)"
    tar -xf $tar --strip-components=2 -C "$XDG_CACHE_HOME/dhall" .cache
    tar -xOf $tar source.dhall > $name
    local hash
    hash=$(tar -xOf $tar binary.dhall | grep -o '1220\w*' | sed s/^1220//)
    export "DHALLBAZEL_$name=$PWD/$name"
    IMPORTHASH+=("$name")
    IMPORTHASH+=("$hash")
  done
}

mkdir -p "$XDG_CACHE_HOME/dhall"

unpack_tars_freeze

dump_cache "BEFORE_GEN" "$XDG_CACHE_HOME/dhall"

cd "$(dirname ${ENTRYPOINT})"
filename=$(basename ${ENTRYPOINT})
input=$(<"$filename")

if [ $FAST -eq 1 ]; then
  for (( i=0; i<${#IMPORTHASH[@]} ; i+=2 ));
  do
    name="${IMPORTHASH[i]}"
    ihash="${IMPORTHASH[i+1]}"
    debug_log "Use $ihash for $name"
    input=$(perl -0777 -pe "s/(env:DHALLBAZEL_$name)\s+sha256:\w+/\1 sha256:$ihash /gmu" <<< "${input}" | perl -0777 -pe "s/(env:DHALLBAZEL_$name)(?:\s+|\z)(?!sha256:)/\1 sha256:$ihash /gmu")
  done

  input=$(${DHALL_BIN} format <<< "${input}")

  debug_log "Freeze Check: ${DHALL_BIN} freeze --check"
  "${DHALL_BIN}" freeze --check <<< "${input}"
else
  debug_log "Freezing: ${DHALL_BIN} freeze --all"
  "${DHALL_BIN}" freeze --all <<< "${input}"
fi

cat <<< "${input}"
