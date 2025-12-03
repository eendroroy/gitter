#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__invalid_args_for_command() {
  echo
  echo -e "${GITTER_C____ERROR}No arguments provided for command:${GITTER_C____RESET} ${GITTER_C__COMMAND}${1}${GITTER_C____RESET}" 1>&2
  echo
  echo -e "Run ${GITTER_C__COMMAND}gitter${GITTER_C____RESET} ${GITTER_C______ARG}help${GITTER_C____RESET} for usage information." 1>&2
  echo
  exit 1
}

__no_repository_found() {
  echo -e "${GITTER_C____ERROR}${GITTER___ERROR_SYMBOL}  No git repositories found in the current directory${GITTER_C____RESET}" 1>&2
  exit 1
}

__all_repositories_ignored() {
  echo -e "${GITTER_C____ERROR}${GITTER___ERROR_SYMBOL}  All git repositories are ignored by .gitterignore${GITTER_C____RESET}" 1>&2
  exit 1
}

__all_repositories_filtered_out() {
  echo -e "${GITTER_C____ERROR}${GITTER___ERROR_SYMBOL}${GITTER_C____RESET}  No git repositories found in the current directory with applied filters" 1>&2
  exit 1
}

__unknown_arg() {
  echo
  echo -e "${GITTER_C____ERROR}Unknown argument:${GITTER_C____RESET} $1" 1>&2
  echo
  echo -e "Run ${GITTER_C__COMMAND}gitter${GITTER_C____RESET} ${GITTER_C______ARG}help${GITTER_C____RESET} for usage information." 1>&2
  echo
  exit 1
}

__too_many_args() {
  echo
  echo -ne "${GITTER_C____ERROR}Too many arguments for:${GITTER_C____RESET} ${GITTER_C___OPTION}${1}${GITTER_C____RESET}" 1>&2
  echo -e " ${GITTER_C____ERROR}(expected ${2} argument(s) but got ${3})${GITTER_C____RESET}" 1>&2
  echo
  echo -e "Run ${GITTER_C__COMMAND}gitter${GITTER_C____RESET} ${GITTER_C______ARG}help${GITTER_C____RESET} for usage information." 1>&2
  echo
  exit 1
}

__unknown_option() {
  echo
  echo -e "${GITTER_C____ERROR}Unknown option:${GITTER_C____RESET} $1" 1>&2
  echo
  echo -e "Run ${GITTER_C__COMMAND}gitter${GITTER_C____RESET} ${GITTER_C______ARG}help${GITTER_C____RESET} for usage information." 1>&2
  echo
  exit 1
}
