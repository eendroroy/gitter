#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

___print_config_value() {
  echo -e "  ${GITTER_C__OPTION}${1}${GITTER_C___RESET}${GITTER_C_COMMAND}${2}${GITTER_C___RESET}=${GITTER_C_____ARG}${3}${GITTER_C___RESET}"
}

__print_config() {
  echo
  echo -e "${GITTER_C_HEADING}Symbols:${GITTER_C___RESET}"
  ___print_config_value "" "               GITTER_SUCCESS_SYMBOL" "'${GITTER_SUCCESS_SYMBOL}'"
  ___print_config_value "" "               GITTER___ERROR_SYMBOL" "'${GITTER___ERROR_SYMBOL}'"
  ___print_config_value "" "               GITTER_PRIMARY_SYMBOL" "'${GITTER_PRIMARY_SYMBOL}'"
  echo
  echo -e "${GITTER_C_HEADING}Configurations:${GITTER_C___RESET}"
  ___print_config_value "" "                    GITTER_MAX_DEPTH" "'${GITTER_MAX_DEPTH}'"
  ___print_config_value "" "                      GITTER_FILTERS" "(${GITTER_FILTERS[*]})"
  ___print_config_value "" "                      GITTER_VERBOSE" "'${GITTER_VERBOSE}'"
  ___print_config_value "" "               GITTER_FILTER_EXCLUDE" "'${GITTER_FILTER_EXCLUDE}'"
  ___print_config_value "" "                     GITTER_NO_COLOR" "'${GITTER_NO_COLOR}'"
  ___print_config_value "" "                  GITTER_REPO_STATUS" "(${GITTER_REPO_STATUS[*]})"
  ___print_config_value "" "          GITTER_REPO_STATUS_VERBOSE" "(${GITTER_REPO_STATUS_VERBOSE[*]})"
  echo
  echo -e "${GITTER_C_HEADING}Colors:${GITTER_C___RESET}"
  ___print_config_value "(${GITTER_C_SUCCESS}Success color ${GITTER_C___RESET})  " "GITTER_C_SUCCESS" "'\\${GITTER_C_SUCCESS}'"
  ___print_config_value "(${GITTER_C___ERROR}Error color   ${GITTER_C___RESET})  " "GITTER_C___ERROR" "'\\${GITTER_C___ERROR}'"
  ___print_config_value "(${GITTER_C____PATH}Path color    ${GITTER_C___RESET})  " "GITTER_C____PATH" "'\\${GITTER_C____PATH}'"
  ___print_config_value "(${GITTER_C_PATH_DM}Path Dim color${GITTER_C___RESET})  " "GITTER_C_PATH_DM" "'\\${GITTER_C_PATH_DM}'"
  ___print_config_value "(${GITTER_C_____DIM}Dim color     ${GITTER_C___RESET})  " "GITTER_C_____DIM" "'\\${GITTER_C_____DIM}'"
  ___print_config_value "(${GITTER_C_HEADING}Heading color ${GITTER_C___RESET})  " "GITTER_C_HEADING" "'\\${GITTER_C_HEADING}'"
  ___print_config_value "(${GITTER_C_COMMAND}Command color ${GITTER_C___RESET})  " "GITTER_C_COMMAND" "'\\${GITTER_C_COMMAND}'"
  ___print_config_value "(${GITTER_C_____ARG}Argument color${GITTER_C___RESET})  " "GITTER_C_____ARG" "'\\${GITTER_C_____ARG}'"
  ___print_config_value "(${GITTER_C__OPTION}Option color  ${GITTER_C___RESET})  " "GITTER_C__OPTION" "'\\${GITTER_C__OPTION}'"
  ___print_config_value "(${GITTER_C___VALUE}Value color   ${GITTER_C___RESET})  " "GITTER_C___VALUE" "'\\${GITTER_C___VALUE}'"
  echo
}