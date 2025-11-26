#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__repo_status() {
  if [[ "$GITTER_VERBOSE" == true ]]; then
    local -a PATTERNS=("${GITTER_REPO_STATUS_VERBOSE[@]}")
  else
    local -a PATTERNS=("${GITTER_REPO_STATUS[@]}")
  fi
  (
    cd "$1" 2>/dev/null || {
      echo -e "${GITTER_C___ERROR}${GITTER_PRIMARY_SYMBOL}  Failed to enter: ${1}${GITTER_C___RESET}" 1>&2
      exit 1
    }

    echo -ne "$(__print_path)"
    for pattern in "${PATTERNS[@]}"; do
      case "$pattern" in
        "[branch]"   ) echo -ne "${GITTER_C_COMMAND}$(git branch --show-current)${GITTER_C___RESET}";;
        "[commit:a]" ) echo -ne "${GITTER_C___VALUE}$(git log -1 --format="%h" --abbrev=8)${GITTER_C___RESET}";;
        "[commit:f]" ) echo -ne "${GITTER_C___VALUE}$(git log -1 --format="%H")${GITTER_C___RESET}";;
        "[time:r]"   ) echo -ne "${GITTER_C_____ARG}$(git log -1 --format="%cr")${GITTER_C___RESET}";;
        "[time:d]"   ) echo -ne "${GITTER_C_____ARG}$(git log -1 --format="%cd")${GITTER_C___RESET}";;
        "[author:e]" ) echo -ne "${GITTER_C__OPTION}$(git log -1 --format="%ae")${GITTER_C___RESET}";;
        "[author:n]" ) echo -ne "${GITTER_C__OPTION}$(git log -1 --format="%an")${GITTER_C___RESET}";;
        *              ) echo -ne "${GITTER_C_____DIM}${pattern}${GITTER_C___RESET}" ;;
      esac
    done
  )
}
