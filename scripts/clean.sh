#!/usr/bin/env sh

# SPDX-FileCopyrightText: © 2024 Sebastian Davids <sdavids@gmx.de>
# SPDX-License-Identifier: Apache-2.0

# script needs to be invoked from the project's root

set -eu

readonly build_dir="${1:-$PWD/build}"

rm -rf "${build_dir}"
