#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__help_filter() {
  echo
  echo -e "${GITTER_C_HEADING}Gitter${GITTER_C___RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -ne "${GITTER_C_HEADING}Syntax:${GITTER_C___RESET}"
  echo -ne "   ${GITTER_C_____DIM}<${GITTER_C___RESET}${GITTER_C___ERROR}prefix${GITTER_C___RESET}${GITTER_C_____DIM}>${GITTER_C___RESET}"
  echo -ne "${GITTER_C_____DIM}<${GITTER_C___RESET}${GITTER_C_HEADING}:${GITTER_C___RESET}${GITTER_C_____DIM}>${GITTER_C___RESET}"
  echo -ne "${GITTER_C_____DIM}[${GITTER_C___RESET}${GITTER_C___ERROR}+${GITTER_C___RESET}${GITTER_C_____DIM}]${GITTER_C___RESET}"
  echo -ne "${GITTER_C_____DIM}<${GITTER_C___RESET}${GITTER_C___VALUE}pattern${GITTER_C___RESET}${GITTER_C_____DIM}>${GITTER_C___RESET}"
  echo -e  "${GITTER_C_____DIM}[${GITTER_C___RESET}${GITTER_C___ERROR}+${GITTER_C___RESET}${GITTER_C_____DIM}]${GITTER_C___RESET}"
  echo
  echo -e "${GITTER_C_HEADING}Prefixes:${GITTER_C___RESET}"
  echo -e "  ${GITTER_C___ERROR}path  ${GITTER_C___RESET}  Match for path name"
  echo -e "  ${GITTER_C___ERROR}repo  ${GITTER_C___RESET}  Match for repository name"
  echo -e "  ${GITTER_C___ERROR}branch${GITTER_C___RESET}  Match for current git branch"
  echo
  echo -e "${GITTER_C_HEADING}Patterns:${GITTER_C___RESET}"
  echo -e "  ${GITTER_C___ERROR}+${GITTER_C___RESET}          Matches anywhere in the value (default if no anchors specified)"
  echo -e "   ${GITTER_C___VALUE}pattern${GITTER_C___RESET}${GITTER_C___ERROR}+${GITTER_C___RESET}  Matches the beginning of the value"
  echo -e "  ${GITTER_C___ERROR}+${GITTER_C___RESET}${GITTER_C___VALUE}pattern${GITTER_C___RESET}   Matches the end of the value"
  echo -e "  ${GITTER_C___ERROR}+${GITTER_C___RESET}${GITTER_C___VALUE}pattern${GITTER_C___RESET}${GITTER_C___ERROR}+${GITTER_C___RESET}  Matches substring anywhere in the value"
  echo -e "   ${GITTER_C___VALUE}pattern${GITTER_C___RESET}   Matches exactly the value"
  echo
  echo -e "${GITTER_C_HEADING}Examples:${GITTER_C___RESET}"
  echo -e "  ${GITTER_C_COMMAND}gitter ${GITTER_C__OPTION}--filter${GITTER_C___RESET} ${GITTER_C___VALUE}path:src/+${GITTER_C___RESET}                     Filter repositories with path starting with 'src/'"
  echo -e "  ${GITTER_C_COMMAND}gitter ${GITTER_C__OPTION}--exclude --filter${GITTER_C___RESET} ${GITTER_C___VALUE}repo:+-test${GITTER_C___RESET}          Filter repositories with name NOT ending with '-test'"
  echo -e "  ${GITTER_C_COMMAND}gitter ${GITTER_C__OPTION}--filter${GITTER_C___RESET} ${GITTER_C___VALUE}branch:master${GITTER_C___RESET}                  Filter repositories on branch 'master'"
  echo -e "  ${GITTER_C_COMMAND}gitter ${GITTER_C__OPTION}--filter${GITTER_C___RESET} ${GITTER_C___VALUE}path:+src/${GITTER_C___RESET} ${GITTER_C__OPTION}--filter${GITTER_C___RESET} ${GITTER_C___VALUE}path:+test${GITTER_C___RESET} Filter repositories with path containing 'src/' or 'test'"
  echo
}
