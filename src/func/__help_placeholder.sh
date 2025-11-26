#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__help_placeholder() {
  echo
  echo -e "${GITTER_C_HEADING}Gitter${GITTER_C___RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -e "${GITTER_C_HEADING}Placeholders:${GITTER_C___RESET}"
  echo -e "  Within ${GITTER_C__OPTION}exec${GITTER_C___RESET} and ${GITTER_C__OPTION}git${GITTER_C___RESET} commands, the following placeholders can be used in arguments:"
  echo -e "    ${GITTER_C_____ARG}{_repo_}${GITTER_C___RESET}         Name of the current git repository"
  echo -e "    ${GITTER_C_____ARG}{_path:r_}${GITTER_C___RESET}       Relative path of the current working directory from where gitter was invoked"
  echo -e "    ${GITTER_C_____ARG}{_path:a_}${GITTER_C___RESET}       Absolute path of the current working directory"
  echo -e "    ${GITTER_C_____ARG}{_branch_}${GITTER_C___RESET}       Current git branch name"
  echo -e "    ${GITTER_C_____ARG}{_commit:f_}${GITTER_C___RESET}     Current git commit hash"
  echo -e "    ${GITTER_C_____ARG}{_commit:[int]_}${GITTER_C___RESET} Current git commit hash abbreviated to [int] characters. i.e. ${GITTER_C_____ARG}{_commit:8_}${GITTER_C___RESET}"
  echo -e "    ${GITTER_C_____ARG}{_author:e_}${GITTER_C___RESET}     Current git commit author email"
  echo -e "    ${GITTER_C_____ARG}{_author:n_}${GITTER_C___RESET}     Current git commit author name"
  echo -e "    ${GITTER_C_____ARG}{_time:r_}${GITTER_C___RESET}       Relative time of the current git commit (e.g., \"2 days ago\")"
  echo -e "    ${GITTER_C_____ARG}{_time:d_}${GITTER_C___RESET}       Date and time of the current git commit (e.g., \"2024-01-01 12:00:00\")"
  echo
  echo -e "${GITTER_C_HEADING}Example Usage:${GITTER_C___RESET}"
  echo -e "  ${GITTER_C_COMMAND}gitter${GITTER_C___RESET} ${GITTER_C__OPTION}exec${GITTER_C___RESET} -- echo \
\"Repository: ${GITTER_C_____ARG}{_repo_}${GITTER_C___RESET}, \
Branch: ${GITTER_C_____ARG}{_branch_}${GITTER_C___RESET}, \
Commit: ${GITTER_C_____ARG}{_commit:8_}${GITTER_C___RESET}\
Author: ${GITTER_C_____ARG}{_author:e_}${GITTER_C___RESET}, \
Date: ${GITTER_C_____ARG}{_time:d_}${GITTER_C___RESET}\""
  echo
}
