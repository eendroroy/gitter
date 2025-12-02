#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

___NO_COMMIT="${GITTER_C___RESET}${GITTER_C___ERROR}no_commit_yet${GITTER_C___RESET}"

__print_path() {
  local path
  if [[ -z ${1} ]]; then
    path=${PWD/"${____CURRENT_DIR}"/.}
  else
    path=${1/"${____CURRENT_DIR}"/.}
  fi

  if [[ "$path" == "." ]]; then
    path="$(basename "${____CURRENT_DIR}")"
  else
    echo -ne "${GITTER_C_PATH_DM}${path%/*}/${GITTER_C___RESET}"
  fi
  echo -ne "${GITTER_C____PATH}${path##*/}${GITTER_C___RESET}"
}

___git_or_no_commit() { git "$@" 2>/dev/null || echo "${___NO_COMMIT}"; }
___branch()           { ___git_or_no_commit branch --show-current;           }
___commit_abbrev()    { ___git_or_no_commit log -1 --format="%h" --abbrev=8; }
___commit_full()      { ___git_or_no_commit log -1 --format="%H";            }
___commit_count()     { ___git_or_no_commit rev-list --count HEAD;           }
___time_relative()    { ___git_or_no_commit log -1 --format="%cr";           }
___time_date()        { ___git_or_no_commit log -1 --format="%cd";           }
___author_email()     { ___git_or_no_commit log -1 --format="%ae";           }
___author_name()      { ___git_or_no_commit log -1 --format="%an";           }

__repo_status() {
  if [[ "$GITTER_VERBOSE" == true ]]; then
    local -a PATTERNS=("${GITTER_REPO_STATUS_VERBOSE[@]}")
  else
    local -a PATTERNS=("${GITTER_REPO_STATUS[@]}")
  fi
  (
    cd "$1" 2>/dev/null || {
      echo -e "${GITTER_C___ERROR}${GITTER_PRIMARY_SYMBOL}  Failed to enter: ${1}${GITTER_C___RESET}" 1>&2
      exit 1
    }

    echo -ne "$(__print_path "")"
    for pattern in "${PATTERNS[@]}"; do
      case "$pattern" in
        "[branch]"   ) echo -ne "${GITTER_C_COMMAND}$(___branch)${GITTER_C___RESET}"        ;;
        "[commit:a]" ) echo -ne "${GITTER_C___VALUE}$(___commit_abbrev)${GITTER_C___RESET}" ;;
        "[commit:f]" ) echo -ne "${GITTER_C___VALUE}$(___commit_full)${GITTER_C___RESET}"   ;;
        "[commit:c]" ) echo -ne "${GITTER_C___VALUE}$(___commit_count)${GITTER_C___RESET}"  ;;
        "[time:r]"   ) echo -ne "${GITTER_C_____ARG}$(___time_relative)${GITTER_C___RESET}" ;;
        "[time:d]"   ) echo -ne "${GITTER_C_____ARG}$(___time_date)${GITTER_C___RESET}"     ;;
        "[author:e]" ) echo -ne "${GITTER_C__OPTION}$(___author_email)${GITTER_C___RESET}"  ;;
        "[author:n]" ) echo -ne "${GITTER_C__OPTION}$(___author_name)${GITTER_C___RESET}"   ;;
        *            ) echo -ne "${GITTER_C_____DIM}${pattern}${GITTER_C___RESET}"          ;;
      esac
    done
  )
}
