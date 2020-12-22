#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo >&2 "Usage: $0 target"
  echo >&2 "e.g. $0 //some:target_freeze"
  exit 1
fi
target="$1"

input=$(bazel query "labels(entrypoint, $target)" --output location --incompatible_display_source_file_location | grep -o '^.*\.dhall:1:1:' | sed s/:1:1:$//)

output=$(bazel run "$target")
cat > "$input" <<< "${output}"
