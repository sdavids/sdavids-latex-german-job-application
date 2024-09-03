#!/usr/bin/env sh

# SPDX-FileCopyrightText: © 2024 Sebastian Davids <sdavids@gmx.de>
# SPDX-License-Identifier: Apache-2.0

set -eu

# https://hub.docker.com/r/kjarosh/latex
readonly latex_version=2024.4
readonly latex_image="kjarosh/latex:${latex_version}"

# https://stackoverflow.com/a/3915420
# https://stackoverflow.com/questions/3915040/how-to-obtain-the-absolute-path-of-a-file-via-shell-bash-zsh-sh#comment100267041_3915420
command -v realpath >/dev/null 2>&1 || realpath() {
  if [ -h "$1" ]; then
    # shellcheck disable=SC2012
    ls -ld "$1" | awk '{ print $11 }'
  else
    echo "$(
      cd "$(dirname -- "$1")" >/dev/null
      pwd -P
    )/$(basename -- "$1")"
  fi
}

while getopts ':fno:r:s:v' opt; do
  case "${opt}" in
    f)
      force='true'
      ;;
    n)
      no_cache='true'
      ;;
    o)
      out_dir="${OPTARG}"
      ;;
    r)
      root_file="${OPTARG}"
      ;;
    s)
      src_dir="${OPTARG}"
      ;;
    v)
      verbose='true'
      ;;
    ?)
      echo "Usage: $0 -r <rootFile> [-s <sourceDirectory>] [-o <outputDirectory>] [-f] [-v]" >&2
      exit 1
      ;;
  esac
done

readonly root_file="${root_file:?ROOT FILE is required}"

readonly force="${force:-false}"
readonly no_cache="${no_cache:-false}"
readonly verbose="${verbose:-false}"

src_dir="${src_dir:-$PWD/src}"

if [ ! -d "${src_dir}" ]; then
  printf "The source directory '%s' does not exist\n" "${src_dir}" >&2
  exit 1
fi

if [ ! -f "${src_dir}/${root_file}" ]; then
  printf "The root document '%s' does not exist\n" "${src_dir}/${root_file}" >&2
  exit 2
fi

src_dir="$(realpath "${src_dir}")"
readonly src_dir

out_dir="${out_dir:-$PWD/build}"

if [ "${force}" = 'true' ] \
  && [ -d "${out_dir}" ] \
  && [ "${out_dir}" != "$PWD" ] \
  && [ "${out_dir}" != '.' ]; then

  rm -rf "${out_dir}"
fi

mkdir -p "${out_dir}"

out_dir="$(realpath "${out_dir}")"
readonly out_dir

# https://github.com/kjarosh/latex-docker/issues/13
if [ "$(uname)" = 'Darwin' ]; then
  platform='--platform=linux/amd64'
else
  platform=''
fi
readonly platform

if [ "${no_cache}" = 'false' ]; then
  aux_dir='/out/aux'
else
  aux_dir='/tmp/aux'
fi

# https://ctan.gust.org.pl/tex-archive/support/latexmk/latexmk.pdf
if [ "${verbose}" = 'true' ]; then
  docker container run "${platform}" \
    --user "$(id -u):$(id -g)" \
    --rm \
    --security-opt='no-new-privileges=true' \
    --cap-drop=all \
    --network='none' \
    --mount "type=bind,src=${src_dir},dst=/src,ro" \
    --mount "type=bind,src=${out_dir},dst=/out" \
    --workdir /src \
    "${latex_image}" \
    latexmk \
    -pdfxe \
    -aux-directory="${aux_dir}" \
    -output-directory=/out \
    "${root_file}"
else
  docker container run "${platform}" \
    --user "$(id -u):$(id -g)" \
    --rm \
    --security-opt='no-new-privileges=true' \
    --cap-drop=all \
    --network='none' \
    --mount "type=bind,src=${src_dir},dst=/src,ro" \
    --mount "type=bind,src=${out_dir},dst=/out" \
    --workdir /src \
    "${latex_image}" \
    latexmk \
    -quiet \
    -pdfxe \
    -aux-directory="${aux_dir}" \
    -output-directory=/out \
    "${root_file}" >/dev/null
fi
