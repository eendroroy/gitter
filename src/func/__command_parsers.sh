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

__parse_command() {
  if [[ -n "$command" ]]; then
    echo
    echo -e "${GITTER_C____ERROR}Multiple command types specified${GITTER_C____RESET}" 1>&2
    echo
    echo -e "Run ${GITTER_C__COMMAND}gitter${GITTER_C____RESET} ${GITTER_C______ARG}help${GITTER_C____RESET} for usage information." 1>&2
    echo
    exit 1
  fi
  command="${1}"
}

__read_filter() {
  if [[ -z "$1" || "$1" == -* ]]; then
    echo
    echo -e "${GITTER_C____ERROR}Missing or invalid argument for:${GITTER_C____RESET} ${GITTER_C___OPTION}--filter${GITTER_C____RESET}" 1>&2
    echo
    echo -e "Run ${GITTER_C__COMMAND}gitter${GITTER_C____RESET} ${GITTER_C______ARG}help${GITTER_C____RESET} for usage information." 1>&2
    echo
    exit 1
  fi
  GITTER_FILTERS+=("$1")
}

__read_command_args() {
  shift
  while [[ $# -gt 0 ]]; do
    args+=("$1")
    shift
  done
}

__read_max_depth() {
  if [[ -z "$1" || "$1" == -* ]]; then
    echo
    echo -e "${GITTER_C____ERROR}Missing or invalid argument for:${GITTER_C____RESET} ${GITTER_C___OPTION}--max-depth${GITTER_C____RESET}" 1>&2
    echo
    echo -e "Run ${GITTER_C__COMMAND}gitter${GITTER_C____RESET} ${GITTER_C______ARG}help${GITTER_C____RESET} for usage information." 1>&2
    echo
    exit 1
  fi
  GITTER_MAX_DEPTH="$1"
}

__read_status() {
  if [[ -z "$1" || "$1" == -* ]]; then
    echo
    echo -e "${GITTER_C____ERROR}Missing or invalid argument for:${GITTER_C____RESET} ${GITTER_C___OPTION}--status${GITTER_C____RESET}" 1>&2
    echo
    echo -e "Run ${GITTER_C__COMMAND}gitter${GITTER_C____RESET} ${GITTER_C______ARG}help${GITTER_C____RESET} for usage information." 1>&2
    echo
    exit 1
  fi
  status="$1"
}

__expand_status() {
  [[ -z "${status+x}" ]] && status="${GITTER_REPO_STATUS}"

  case "${status}" in
    "branch"        ) status="${GITTER_STATUS_BRANCH}"        ;;
    "updated"       ) status="${GITTER_STATUS_UPDATED}"       ;;
    "updated-at"    ) status="${GITTER_STATUS_UPDATED_AT}"    ;;
    "updated-by"    ) status="${GITTER_STATUS_UPDATED_BY}"    ;;
    "updated-by-at" ) status="${GITTER_STATUS_UPDATED_BY_AT}" ;;
    "commit-count"  ) status="${GITTER_STATUS_COMMIT_COUNT}"  ;;
    *               )                                         ;;
  esac

  IFS='|' read -r -a PATTERNS <<< "${status}"
}

__track_options() {
  [[ "$1" != "--filter" && "$1" != "-f" ]] && ___already_tracked_option "$1" && {
    echo -e "${GITTER_C____ERROR}Duplicate option specified:${GITTER_C____RESET} ${GITTER_C___OPTION}$1${GITTER_C____RESET}" 1>&2
    echo
    echo -e "Run ${GITTER_C__COMMAND}gitter${GITTER_C____RESET} ${GITTER_C______ARG}help${GITTER_C____RESET} for usage information." 1>&2
    echo
    exit 1
  }

  ___already_tracked_option "$1" || OPTION=("${OPTION[@]}" "${1}")
}

___expand_options() {
  case "$1" in
    -s ) echo "--status"            ;;
    -d ) echo "--max-depth"         ;;
    -f ) echo "--filter"            ;;
    -e ) echo "--exclude"           ;;
    -a ) echo "--ask-confirmation"  ;;
    -c ) echo "--continue-on-error" ;;
    -q ) echo "--quiet"             ;;
    -n ) echo "--dry-run"           ;;
     * ) echo "$1"                  ;;
  esac
}

___already_tracked_option() {
  local opt
  for opt in "${OPTION[@]}"; do
    if [[ "$(___expand_options "$opt")" == "$(___expand_options "$1")" ]]; then
      return 0
    fi
  done
  return 1
}

__disable_color_output() {
  GITTER_C__SUCCESS=''
  GITTER_C____ERROR=''
  GITTER_C_____REPO=''
  GITTER_C_____PATH=''
  GITTER_C______DIM=''
  GITTER_C__HEADING=''
  GITTER_C__COMMAND=''
  GITTER_C______ARG=''
  GITTER_C___OPTION=''
  GITTER_C____VALUE=''
  GITTER_C___BRANCH=''
  GITTER_C___COMMIT=''
  GITTER_C__COMMITS=''
  GITTER_C_TIME_REL=''
  GITTER_C_TIME_ABS=''
  GITTER_C_AUTHOR_E=''
  GITTER_C_AUTHOR_N=''
}

# Commands
___git()     { __parse_command "git"    ; }
___exec()    { __parse_command "exec"   ; }
___eval()    { __parse_command "eval"   ; }
___list()    { __parse_command "list"   ; }
___config()  { __parse_command "config" ; }
___version() { __parse_command "version"; }
___help()    {
  shift
  if [[ $# -eq 0 ]]; then
    __parse_command "help"
    return
  elif [[ $# -eq 1 ]]; then
    case "$1" in
      filter      ) __parse_command "help-filter"       ;;
      status      ) __parse_command "help-status"       ;;
      gitterignore) __parse_command "help-gitterignore" ;;
      expander    ) __parse_command "help-expander"     ;;
      *           ) __unknown_arg "$1" ;;
    esac
  else
  __too_many_args "help" "1" "$#"
  fi
}
