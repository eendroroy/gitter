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
    [[ $arg == *"{_repo_}"* ]] && arg="${arg//\{_repo_\}/$(basename "$(pwd)")}"
    [[ $arg == *"{_path:r_}"* ]] && arg="${arg//\{_path:r_\}/${PWD/"${____CURRENT_DIR}"/.}}"
    [[ $arg == *"{_path:a_}"* ]] && arg="${arg//\{_path:a_\}/$(pwd)}"
    [[ $arg == *"{_branch_}"* ]] && arg="${arg//\{_branch_\}/$(git branch --show-current 2>/dev/null)}"
    [[ $arg == *"{_commit:f_}"* ]] && arg="${arg//\{_commit:f_\}/$(git log -1 --format="%H" 2>/dev/null)}"
    [[ $arg =~ \{_commit:([0-9]+)_\} ]] && {
      abbrev_length="${BASH_REMATCH[1]}"
      abbrev_commit="$(git log -1 --format="%h" --abbrev="$abbrev_length" 2>/dev/null)"
      arg="${arg//\{_commit:${abbrev_length}_\}/$abbrev_commit}"
    }
    [[ $arg == *"{_time:r_}"* ]] && arg="${arg//\{_time:r_\}/$(git log -1 --format="%cr" 2>/dev/null)}"
    [[ $arg == *"{_time:d_}"* ]] && arg="${arg//\{_time:d_\}/$(git log -1 --format="%cd" 2>/dev/null)}"
    [[ $arg == *"{_author:e_}"* ]] && arg="${arg//\{_author:e_\}/$(git log -1 --format="%ae" 2>/dev/null)}"
    [[ $arg == *"{_author:n_}"* ]] && arg="${arg//\{_author:n_\}/$(git log -1 --format="%an" 2>/dev/null)}"

    parsed_args_ref+=("$arg")
  done
}
