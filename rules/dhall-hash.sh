#!/usr/bin/env bash
#
# Script that displays the hash of a dhall packaged tar file
#
if [ $# -lt 1 ]; then
  echo "Usage: $0 <dep-tar-file>"
  exit 2
fi

tar -tf $1 | grep 1220 | sed 's/.*1220/sha256:/'
