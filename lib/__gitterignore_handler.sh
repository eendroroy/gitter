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
  mapfile -t ignore_patterns < <(sed -e 's/#.*//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e '/^$/d' .gitterignore)

  if [[ ${#ignore_patterns[@]} -gt 0 ]]; then
    kept_repo_git_dirs=()
    for repo_git_dir in "${repo_git_dirs[@]}"; do
      git_repo_dir_name="$(dirname "${repo_git_dir#./}")"
      for pattern in "${ignore_patterns[@]}"; do
        if [[ "$pattern" == '*/'* ]]; then
          IFS='/' read -r -a path_parts <<< "$git_repo_dir_name"
          ignore=false
          for part in "${path_parts[@]}"; do
            if [[ "$part" == "${pattern#*/}" ]]; then
              ignore=true
              break
            fi
          done
          [[ "$ignore" == true ]] && break
        elif [[ "$pattern" == *'/*' ]]; then
          parent_dir="${git_repo_dir_name%%/*}"
          if [[ "$parent_dir" == "${pattern%/*}" ]]; then
            ignore=true
            break
          fi
        else
          repo_name="$(basename "$(dirname "$repo_git_dir")")"
          if [[ "$repo_name" == "$pattern" ]]; then
            ignore=true
            break
          fi
          if [[ "$git_repo_dir_name" == "$pattern" ]]; then
            ignore=true
            break
          fi
        fi
      done

      [[ "$ignore" == false ]] && kept_repo_git_dirs+=("$repo_git_dir")
    done

    repo_git_dirs=("${kept_repo_git_dirs[@]}")
  fi
}
