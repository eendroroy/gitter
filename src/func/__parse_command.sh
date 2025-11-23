#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__parse_command() {
  if [[ -n "$command" ]]; then
    [[ "$debug" == true ]] && {
      echo
      echo -e "${_C_____DIM}Debug:${_C___RESET} Existing command type: ${_C__OPTION}${command}${_C___RESET}"
      echo -e "${_C_____DIM}Debug:${_C___RESET} New command type:      ${_C__OPTION}${1}${_C___RESET}"
    }
    echo
    echo -e "\n${_C___ERROR}Multiple command types specified${_C___RESET}" 1>&2
    echo
    echo -e "Run ${_C_COMMAND}gitter --help${_C___RESET} for usage information." 1>&2
    echo
    exit 1
  fi
  command="${1}"
}
