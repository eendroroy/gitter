#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__process_gitterignore() {
  local -n repo_git_dirs="$1"
  [[ ! -f .gitterignore ]] && return

  # Read and clean patterns
  mapfile -t patterns < <(sed -E 's/#.*//; s/^[[:space:]]+//; s/[[:space:]]+$//; /^$/d' .gitterignore)

  local kept_dirs=()
  for dir in "${repo_git_dirs[@]}"; do
    local ignore=false
    local path="${dir#./}"
    local repo_rel_path="$(dirname "$path")"

    for pat in "${patterns[@]}"; do

      echo -n "Path: $path Parent: ${repo_rel_path}, pat: $pat  "

      # Match pattern against:
      # 1. Exact match (path)
      # 2. Starts with pattern (handles foo/*)
      if [[ "$pat" == *"/*" ]]; then
        base_pat="${pat%/*}"
        [[ "$repo_rel_path" == "$base_pat/"* ]] && ignore=true
      else
        [[ "$repo_rel_path" == "$pat" ]] && ignore=true
      fi
      [[ "$ignore" == true ]] && echo match && break || echo not
    done

    [[ "$ignore" == false ]] && kept_dirs+=("$dir")
  done

  repo_git_dirs=("${kept_dirs[@]}")
}
