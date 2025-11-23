#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__expand_args() {
  local -n args_ref=$1
  local -n parsed_args_ref=$2
  for arg in "${args_ref[@]}"; do
    # {_repo_} -> name of the current git repository
    [[ $arg == *"{_repo_}"* ]] && arg="${arg//\{_repo_\}/$(basename "$(pwd)")}"

    # {_path_} -> relative path of the current working directory from where gitter was invoked
    [[ $arg == *"{_path_}"* ]] && arg="${arg//\{_path_\}/${PWD/"${____CURRENT_DIR}"/.}}"

    # {_path:abs_} -> absolute path of the current working directory}
    [[ $arg == *"{_path:abs_}"* ]] && arg="${arg//\{_path:abs_\}/$(pwd)}"

    # {_branch_} -> current git branch name
    [[ $arg == *"{_branch_}"* ]] && arg="${arg//\{_branch_\}/$(git branch --show-current 2>/dev/null)}"

    # {_commit_} -> current git commit hash
    [[ $arg == *"{_commit_}"* ]] && arg="${arg//\{_commit_\}/$(git log -1 --format="%H" 2>/dev/null)}"

    # {_commit:[int]_} -> current git commit hash abbreviated to [int] characters
    if [[ $arg =~ \{_commit:([0-9]+)_\} ]]; then
      abbrev_length="${BASH_REMATCH[1]}"
      abbrev_commit="$(git log -1 --format="%h" --abbrev="$abbrev_length" 2>/dev/null)"
      arg="${arg//\{_commit:${abbrev_length}_\}/$abbrev_commit}"
    fi

    # {_author_} -> current git commit author email
    [[ $arg == *"{_author_}"* ]] && arg="${arg//\{_author_\}/$(git log -1 --format="%ae" 2>/dev/null)}"

    [[ "$debug" == true ]] && {
      echo -e "${_C_____DIM}Debug:${_C___RESET} Parsed argument: ${_C____ARGS}${arg}${_C___RESET}"
    }

    parsed_args_ref+=("$arg")
  done
}