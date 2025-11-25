#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

# shellcheck disable=SC2034
__read_max_depth() {
  if [[ -z "$1" || "$1" == -* ]]; then
    echo
    echo -e "${GITTER_C___ERROR}Missing or invalid argument for:${GITTER_C___RESET} ${GITTER_C__OPTION}--max-depth${GITTER_C___RESET}" 1>&2
    echo
    echo -e "Run ${GITTER_C_COMMAND}gitter --help${GITTER_C___RESET} for usage information." 1>&2
    echo
    exit 1
  fi
  GITTER_MAX_DEPTH="$1"
}
