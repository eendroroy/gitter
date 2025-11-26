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
___git()     { __parse_command "git" ; }
___exec()    { __parse_command "exec"; }
___eval()    { __parse_command "eval"; }
___list()    { __parse_command "list"; }
___config()  { __parse_command "config"; }
___version() { __parse_command "version"; }
___help()    {
  shift
  if [[ $# -eq 0 ]]; then
    __parse_command "help"
    return
  else
    while [[ $# -gt 0 ]]; do
      case "$1" in
        filter      ) __parse_command "help-filter" ;;
        status      ) __parse_command "help-status" ;;
        gitterignore) __parse_command "help-gitterignore" ;;
        placeholder ) __parse_command "help-placeholder" ;;
        *           ) __unknown_arg "$1" ;;
      esac
      shift
    done
  fi
}

# Command aliases
___ll()      { __parse_command "list"; GITTER_VERBOSE=true; }
