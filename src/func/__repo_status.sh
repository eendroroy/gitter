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
  (
    cd "$1" 2>/dev/null || {
      echo -e "${GITTER_C___ERROR}${GITTER_PRIMARY_SYMBOL}  Failed to enter: ${1}${GITTER_C___RESET}" 1>&2
      exit 1
    }

    echo -ne "$(__print_path)"
    [[ $GITTER_VERBOSE == true || $2 = true ]] && echo -ne " ${GITTER_C_____DIM}on${GITTER_C___RESET} ${GITTER_C_COMMAND}$(git branch --show-current)${GITTER_C___RESET}"
    [[ $GITTER_VERBOSE == true ]] && echo -ne " ${GITTER_C___VALUE}$(git log -1 --format="%h" --abbrev=8)${GITTER_C___RESET}"
    [[ $GITTER_VERBOSE == true ]] && echo -ne " ${GITTER_C____ARGS}$(git log -1 --format="%cr")${GITTER_C___RESET}"
    [[ $GITTER_VERBOSE == true ]] && echo -ne " ${GITTER_C_____DIM}by${GITTER_C___RESET} ${GITTER_C__OPTION}$(git log -1 --format="%ae")${GITTER_C___RESET}"
  )
}
