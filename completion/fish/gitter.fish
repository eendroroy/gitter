# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

# fish completion for gitter
# Source this file from your ~/.config/fish/config.fish:
#   source ~/path/to/.gitter/completion/fish/gitter.fish

set -l gitter_status_fields 'default branch updated updated-at updated-by updated-by-at commit-count'
set -l gitter_commands      'git g exec x eval e bash b list ls help config version v'
set -l gitter_help_topics   'filter gitterignore expander status'
set -l gitter_filter_hints  'repo:+name+' 'branch:main' 'path:src+' 'dirty' 'stale:7d' 'active:1d'

# Subcommands (only when no subcommand has been given yet)
complete -c gitter -f -n 'not __fish_seen_subcommand_from $gitter_commands' -a $gitter_commands -d 'gitter subcommand'

# Global options
complete -c gitter -l max-depth         -s d -r -d 'Maximum directory depth (default: 2)'
complete -c gitter -l filter            -s f -r -d 'Filter repositories (see gitter help filter)' -a $gitter_filter_hints
complete -c gitter -l status            -s s -r -d 'Repository status format'                     -a $gitter_status_fields
complete -c gitter -l ask-confirmation  -s a    -d 'Ask for confirmation before executing'
complete -c gitter -l continue-on-error -s c    -d 'Continue on error'
complete -c gitter -l no-color                  -d 'Disable colored output'
complete -c gitter -l dry-run           -s n    -d 'Dry run (show what would be done)'
complete -c gitter -f                           -d 'End of options'                               -a '--'

# Help topics when first argument is `help`
complete -c gitter -n '__fish_seen_subcommand_from help' -f -a $gitter_help_topics -d 'Help topic'
