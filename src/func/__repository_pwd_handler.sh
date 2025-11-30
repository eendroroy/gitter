#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__enter_repo_dir() {
  local dir="$1"
  pushd "$dir" >/dev/null || {
    echo -e "${GITTER_C___ERROR}${GITTER_PRIMARY_SYMBOL}  Failed to enter: ${GITTER_C___RESET} $(__print_path "$dir")" 1>&2
    exit 1
  }
}

__exit_repo_dir() {
  popd >/dev/null || {
    echo -e "${GITTER_C___ERROR}${GITTER_PRIMARY_SYMBOL}  Failed to exit repository directory${GITTER_C___RESET}" 1>&2
    exit 1
  }
}