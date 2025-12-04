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
[[ -z "${GITTER_SUCCESS_SYMBOL+x}"      ]] && GITTER_SUCCESS_SYMBOL=" ░"
[[ -z "${GITTER___ERROR_SYMBOL+x}"      ]] && GITTER___ERROR_SYMBOL=" ░"
[[ -z "${GITTER_PRIMARY_SYMBOL+x}"      ]] && GITTER_PRIMARY_SYMBOL=" ━"

# Arg defaults
[[ -z "${GITTER_MAX_DEPTH+x}"           ]] && GITTER_MAX_DEPTH=2
[[ -z "${GITTER_FILTERS+x}"             ]] && GITTER_FILTERS=()
[[ -z "${GITTER_FILTER_EXCLUDE+x}"      ]] && GITTER_FILTER_EXCLUDE=false
[[ -z "${GITTER_NO_COLOR+x}"            ]] && GITTER_NO_COLOR=false
[[ -z "${GITTER_QUIET+x}"               ]] && GITTER_QUIET=false
[[ -z "${GITTER_ASK_CONFIRMATION+x}"    ]] && GITTER_ASK_CONFIRMATION=false
[[ -z "${GITTER_CONTINUE_ON_ERROR+x}"   ]] && GITTER_CONTINUE_ON_ERROR=false
[[ -z "${GITTER_REPO_STATUS+x}"         ]] && GITTER_REPO_STATUS="updated-by"

# Color defaults
[[ -z "${GITTER_C__SUCCESS+x}" ]] && GITTER_C__SUCCESS='\e[38;5;2m'
[[ -z "${GITTER_C____ERROR+x}" ]] && GITTER_C____ERROR='\e[38;5;9m'
[[ -z "${GITTER_C_____REPO+x}" ]] && GITTER_C_____REPO='\e[35m'
[[ -z "${GITTER_C_____PATH+x}" ]] && GITTER_C_____PATH='\e[2;35m'
[[ -z "${GITTER_C______DIM+x}" ]] && GITTER_C______DIM='\e[2;38;5;3m'
[[ -z "${GITTER_C__HEADING+x}" ]] && GITTER_C__HEADING='\e[1;37m'
[[ -z "${GITTER_C__COMMAND+x}" ]] && GITTER_C__COMMAND='\e[32m'
[[ -z "${GITTER_C______ARG+x}" ]] && GITTER_C______ARG='\e[33m'
[[ -z "${GITTER_C___OPTION+x}" ]] && GITTER_C___OPTION='\e[36m'
[[ -z "${GITTER_C____VALUE+x}" ]] && GITTER_C____VALUE='\e[2;35;1;3m'
# Status colors
[[ -z "${GITTER_C___BRANCH+x}" ]] && GITTER_C___BRANCH='\e[32m'
[[ -z "${GITTER_C___COMMIT+x}" ]] && GITTER_C___COMMIT='\e[2;35;1;3m'
[[ -z "${GITTER_C__COMMITS+x}" ]] && GITTER_C__COMMITS='\e[2;35;1;3m'
[[ -z "${GITTER_C_TIME_REL+x}" ]] && GITTER_C_TIME_REL='\e[33m'
[[ -z "${GITTER_C_TIME_ABS+x}" ]] && GITTER_C_TIME_ABS='\e[33m'
[[ -z "${GITTER_C_AUTHOR_E+x}" ]] && GITTER_C_AUTHOR_E='\e[36m'
[[ -z "${GITTER_C_AUTHOR_N+x}" ]] && GITTER_C_AUTHOR_N='\e[36m'

# Non configurable variables
GITTER_C____RESET='\e[0m'
GITTER_DRY_RUN=false
OPTION=()
PATTERNS=()
# Predefined status patterns
GITTER_STATUS_BRANCH=" on |[branch]"
GITTER_STATUS_UPDATED=" on |[branch]| |[time:r]"
GITTER_STATUS_UPDATED_AT=" on |[branch]| |[commit:8]| at |[time:d]"
GITTER_STATUS_UPDATED_BY=" on |[branch]| |[commit:8]| by |[author:e]| |[time:r]"
GITTER_STATUS_UPDATED_BY_AT=" on |[branch]| |[commit:8]| by |[author:e]| at |[time:d]"

# Gitter project variables
____GITTER____LINK="https://github.com/eendroroy/gitter"
____GITTER_VERSION="0.0.4"