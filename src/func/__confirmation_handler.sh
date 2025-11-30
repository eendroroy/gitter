#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__ask_to_proceed() {
  echo -ne "   ${GITTER_C_____DIM}Press any key to continue, 's' to skip 'q' to quit...${GITTER_C___RESET}"
  read -rsn1 input_key

  if [[ "$input_key" == "s" || "$input_key" == "S" ]]; then
    echo -e "\r   ${GITTER_C___ERROR}Skipping...${GITTER_C___RESET}                                                               "
    return 1
  fi

  if [[ "$input_key" == "q" || "$input_key" == "Q" ]]; then
    echo -e "\r   ${GITTER_C___ERROR}Quitting...${GITTER_C___RESET}                                                               "
    return 2
  fi

  printf '\r\033[2K'
  return 0
}

__ask_on_error() {
  echo -ne "   ${GITTER_C___ERROR}Errors occurred (${1}). Press any key to continue or 'q' to quit...${GITTER_C___RESET}"
  read -rsn1 input_key
  if [[ "$input_key" == "q" || "$input_key" == "Q" ]]; then
    echo -e "\r   ${GITTER_C___ERROR}Quitting...${GITTER_C___RESET}                                                               "
    exit "$1"
  fi
  printf '\r\033[2K'
}