#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__help_gitterignore() {
  echo
  echo -e "${GITTER_C_HEADING}Gitter${GITTER_C___RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -e "${GITTER_C_HEADING}Ignore-file:${GITTER_C___RESET}"
  echo -e "  Gitter will look for a ${GITTER_C____PATH}.gitterignore${GITTER_C___RESET} file ${GITTER_C_____ARG}in the current directory.${GITTER_C___RESET}"
  echo -e "  If found, it will read patterns from the file to ignore matching repositories."
  echo -e "  Each line in the file should contain a pattern to match repository names or paths."
  echo -e "  Lines starting with ${GITTER_C___ERROR}#${GITTER_C___RESET} are treated as comments and ignored."
  echo -e "  Patterns:"
  echo -e "    ${GITTER_C___ERROR}relative/path/to/directory${GITTER_C___RESET} Ignore directory at exact relative path ${GITTER_C____PATH}relative/path/to/directory${GITTER_C___RESET}"
  echo -e "    ${GITTER_C___ERROR}*/directory_name${GITTER_C___RESET}           Ignore directories under any parent directory named ${GITTER_C____PATH}directory_name${GITTER_C___RESET}"
  echo -e "    ${GITTER_C___ERROR}directory_name/*${GITTER_C___RESET}           Ignore directories directly under the top-level directory named ${GITTER_C____PATH}directory_name${GITTER_C___RESET}"
  echo
}
