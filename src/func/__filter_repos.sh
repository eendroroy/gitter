#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__filter_repos() {
  # $1: name of array variable with repo git dirs
  local -n repo_list="$1"
  local filtered_repo_git_dirs=()

  for repo_git_dir in "${repo_list[@]}"; do

    if [[ ${#GITTER_FILTERS[@]} -eq 0 ]]; then
      filtered_repo_git_dirs+=("$repo_git_dir")
      continue
    fi

    match=false
    for filter in "${GITTER_FILTERS[@]}"; do
      filter_key="${filter%%:*}"
      filter_value="${filter#*:}"

      repo_dir="$(dirname "$repo_git_dir")"

      case "$filter_key" in
        path  ) value="$repo_dir" ;;
        repo  ) value="$(basename "$repo_dir")" ;;
        branch) value="$(git -C "$repo_dir" branch --show-current 2>/dev/null)" ;;
        *)
          echo -e "${GITTER_C___ERROR}${GITTER___ERROR_SYMBOL}  Unknown filter key: ${filter_key}${GITTER_C___RESET}" 1>&2
          exit 1
          ;;
      esac

      if __match_filter "$value" "$filter_value"; then
        match=true && break
      fi
    done

    if [[ "$GITTER_FILTER_EXCLUDE" == false && "$match" == true ]]; then
      filtered_repo_git_dirs+=("$repo_git_dir")
    fi

    if [[ "$GITTER_FILTER_EXCLUDE" == true && "$match" == false ]]; then
      filtered_repo_git_dirs+=("$repo_git_dir")
    fi
  done

  repo_list=("${filtered_repo_git_dirs[@]}")
}
