#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__match_filter() {
  local value="$1" pattern="$2"

  # Special-case: single '+' matches everything
  [[ "$pattern" == "+" ]] && return 0

  local has_leading has_trailing
  if [[ "$pattern" == \+* ]]; then
    has_leading=1
    pattern="${pattern#\+}"
  fi
  if [[ "$pattern" == *\+ ]]; then
    has_trailing=1
    pattern="${pattern%\+}"
  fi

  [[ -z "$pattern" ]] && return 0

  if [[ -n "$has_leading" && -n "$has_trailing" ]]; then
    [[ "$value" == *"$pattern"* ]]
  elif [[ -n "$has_leading" ]]; then
    [[ "$value" == *"$pattern" ]]
  elif [[ -n "$has_trailing" ]]; then
    [[ "$value" == "$pattern"* ]]
  else
    [[ "$value" == "$pattern" ]]
  fi
}
