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

    [[ "$debug" == true ]] && {
      echo -e "${_C_____DIM}Debug:${_C___RESET} Processing repository: ${_C____PATH}$(dirname "$repo_git_dir")${_C___RESET}"
    }

    if [[ ${#filters[@]} -eq 0 ]]; then
      [[ "$debug" == true ]] && {
        echo -e "${_C_____DIM}Debug:${_C___RESET} No filters specified, including repository: ${_C____PATH}$(dirname "$repo_git_dir")${_C___RESET} by default"
        echo
        echo
      }
      filtered_repo_git_dirs+=("$repo_git_dir")
      continue
    fi

    match=false
    for filter in "${filters[@]}"; do
      [[ "$debug" == true ]] && {
        echo -e "${_C_____DIM}Debug:${_C___RESET} Applying filter: ${_C__OPTION}${filter}${_C___RESET}"
      }

      filter_key="${filter%%:*}"
      filter_value="${filter#*:}"

      repo_dir="$(dirname "$repo_git_dir")"

      case "$filter_key" in
        P|path  ) value="$repo_dir" ;;
        R|repo  ) value="$(basename "$repo_dir")" ;;
        B|branch) value="$(git -C "$repo_dir" branch --show-current 2>/dev/null)" ;;
        *)
          echo -e "${_C___ERROR}${___ERROR_SYMBOL}  Unknown filter key: ${filter_key}${_C___RESET}" 1>&2
          exit 1
          ;;
      esac

      if __match_filter "$value" "$filter_value"; then
        [[ "$debug" == true ]] && {
          echo -e "${_C_____DIM}Debug:${_C___RESET} Filter matched: ${_C__OPTION}${filter}${_C___RESET} for value: ${_C____PATH}${value}${_C___RESET}"
        }
        match=true && break
      fi
    done

    if [[ "$exclude" == false && "$match" == true ]]; then
      [[ "$debug" == true ]] && {
        echo -e "${_C_____DIM}Debug:${_C___RESET} Including repository: ${_C____PATH}$(dirname "$repo_git_dir")${_C___RESET}"
      }
      filtered_repo_git_dirs+=("$repo_git_dir")
    fi

    if [[ "$exclude" == true && "$match" == false ]]; then
      [[ "$debug" == true ]] && {
        echo -e "${_C_____DIM}Debug:${_C___RESET} Including repository: ${_C____PATH}$(dirname "$repo_git_dir")${_C___RESET}"
      }
      filtered_repo_git_dirs+=("$repo_git_dir")
    fi

    [[ "$debug" == true ]] && {
      echo
      echo
    }
  done

  repo_list=("${filtered_repo_git_dirs[@]}")
}
