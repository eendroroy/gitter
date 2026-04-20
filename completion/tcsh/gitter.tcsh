#!/usr/bin/env tcsh

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

# tcsh completion for gitter
# Add the following to your ~/.tcshrc:
#   source ~/path/to/.gitter/completion/tcsh/gitter.tcsh

set _gitter_commands  = (git g exec x eval e bash b list ls help config version v)
set _gitter_options   = (--status -s --max-depth -d --filter -f --ask-confirmation -a --continue-on-error -c --no-color --dry-run -n --)
set _gitter_statuses  = (default branch updated updated-at updated-by updated-by-at commit-count)
set _gitter_helps     = (filter gitterignore expander status)

complete gitter \
  'p/1/($__gitter_commands)/' \
  'n/--status/($__gitter_statuses)/' \
  'n/-s/($__gitter_statuses)/' \
  'n/--max-depth/()/' \
  'n/-d/()/' \
  'n/--filter/()/' \
  'n/-f/()/'

