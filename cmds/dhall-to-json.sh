#!/usr/bin/env bash

# Wrapper script for running dhall-to-json

platform=$(uname)

if [[ "$platform" == "Darwin" ]]; then
  BINARY=$(find . -iwholename "*dhall_to_json_bin_osx/bin/dhall-to-json" | head -n1)
elif [[ "$platform" == "Linux" ]]; then
  BINARY=$(find . -iwholename "*dhall_to_json_bin/bin/dhall-to-json" | head -n1)
else
  echo "dhall_to_json does not have a binary for $platform"
  exit 1
fi

${BINARY} $*
