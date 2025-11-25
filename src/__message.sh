#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__invalid_args_for_command_list() {
  echo
  echo -e "${GITTER_C___ERROR}No arguments provided for command:${GITTER_C___RESET} list" 1>&2
  echo
  echo -e "Run ${GITTER_C_COMMAND}gitter --help${GITTER_C___RESET} for usage information." 1>&2
  echo
  exit 1
}

__no_repository_found() {
  echo -e "${GITTER_C___ERROR}${GITTER___ERROR_SYMBOL}  No git repositories found in the current directory${GITTER_C___RESET}" 1>&2
  exit 1
}

__all_repositories_ignored() {
  echo -e "${GITTER_C___ERROR}${GITTER___ERROR_SYMBOL}  All git repositories are ignored by .gitterignore${GITTER_C___RESET}" 1>&2
  exit 1
}

__all_repositories_filtered_out() {
  echo -e "${GITTER_C___ERROR}${GITTER___ERROR_SYMBOL}${GITTER_C___RESET}  No git repositories found in the current directory with applied filters" 1>&2
  exit 1
}

__unknown_arg() {
  echo
  echo -e "${GITTER_C___ERROR}Unknown argument:${GITTER_C___RESET} $1" 1>&2
  echo
  echo -e "Run ${GITTER_C_COMMAND}gitter --help${GITTER_C___RESET} for usage information." 1>&2
  echo
  exit 1
}

__unknown_option() {
  echo
  echo -e "${GITTER_C___ERROR}Unknown option:${GITTER_C___RESET} $1" 1>&2
  echo
  echo -e "Run ${GITTER_C_COMMAND}gitter --help${GITTER_C___RESET} for usage information." 1>&2
  echo
  exit 1
}
