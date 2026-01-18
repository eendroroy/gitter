#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

___duration_to_seconds() {
    local input="$1"
    local total_seconds=0

    # Extended regex to extract numbers before specific units
    # Works in Bash 3.2+ (macOS default) and Bash 4/5+ (Linux)

    # Extract years (y) -> 31,536,000 seconds
    [[ $input =~ ([0-9]+)y ]]  && (( total_seconds += ${BASH_REMATCH[1]} * 31536000 ))

    # Extract months (mo) -> 2,592,000 seconds (30 days)
    [[ $input =~ ([0-9]+)mo ]] && (( total_seconds += ${BASH_REMATCH[1]} * 2592000 ))

    # Extract weeks (w) -> 604,800 seconds
    [[ $input =~ ([0-9]+)w ]]  && (( total_seconds += ${BASH_REMATCH[1]} * 604800 ))

    # Extract days (d) -> 86,400 seconds
    # Note: We look for 'd' NOT preceded by 'm' to avoid 'mo' conflict
    if [[ $input =~ ([0-9]+)d ]]; then
        (( total_seconds += ${BASH_REMATCH[1]} * 86400 ))
    fi

    # Extract hours (h) -> 3,600 seconds
    [[ $input =~ ([0-9]+)h ]]  && (( total_seconds += ${BASH_REMATCH[1]} * 3600 ))

    # Extract minutes (m) -> 60 seconds
    # Regex ensures we get 'm' but not 'mo'
    if [[ $input =~ ([0-9]+)m([^o]|$) ]]; then
        (( total_seconds += ${BASH_REMATCH[1]} * 60 ))
    fi

    # Extract seconds (s)
    [[ $input =~ ([0-9]+)s ]]  && (( total_seconds += ${BASH_REMATCH[1]} ))

    echo "$total_seconds"
}

__match_filter_text() {
  local value="$1" pattern="$2"

  # Special-case: single '+' matches everything
  [[ "$pattern" == "+" ]] && return 0

  local has_leading has_trailing
  if [[ "$pattern" == \+* ]]; then
    has_leading=1
    pattern="${pattern#\+}"
  fi
  if [[ "$pattern" == *\+ ]]; then
    has_trailing=1
    pattern="${pattern%\+}"
  fi

  [[ -z "$pattern" ]] && return 0

  if [[ -n "$has_leading" && -n "$has_trailing" ]]; then
    [[ "$value" == *"$pattern"* ]]
  elif [[ -n "$has_leading" ]]; then
    [[ "$value" == *"$pattern" ]]
  elif [[ -n "$has_trailing" ]]; then
    [[ "$value" == "$pattern"* ]]
  else
    [[ "$value" == "$pattern" ]]
  fi
}

__apply_filter() {
  local repo_git_dir="$1"
  local filter="$2"

  filter_key="${filter%%:*}"
  filter_value="${filter#*:}"

  repo_dir="$(dirname "$repo_git_dir")"

  case "$filter_key" in
    path  ) value="$repo_dir" ;;
    repo  ) value="$(basename "$repo_dir")"; [[ "$value" == "." ]] && value=$(basename "$(realpath .)") ;;
    branch) value="$(git -C "$repo_dir" branch --show-current 2>/dev/null)" ;;
    remote) value="$(git -C "$repo_dir" remote 2>/dev/null)" ;;
    dirty ) value="$(git -C "$repo_dir" status --porcelain 2>/dev/null)" ;;
    stale ) value="$(( $(date +%s) - $(git -C "$repo_dir" log -1 --format=%ct) ))" ;;
    type  ) value=$(__project_type "$repo_dir" "$filter_value" && echo "$filter_value" || echo "OTHER") ;;
    *)
      echo -e "${GITTER_C____ERROR}${GITTER___ERROR_SYMBOL}  Unknown filter key: ${filter_key}${GITTER_C____RESET}" 1>&2
      exit 1
      ;;
  esac

  case "$filter_key" in
    path|repo|branch|remote)
      __match_filter_text "$value" "$filter_value" && echo 1 || echo 0
      ;;
    type)
      [[ "$value" == "$filter_value" ]] && echo 1 || echo 0
      ;;
    dirty)
      [[ ( "$filter_value" != "false" && -n "$value" ) || ( "$filter_value" == "false" && -z "$value" ) ]] && echo 1 || echo 0
      ;;
    stale)
      [[ "$value" -ge "$(___duration_to_seconds "$filter_value")" ]] && echo 1 || echo 0
      ;;
  esac
}

__filter_repositories() {
  local -n repos_ref="$1"
  local expr="$FILTER"
  local original_expr eval_expr filter

  if [[ -z "${expr//[[:space:]]/}" ]]; then
    return
  fi

  for git_repo_dir in "${repos_ref[@]}"; do
    original_expr="$expr"
    eval_expr="${expr//[()&|!]/ }"

    for filter in $eval_expr; do
      original_expr="${original_expr//$filter/"$(__apply_filter "$git_repo_dir" "$filter")"}"
    done

    if (( original_expr )); then
      filtered_repositories+=("$git_repo_dir")
    fi
  done

  repos_ref=("${filtered_repositories[@]}")
}
