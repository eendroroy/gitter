#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

___NO_COMMIT="${GITTER_C____RESET}${GITTER_C____ERROR}no_commit_yet${GITTER_C____RESET}"

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
    echo -ne "${GITTER_C_____PATH}${path%/*}/${GITTER_C____RESET}"
  fi
  echo -ne "${GITTER_C_____REPO}${path##*/}${GITTER_C____RESET}"
}

___git_or_no_commit() { git "$@" 2>/dev/null || echo "${___NO_COMMIT}"; }
___branch()           {                    ___git_or_no_commit branch --show-current;           }
___commit_abbrev()    { local n="${1:-8}"; ___git_or_no_commit log -1 --format="%h" --abbrev="$n"; }
___commit_full()      {                    ___git_or_no_commit log -1 --format="%H";            }
___commit_count()     {                    ___git_or_no_commit rev-list --count HEAD;           }
___time_relative()    {                    ___git_or_no_commit log -1 --format="%cr";           }
___time_date()        {                    ___git_or_no_commit log -1 --format="%cd";           }
___author_email()     {                    ___git_or_no_commit log -1 --format="%ae";           }
___author_name()      {                    ___git_or_no_commit log -1 --format="%an";           }

__repo_status() {
  (
    cd "$1" 2>/dev/null || {
      echo -e "${GITTER_C____ERROR}${GITTER_PRIMARY_SYMBOL}  Failed to enter: ${1}${GITTER_C____RESET}" 1>&2
      exit 1
    }

    echo -ne "$(__print_path "")"
    for pattern in "${PATTERNS[@]}"; do
      # match [commit:[int]] ie [commit:4], [commit:7] etc.
      if [[ "$pattern" =~ \[commit:([0-9]+)\] ]]; then
        abbrev_length="${BASH_REMATCH[1]}"
        echo -ne "${GITTER_C____VALUE}$(___commit_abbrev "${abbrev_length}")${GITTER_C____RESET}"
      else
        case "$pattern" in
          "[branch]"   ) echo -ne "${GITTER_C___BRANCH}$(___branch)${GITTER_C____RESET}"        ;;
          "[commit:a]" ) echo -ne "${GITTER_C___COMMIT}$(___commit_abbrev)${GITTER_C____RESET}" ;;
          "[commit:f]" ) echo -ne "${GITTER_C___COMMIT}$(___commit_full)${GITTER_C____RESET}"   ;;
          "[commit:c]" ) echo -ne "${GITTER_C__COMMITS}$(___commit_count)${GITTER_C____RESET}"  ;;
          "[time:r]"   ) echo -ne "${GITTER_C_TIME_REL}$(___time_relative)${GITTER_C____RESET}" ;;
          "[time:d]"   ) echo -ne "${GITTER_C_TIME_ABS}$(___time_date)${GITTER_C____RESET}"     ;;
          "[author:e]" ) echo -ne "${GITTER_C_AUTHOR_E}$(___author_email)${GITTER_C____RESET}"  ;;
          "[author:n]" ) echo -ne "${GITTER_C_AUTHOR_N}$(___author_name)${GITTER_C____RESET}"   ;;
          *            ) echo -ne "${GITTER_C______DIM}${pattern}${GITTER_C____RESET}"          ;;
        esac
      fi
    done
  )
}
