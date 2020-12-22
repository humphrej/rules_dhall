#!/usr/bin/env bash

set -euo pipefail

bazel query 'filter("^//", kind("dhall_freeze", //...))' | while read -r target;
do
    ./tools/freeze.sh "$target"
done
