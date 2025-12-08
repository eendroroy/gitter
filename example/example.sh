#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

declare -A branches
branches=(
  ["10"]="master"
  ["11"]="develop"
  ["12"]="feature/x"
  ["13"]="release"
  ["14"]="hotfix"
  ["15"]="staging"
  ["16"]="feature/y"
  ["17"]="feature/z"
  ["18"]="bugfix"
  ["19"]="production"
)

for i in "${!branches[@]}"; do
  REPO_DIR="repositories/repo_$i"
  BRANCH_NAME="${branches[$i]}"
  FILE_NAME="file_repositories_repo_$i.txt"
  [[ -d "$REPO_DIR" ]] && continue
  mkdir -p "$REPO_DIR"
  pushd "$REPO_DIR" > /dev/null || exit 1
  git init >/dev/null 2>&1
  echo "Initial commit in $REPO_DIR" > "${FILE_NAME}"
  git add "${FILE_NAME}"
  git commit -m "Initial commit" >/dev/null 2>&1
  git checkout -b "$BRANCH_NAME" >/dev/null 2>&1
  for j in {1..5}; do
    echo "Commit $j in $REPO_DIR" >> "${FILE_NAME}"
    git add "${FILE_NAME}"
    git commit -m "Commit $j" >/dev/null 2>&1
  done
  popd > /dev/null || exit 1
done

__show_and_run() {
  echo -e "\n${GITTER_C__COMMAND}\$ ${*}${GITTER_C____RESET}\n"
  read -n 1 -s -r -p "Press any key to run the next command..."
  printf '\r\033[2K'
  eval "${*}"
}

# gitter command examples
__show_and_run gitter                                 help
__show_and_run gitter                                 help filter
__show_and_run gitter                                 help status
__show_and_run gitter --no-color                      help
__show_and_run gitter --no-color                      help expander
__show_and_run gitter --no-color                      help gitterignore
__show_and_run gitter                                 list
__show_and_run gitter --status '" "'                  list
__show_and_run gitter --no-color                      list
__show_and_run gitter --processable                   list
__show_and_run gitter --status branch                 list
__show_and_run gitter --status commit-count           list
__show_and_run gitter --status updated                list
__show_and_run gitter --status updated-at             list
__show_and_run gitter --status updated-by             list
__show_and_run gitter --status updated-by-at          list
__show_and_run gitter --filter '"repo:+1+"'           list
__show_and_run gitter --filter '"repo:+1"'            list
__show_and_run gitter --filter '"repo:+1 || repo:+5"' list
__show_and_run gitter --filter '"branch:feature/+"'   list
__show_and_run gitter --filter '"branch:+fix"'        list
__show_and_run gitter --filter '"! branch:feature/+"' list
__show_and_run gitter                                 config
__show_and_run gitter --dry-run                       git  -- branch
__show_and_run gitter --dry-run                       exec -- git branch
__show_and_run gitter                                 git  -- branch
__show_and_run gitter                                 exec -- git branch
__show_and_run gitter --processable                        -- branch
__show_and_run gitter --continue-on-error             eval -- '"git branch | grep feature"'
