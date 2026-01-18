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

             __COMMAND_ARG_MAP["list"]="--no-color --status -s --max-depth -d --filter -f                                                          "
              __COMMAND_ARG_MAP["git"]="--no-color --status -s --max-depth -d --filter -f --ask-confirmation -a --continue-on-error -c --dry-run -n"
             __COMMAND_ARG_MAP["exec"]="--no-color --status -s --max-depth -d --filter -f --ask-confirmation -a --continue-on-error -c --dry-run -n"
             __COMMAND_ARG_MAP["eval"]="--no-color --status -s --max-depth -d --filter -f --ask-confirmation -a --continue-on-error -c --dry-run -n"
             __COMMAND_ARG_MAP["bash"]="           --status -s --max-depth -d --filter -f --ask-confirmation -a --continue-on-error -c --dry-run -n"
          __COMMAND_ARG_MAP["version"]="--no-color                                                                                                 "
             __COMMAND_ARG_MAP["help"]="--no-color                                                                                                 "
      __COMMAND_ARG_MAP["help-filter"]="--no-color                                                                                                 "
__COMMAND_ARG_MAP["help-gitterignore"]="--no-color                                                                                                 "
    __COMMAND_ARG_MAP["help-expander"]="--no-color                                                                                                 "
      __COMMAND_ARG_MAP["help-status"]="--no-color                                                                                                 "
           __COMMAND_ARG_MAP["config"]="                                                                                                           "

__print_command_error() {
  local option="$1"
  local command="$2"
  echo -e " ${GITTER_C____ERROR}Error: option (${GITTER_C____RESET}${GITTER_C___OPTION}${option}${GITTER_C____RESET}${GITTER_C____ERROR}) is not applicable for [${GITTER_C__COMMAND}${command}${GITTER_C____ERROR}]" 1>&2
}

# shellcheck disable=SC2154
__validate_command() {
  local command="$1"
  local -n arguments=${2}

  case "$command" in
    git|exec|eval)
      if [[ "${#arguments[@]}" -lt 1 ]]; then
        __invalid_args_for_command "$command" "at least 1" "${#arguments[@]}"
      fi
      ;;
    bash)
      if [[ "${#arguments[@]}" -ne 1 ]]; then
        __invalid_args_for_command "$command" "exactly 1" "${#arguments[@]}"
      fi
      ;;
    list|config|version)
      if [[ "${#arguments[@]}" -ne 0 ]]; then
        __invalid_args_for_command "$command" "no" "${#arguments[@]}"
      fi
      ;;
    *)
      ;;
  esac

  local -a invalid_opts=()

  read -r -a allowed_options <<< "${__COMMAND_ARG_MAP["$command"]}"

  for opt in "${OPTION[@]}"; do
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
