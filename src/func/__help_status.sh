#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__help_status() {
  echo
  echo -e "${GITTER_C_HEADING}Gitter${GITTER_C___RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -e "${GITTER_C_HEADING}Available placeholders:${GITTER_C___RESET}"
  echo -e "    ${GITTER_C_____ARG}[branch]${GITTER_C___RESET} Current git branch name"
  echo -e "    ${GITTER_C_____ARG}[commit:a]${GITTER_C___RESET} Abbreviated (8) current git commit hash"
  echo -e "    ${GITTER_C_____ARG}[commit:f]${GITTER_C___RESET} Full current git commit hash"
  echo -e "    ${GITTER_C_____ARG}[time:r]${GITTER_C___RESET} Relative time of the current git commit (e.g., "2 days ago")"
  echo -e "    ${GITTER_C_____ARG}[time:d]${GITTER_C___RESET} Date and time of the current git commit (e.g., "2024-01-01 12:00:00")"
  echo -e "    ${GITTER_C_____ARG}[author:e]${GITTER_C___RESET}Current git commit author email"
  echo -e "    ${GITTER_C_____ARG}[author:n]${GITTER_C___RESET} Current git commit author name"
  echo
}
