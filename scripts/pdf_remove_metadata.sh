#!/usr/bin/env sh

# SPDX-FileCopyrightText: © 2024 Sebastian Davids <sdavids@gmx.de>
# SPDX-License-Identifier: Apache-2.0

# exiftool needs to be in $PATH
#   Mac:
#     brew install exiftool
#   Linux:
#     sudo apt-get install exiftool

# qpdf needs to be in $PATH
#   Mac:
#     brew install qpdf
#   Linux:
#     sudo apt-get install qpdf

set -eu

if [ -z "$*" ]; then
  echo "Usage: $0 FILE" >&2
  exit 1
fi

if [ ! -f "$1" ]; then
  echo "'$1' does not exist" >&2
  exit 2
fi

exiftool -quiet -ignoreMinorErrors -all:all= -overwrite_original "$1"

qpdf --linearize --replace-input "$1"
