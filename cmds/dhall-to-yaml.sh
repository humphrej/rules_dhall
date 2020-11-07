#!/usr/bin/env bash

# Wrapper script for running dhall-to-yaml

platform=$(uname)

if [[ "$platform" == "Darwin" ]]; then
  BINARY=$(find . -iwholename "*dhall_to_yaml_bin_osx/bin/dhall-to-yaml" | head -n1)
elif [[ "$platform" == "Linux" ]]; then
  BINARY=$(find . -iwholename "*dhall_to_yaml_bin/bin/dhall-to-yaml" | head -n1)
else
  echo "dhall_to_yaml does not have a binary for $platform"
  exit 1
fi

${BINARY} $*
