#!/bin/bash
# Use this script instead of directly running `bazel run //:refresh_compile_commands`
#
# This script is a work-around for:
# https://github.com/hedronvision/bazel-compile-commands-extractor/issues/201
set -e

# Find the directory of this script so it can be run from anywhere.
dir="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"

cd "${dir}"
bazel build //...
BUILD_WORKSPACE_DIRECTORY="${dir}" ./bazel-bin/refresh_compile_commands
