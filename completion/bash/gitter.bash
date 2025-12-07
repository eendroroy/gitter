#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

_gitter() {
  local cur prev words cword
  _init_completion || {
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    words=("${COMP_WORDS[@]}")
    cword=$COMP_CWORD
  }

  # tokens (left-hand side only)
  local commands=("git" "g" "exec" "x" "list" "ls" "help" "config")
  local options=(--status -s --max-depth -d --filter -f --ask-confirmation -a --continue-on-error -c --quiet -q --no-color --dry-run -n --)
  local statuses=("branch" "updated" "updated-at" "updated-by" "updated-by-at" "commit-count")
  local helps=("filter" "gitterignore" "expander" "status")

  # If previous token expects a pattern (after --status or -s)
  if [[ "${prev}" == "--status" || "${prev}" == "-s" ]]; then
    COMPREPLY=( $(compgen -W "${statuses[*]}" -- "${cur}") )
    return 0
  fi

  # Complete options when starting with '-'
  if [[ "${cur}" == -* ]]; then
    COMPREPLY=( $(compgen -W "${options[*]}" -- "${cur}") )
    return 0
  fi

  # First positional: command
  if [[ ${cword} -eq 1 ]]; then
    COMPREPLY=( $(compgen -W "${commands[*]}" -- "${cur}") )
    return 0
  fi

  # If first arg is 'help', suggest help topics as second arg
  if [[ "${words[1]}" == "help" && ${cword} -eq 2 ]]; then
    COMPREPLY=( $(compgen -W "${helps[*]}" -- "${cur}") )
    return 0
  fi

  return 0
}

# Register completion
complete -F _gitter gitter