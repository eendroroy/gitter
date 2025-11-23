#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

____CURRENT_DIR=$(pwd)
_SUCCESS_SYMBOL=" ░"
___ERROR_SYMBOL=" ░"
_PRIMARY_SYMBOL=" ━"

_C___RESET='\e[0m'
_C____PATH='\e[35m'
_C_PATH_DM='\e[2;35m'
_C_COMMAND='\e[32m'
_C____ARGS='\e[33m'
_C__OPTION='\e[36m'
_C_____DIM='\e[2;38;5;3m'
_C___VALUE='\e[2;35;1;3m'
_C_SUCCESS='\e[38;5;2m'
_C___ERROR='\e[38;5;9m'
_C_HEADING='\e[1;37m'

# Argument defaults
filters=()
exclude=false
command=""
verbose=false
branch=false
args=()
