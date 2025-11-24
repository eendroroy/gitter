#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__print_path() {
  local path
  if [[ -z ${1} ]]; then
    path=${PWD/"${____CURRENT_DIR}"/.}
  else
    path=${1/"${____CURRENT_DIR}"/.}
  fi

  if [[ "$path" == "." ]]; then
    path="$(basename "${____CURRENT_DIR}")"
  else
    echo -ne "${GITTER_C_PATH_DM}${path%/*}/${GITTER_C___RESET}"
  fi
  echo -ne "${GITTER_C____PATH}${path##*/}${GITTER_C___RESET}"
}
