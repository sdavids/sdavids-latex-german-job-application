#!/usr/bin/env sh

# SPDX-FileCopyrightText: © 2024 Sebastian Davids <sdavids@gmx.de>
# SPDX-License-Identifier: Apache-2.0

set -eu

while getopts ':d:e:n' opt; do
  case "${opt}" in
    d)
      base_dir="${OPTARG}"
      ;;
    e)
      expire="${OPTARG}"
      ;;
    n)
      dry_run='--dry-run'
      ;;
    ?)
      echo "Usage: $0 [-d <git repo dir>] [-e <date>] [-n]" >&2
      exit 1
      ;;
  esac
done

readonly base_dir="${base_dir:-$PWD}"
readonly expire="${expire:-1.month.ago}"
readonly dry_run="${dry_run:-}"

if [ ! -d "${base_dir}" ]; then
  printf "The directory '%s' does not exist.\n" "${base_dir}" >&2
  exit 2
fi

(
  cd "${base_dir}"

  if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" != 'true' ]; then
    echo "'${base_dir}' is not a git repository" >&2
    exit 3
  fi

  # shellcheck disable=SC2086
  git clean -fdx \
    ${dry_run} \
    -e .fleet \
    -e .idea \
    -e .vscode \
    .

  if [ -n "${dry_run}" ]; then
    exit 0
  fi

  origin_url="$(git remote get-url origin 2>/dev/null || echo '')"
  if [ -n "${origin_url}" ]; then
    set +e
    git ls-remote --exit-code --heads origin refs/heads/main >/dev/null 2>/dev/null
    remote_exits=$?
    set -e

    if [ ${remote_exits} -eq 0 ]; then
      git fetch --all --prune --prune-tags
      git remote prune origin 1>/dev/null
    else
      git remote remove origin 1>/dev/null
    fi
  fi

  git repack -d --quiet
  git rerere clear
  rm -rf .git/rr-cache
  git reflog expire --expire="${expire}" --expire-unreachable=now 1>/dev/null
  git gc --aggressive --prune="${expire}"
)
