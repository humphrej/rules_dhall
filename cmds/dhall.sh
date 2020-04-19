#!/usr/bin/env bash

# Wrapper script for running dhall

platform=$(uname)

if [[ "$platform" == "Darwin" ]]; then
  BINARY=$(find . -iwholename "*dhall_bin_osx/bin/dhall" | head -n1)
elif [[ "$platform" == "Linux" ]]; then
  BINARY=$(find . -iwholename "*dhall_bin/bin/dhall" | head -n1)
else
  echo "dhall does not have a binary for $platform"
  exit 1
fi

${BINARY} $*
