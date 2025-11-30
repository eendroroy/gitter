#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

declare -A __COMMAND_ARG_MAP

             __COMMAND_ARG_MAP["list"]="--max-depth -d --exclude -e --filter -f                                                         --no-color --verbose -v             "
              __COMMAND_ARG_MAP["git"]="--max-depth -d --exclude -e --filter -f --ask-confirmation -a --continue-on-error -c --quiet -q --no-color --verbose -v --dry-run -n"
             __COMMAND_ARG_MAP["exec"]="--max-depth -d --exclude -e --filter -f --ask-confirmation -a --continue-on-error -c --quiet -q --no-color --verbose -v --dry-run -n"
             __COMMAND_ARG_MAP["eval"]="--max-depth -d --exclude -e --filter -f --ask-confirmation -a --continue-on-error -c --quiet -q --no-color --verbose -v --dry-run -n"
           __COMMAND_ARG_MAP["config"]="                                                                                                --no-color                          "
          __COMMAND_ARG_MAP["version"]="                                                                                                --no-color                          "
             __COMMAND_ARG_MAP["help"]="                                                                                                --no-color                          "
      __COMMAND_ARG_MAP["help-filter"]="                                                                                                --no-color                          "
__COMMAND_ARG_MAP["help-gitterignore"]="                                                                                                --no-color                          "
 __COMMAND_ARG_MAP["help-placeholder"]="                                                                                                --no-color                          "
      __COMMAND_ARG_MAP["help-status"]="                                                                                                --no-color                          "

__print_command_error() {
  local option="$1"
  local command="$2"
  echo -e " ${GITTER_C___ERROR}Error: option (${GITTER_C___RESET}${GITTER_C__OPTION}${option}${GITTER_C___RESET}${GITTER_C___ERROR}) is not applicable for [${GITTER_C_COMMAND}${command}${GITTER_C___ERROR}]" 1>&2
}

# shellcheck disable=SC2154
__validate_command() {
  local command="$1"
  local -a invalid_opts=()

  read -r -a allowed_options <<< "${__COMMAND_ARG_MAP["$command"]}"

  for opt in "${opts[@]}"; do
    local valid_option=false

    for allowed_opt in "${allowed_options[@]}"; do
      if [[ "$opt" == "$allowed_opt" ]]; then
        valid_option=true
        break
      fi
    done

    if [[ "$valid_option" == false ]]; then
      invalid_opts=("${invalid_opts[@]}" "$opt")
    fi
  done

  [[ "${#invalid_opts[@]}" -gt 0 ]] && {
    for opt in "${invalid_opts[@]}"; do
      __print_command_error "$opt" "${command}"
    done

    exit 1
  }
}
