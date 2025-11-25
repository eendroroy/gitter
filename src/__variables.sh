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

____CURRENT_DIR=$(pwd)

# Default variables
[[ -z "${GITTER_MAX_DEPTH+x}"      ]] && GITTER_MAX_DEPTH=2
[[ -z "${GITTER_SUCCESS_SYMBOL+x}" ]] && GITTER_SUCCESS_SYMBOL=" ░"
[[ -z "${GITTER___ERROR_SYMBOL+x}" ]] && GITTER___ERROR_SYMBOL=" ░"
[[ -z "${GITTER_PRIMARY_SYMBOL+x}" ]] && GITTER_PRIMARY_SYMBOL=" ━"

# Arg defaults
[[ -z "${GITTER_FILTERS+x}"        ]] && GITTER_FILTERS=()
[[ -z "${GITTER_VERBOSE+x}"        ]] && GITTER_VERBOSE=false
[[ -z "${GITTER_FILTER_EXCLUDE+x}" ]] && GITTER_FILTER_EXCLUDE=false
[[ -z "${GITTER_NO_COLOR+x}"       ]] && GITTER_NO_COLOR=false

if [[ -z "${GITTER_REPO_STATUS+x}" ]]; then
  GITTER_REPO_STATUS=(" on " "[branch]")
fi

if [[ -z "${GITTER_REPO_STATUS_VERBOSE+x}" ]]; then
  GITTER_REPO_STATUS_VERBOSE=(" on " "[branch]" " " "[commit:a]" " by " "[author:e]" " " "[time:r]")
fi

# Color defaults
[[ -z "${GITTER_C____PATH+x}" ]] && GITTER_C____PATH='\e[35m'
[[ -z "${GITTER_C_PATH_DM+x}" ]] && GITTER_C_PATH_DM='\e[2;35m'
[[ -z "${GITTER_C_COMMAND+x}" ]] && GITTER_C_COMMAND='\e[32m'
[[ -z "${GITTER_C____ARGS+x}" ]] && GITTER_C____ARGS='\e[33m'
[[ -z "${GITTER_C__OPTION+x}" ]] && GITTER_C__OPTION='\e[36m'
[[ -z "${GITTER_C_____DIM+x}" ]] && GITTER_C_____DIM='\e[2;38;5;3m'
[[ -z "${GITTER_C___VALUE+x}" ]] && GITTER_C___VALUE='\e[2;35;1;3m'
[[ -z "${GITTER_C_SUCCESS+x}" ]] && GITTER_C_SUCCESS='\e[38;5;2m'
[[ -z "${GITTER_C___ERROR+x}" ]] && GITTER_C___ERROR='\e[38;5;9m'
[[ -z "${GITTER_C_HEADING+x}" ]] && GITTER_C_HEADING='\e[1;37m'
GITTER_C___RESET='\e[0m'
