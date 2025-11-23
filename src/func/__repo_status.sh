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
      echo -e "${_C___ERROR}${_PRIMARY_SYMBOL}  Failed to enter: ${1}${_C___RESET}" 1>&2
      exit 1
    }

    echo -ne "$(__print_path)"
    [[ $verbose == true || $2 = true ]] && echo -ne " ${_C_____DIM}on${_C___RESET} ${_C_COMMAND}$(git branch --show-current)${_C___RESET}"
    [[ $verbose == true ]] && echo -ne " ${_C___VALUE}$(git log -1 --format="%h" --abbrev=8)${_C___RESET}"
    [[ $verbose == true ]] && echo -ne " ${_C____ARGS}$(git log -1 --format="%cr")${_C___RESET}"
    [[ $verbose == true ]] && echo -ne " ${_C_____DIM}by${_C___RESET} ${_C__OPTION}$(git log -1 --format="%ae")${_C___RESET}"
  )
}
