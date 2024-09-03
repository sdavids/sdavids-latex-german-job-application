#!/usr/bin/env bash

# SPDX-FileCopyrightText: © 2024 Sebastian Davids <sdavids@gmx.de>
# SPDX-License-Identifier: Apache-2.0

# shfmt needs to be in $PATH
# https://github.com/mvdan/sh
#   Mac:
#     brew install shfmt
#   Linux:
#     sudo apt-get install shfmt

set -Eeu -o pipefail -o posix

while getopts ':v' opt; do
  case "${opt}" in
    v)
      verbose='true'
      ;;
    ?)
      echo "Usage: $0 [-v] <dir>" >&2
      exit 1
      ;;
  esac
done
shift $((OPTIND - 1))

readonly verbose="${verbose:-false}"

readonly base_dir="${1:-$PWD}"

if [ "${verbose}" = 'true' ]; then
  shfmt --diff --indent 2 --case-indent --binary-next-line --simplify "${base_dir}"
else
  shfmt --diff --indent 2 --case-indent --binary-next-line --simplify "${base_dir}" >/dev/null
fi
