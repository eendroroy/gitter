#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__read_filter() {
  if [[ -z "$1" || "$1" == -* ]]; then
    echo
    echo -e "${_C___ERROR}Missing or invalid argument for:${_C___RESET} ${_C__OPTION}--filter${_C___RESET}" 1>&2
    echo
    echo -e "Run ${_C_COMMAND}gitter --help${_C___RESET} for usage information." 1>&2
    echo
    exit 1
  fi
  filters+=("$1")
}
