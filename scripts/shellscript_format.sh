#!/usr/bin/env sh

# SPDX-FileCopyrightText: © 2024 Sebastian Davids <sdavids@gmx.de>
# SPDX-License-Identifier: Apache-2.0

# shfmt needs to be in $PATH
# https://github.com/mvdan/sh
#   Mac:
#     brew install shfmt
#   Linux:
#     sudo apt-get install shfmt

set -eu

readonly base_dir="${1:-$PWD}"

shfmt --write --indent 2 --case-indent --binary-next-line --simplify "${base_dir}"
