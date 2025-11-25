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
# Commands
___git()    { __parse_command "git" ; }
___exec()   { __parse_command "exec"; }
___list()   { __parse_command "list"; }
___help()   { __parse_command "help"; }
___config() { __parse_command "config"; }

# Command aliases
___ll()   { __parse_command "list"; GITTER_VERBOSE=true; }
