#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__help() {
  echo
  echo -e "${GITTER_C_HEADING}Gitter${GITTER_C___RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -e "${GITTER_C_HEADING}Version:${GITTER_C___RESET} ${GITTER_C__OPTION}${____GITTER_VERSION}${GITTER_C___RESET}"
  echo
  echo -e "${GITTER_C_HEADING}Usage:${GITTER_C___RESET}"
  echo -ne "  ${GITTER_C_COMMAND}gitter${GITTER_C___RESET} [[${GITTER_C__OPTION}--exclude${GITTER_C___RESET}] ${GITTER_C__OPTION}--filter <${GITTER_C___VALUE}pattern${GITTER_C___RESET}${GITTER_C__OPTION}>${GITTER_C___RESET} ...] [${GITTER_C__OPTION}--<option>${GITTER_C___RESET} ...]"
  echo -ne " [${GITTER_C__OPTION}git${GITTER_C___RESET} ${GITTER_C__OPTION}--${GITTER_C___RESET} <${GITTER_C_____ARG}args ...${GITTER_C___RESET}>${GITTER_C___RESET}"
  echo -ne "|${GITTER_C__OPTION}exec${GITTER_C___RESET} ${GITTER_C__OPTION}--${GITTER_C___RESET} <${GITTER_C_____ARG}args ...${GITTER_C___RESET}>${GITTER_C___RESET}"
  echo -ne "|${GITTER_C__OPTION}list${GITTER_C___RESET}"
  echo -e "|${GITTER_C__OPTION}help${GITTER_C___RESET} [${GITTER_C___VALUE}item${GITTER_C___RESET}]]"
  echo
  echo -e "${GITTER_C_HEADING}Commands:${GITTER_C___RESET}"
  echo -e "  ${GITTER_C__OPTION}git    g ${GITTER_C___RESET}        Run a git command (${GITTER_C_____ARG}default${GITTER_C___RESET})"
  echo -e "  ${GITTER_C__OPTION}exec   x ${GITTER_C___RESET}        Run an arbitrary command"
  echo -e "  ${GITTER_C__OPTION}list   ls${GITTER_C___RESET}        List repositories only"
  echo -e "  ${GITTER_C__OPTION}       ll${GITTER_C___RESET}        Equivalent to ${GITTER_C__OPTION}list --verbose${GITTER_C___RESET} command"
  echo -e "  ${GITTER_C__OPTION}config c ${GITTER_C___RESET}        Print current (effective) configuration"
  echo -e "  ${GITTER_C__OPTION}help     ${GITTER_C___RESET} [${GITTER_C___VALUE}item${GITTER_C___RESET}] Show help"
  echo
  echo -e "${GITTER_C_HEADING}Options:${GITTER_C___RESET}"
  echo -e "  ${GITTER_C__OPTION}--max-depth -d <${GITTER_C___VALUE}depth${GITTER_C___RESET}>${GITTER_C___RESET}   Look for git repositories up to specified depth (default: ${GITTER_C_____ARG}2${GITTER_C___RESET})"
  echo -e "  ${GITTER_C__OPTION}--filter    -f <${GITTER_C___VALUE}pattern${GITTER_C___RESET}>${GITTER_C___RESET} Filter repositories matching the given pattern (can be specified multiple times)"
  echo -e "  ${GITTER_C__OPTION}--exclude   -e          ${GITTER_C___RESET} Exclude matched repositories instead of including"
  echo -e "  ${GITTER_C__OPTION}--verbose   -v          ${GITTER_C___RESET} Enable verbose mode"
  echo -e "  ${GITTER_C__OPTION}--no-color              ${GITTER_C___RESET} Disable colored output"
  echo
  echo -e "${GITTER_C_HEADING}Help items:${GITTER_C___RESET}"
  echo -ne "  ${GITTER_C_COMMAND}gitter${GITTER_C___RESET}"
  echo -ne " ${GITTER_C__OPTION}help${GITTER_C___RESET}"
  echo -ne " [${GITTER_C_____ARG}filter${GITTER_C___RESET}|"
  echo -ne "${GITTER_C_____ARG}gitterignore${GITTER_C___RESET}"
  echo -ne "|${GITTER_C_____ARG}placeholder${GITTER_C___RESET}"
  echo -e "|${GITTER_C_____ARG}status${GITTER_C___RESET}]"
  echo
  echo -e "  ${GITTER_C_____ARG}filter      ${GITTER_C___RESET} Show help about filter patterns"
  echo -e "  ${GITTER_C_____ARG}gitterignore${GITTER_C___RESET} Show help about .gitterignore file"
  echo -e "  ${GITTER_C_____ARG}placeholder ${GITTER_C___RESET} Show help about available placeholders"
  echo -e "  ${GITTER_C_____ARG}status      ${GITTER_C___RESET} Show help about status placeholders"
  echo
  echo -e "${GITTER_C_HEADING}For more information, visit: ${GITTER_C___RESET} ${____GITTER____LINK}"
  echo
}
