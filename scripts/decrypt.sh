#!/usr/bin/env sh

# SPDX-FileCopyrightText: © 2024 Sebastian Davids <sdavids@gmx.de>
# SPDX-License-Identifier: Apache-2.0

# age
#   Mac:
#     brew install age
#   Linux:
#     sudo apt-get install age

# sops
#   Mac:
#     brew install sops
#   Linux:
#     https://github.com/getsops/sops/releases

set -eu

readonly base_dir="${1:-$PWD}"

sops decrypt -i "${base_dir}/src/sdavids-cover-letter.tex"
sops decrypt -i "${base_dir}/src/sdavids-cv.tex"
sops decrypt -i "${base_dir}/src/sdavids-qualification-profile.tex"
