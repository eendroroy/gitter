#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__handle_stderr() {
  local prefix="$1"
  while IFS= read -r line || [ -n "$line" ]; do
    if [[ $GREPABLE == true ]]; then
      printf '%s::ERR::%s\n' "$prefix" "${line}" 1>&2
    else
      printf '%b\n' "${GITTER_C____ERROR}${GITTER___ERROR_SYMBOL}${GITTER_C____RESET}  ${line}" 1>&2
    fi
  done
}

__handle_stdout() {
  local prefix="$1"
  while IFS= read -r line || [ -n "$line" ]; do
    if [[ $GREPABLE == true ]]; then
      printf '%s::OUT::%s\n' "$prefix" "${line}" 1>&2
    else
      printf '%b\n' "${GITTER_C__SUCCESS}${GITTER_SUCCESS_SYMBOL}${GITTER_C____RESET}  ${line}"
    fi
  done
}