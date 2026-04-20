# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

# Elvish completion for gitter
# Source this file from your ~/.config/elvish/rc.elv:
#   use ~/path/to/.gitter/completion/elvish/gitter.elv

var status-values = [
  default
  branch
  updated
  updated-at
  updated-by
  updated-by-at
  commit-count
]

var help-topics = [filter gitterignore expander status]

var commands = [
  git g
  exec x
  eval e
  bash b
  list ls
  help
  config
  version v
]

set edit:completion:arg-completer[gitter] = {|@args|
  var n = (count $args)
  var prev = $args[(- $n 2)]
  var cur  = $args[(- $n 1)]

  # After --status / -s → offer predefined status names
  if (or (==s $prev --status) (==s $prev -s)) {
    each {|s| edit:complex-candidate $s } $status-values
    return
  }

  # After --max-depth / -d → nothing useful to complete
  if (or (==s $prev --max-depth) (==s $prev -d)) {
    return
  }

  # After --filter / -f → hint text
  if (or (==s $prev --filter) (==s $prev -f)) {
    edit:complex-candidate 'repo:+name+' &display='filter example: repo name substring'
    edit:complex-candidate 'branch:main'  &display='filter example: exact branch name'
    edit:complex-candidate 'dirty'        &display='filter example: dirty repositories'
    edit:complex-candidate 'stale:7d'     &display='filter example: stale for 7 days'
    return
  }

  # Options (start with -)
  if (has-prefix $cur -) {
    each {|o| edit:complex-candidate $o } [
      --status -s
      --max-depth -d
      --filter -f
      --ask-confirmation -a
      --continue-on-error -c
      --no-color
      --dry-run -n
      --
    ]
    return
  }

  # First positional arg → subcommand
  if (== $n 2) {
    each {|c| edit:complex-candidate $c } $commands
    return
  }

  # Second positional arg after 'help' → help topics
  if (and (== $n 3) (or (==s $args[1] help))) {
    each {|t| edit:complex-candidate $t } $help-topics
    return
  }
}

