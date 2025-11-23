#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__help() {
  echo
  echo -e "${_C_HEADING}Gitter${_C___RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -e "${_C_HEADING}Usage:${_C___RESET}"
  echo -ne "  ${_C_COMMAND}gitter${_C___RESET} [${_C__OPTION}--exclude${_C___RESET}] [${_C__OPTION}--filter <${_C___VALUE}pattern${_C___RESET}${_C__OPTION}>${_C___RESET} ...] [${_C__OPTION}--<option>${_C___RESET} ...]"
  echo -ne " [${_C__OPTION}git${_C___RESET}|${_C__OPTION}exec${_C___RESET}|${_C__OPTION}list${_C___RESET}|${_C__OPTION}help${_C___RESET}]"
  echo -e " [${_C__OPTION}--${_C___RESET} <${_C____ARGS}args ...${_C___RESET}>]"
  echo
  echo -e "${_C_HEADING}Commands:${_C___RESET}"
  echo -e "  ${_C__OPTION}git   g      ${_C___RESET} Run a git command (${_C____ARGS}default${_C___RESET})"
  echo -e "  ${_C__OPTION}exec  x      ${_C___RESET} Run an arbitrary command"
  echo -e "  ${_C__OPTION}list  ls     ${_C___RESET} List repositories only"
  echo -e "  ${_C__OPTION}      lb     ${_C___RESET} List repositories with branch name"
  echo -e "  ${_C__OPTION}      ll     ${_C___RESET} Equivalent to ${_C__OPTION}list --verbose${_C___RESET} command"
  echo -e "  ${_C__OPTION}help         ${_C___RESET} Show this help menu"
  echo
  echo -e "${_C_HEADING}Options:${_C___RESET}"
  echo -e "  ${_C__OPTION}--filter   -f <${_C___VALUE}pattern${_C___RESET}> ${_C___RESET} Match repo directory name exactly"
  echo -e "  ${_C__OPTION}--exclude  -e           ${_C___RESET} Exclude matched repositories instead of including"
  echo -e "  ${_C__OPTION}--verbose  -v           ${_C___RESET} Enable verbose mode"
  echo -e "  ${_C__OPTION}--no-color              ${_C___RESET} Disable colored output"
  echo
  echo -e "${_C_HEADING}Filers:${_C___RESET}"
  echo -ne "  ${_C_____DIM}<${_C___RESET}${_C___ERROR}prefix${_C___RESET}${_C_____DIM}>${_C___RESET}"
  echo -ne   "${_C_____DIM}<${_C___RESET}${_C_HEADING}:${_C___RESET}${_C_____DIM}>${_C___RESET}"
  echo -ne   "${_C_____DIM}[${_C___RESET}${_C___ERROR}+${_C___RESET}${_C_____DIM}]${_C___RESET}"
  echo -ne   "${_C_____DIM}<${_C___RESET}${_C___VALUE}pattern${_C___RESET}${_C_____DIM}>${_C___RESET}"
  echo -e   "${_C_____DIM}[${_C___RESET}${_C___ERROR}+${_C___RESET}${_C_____DIM}]${_C___RESET}"
  echo
  echo -e "  Prefixes:"
  echo -e "    ${_C___ERROR}path  ${_C___RESET} ${_C___ERROR}P${_C___RESET}   Match for path name"
  echo -e "    ${_C___ERROR}repo  ${_C___RESET} ${_C___ERROR}R${_C___RESET}   Match for repo name"
  echo -e "    ${_C___ERROR}branch${_C___RESET} ${_C___ERROR}B${_C___RESET}   Match for current git branch"
  echo
  echo -e "  Patterns:"
  echo -e "    ${_C___ERROR}+${_C___RESET}          Matches anywhere in the value (default if no anchors specified)"
  echo -e "     ${_C___VALUE}pattern${_C___RESET}${_C___ERROR}+${_C___RESET}  Matches the beginning of the value"
  echo -e "    ${_C___ERROR}+${_C___RESET}${_C___VALUE}pattern${_C___RESET}   Matches the end of the value"
  echo -e "    ${_C___ERROR}+${_C___RESET}${_C___VALUE}pattern${_C___RESET}${_C___ERROR}+${_C___RESET}  Matches substring anywhere in the value"
  echo -e "     ${_C___VALUE}pattern${_C___RESET}   Matches exactly the value"
  echo
  echo -e "${_C_HEADING}Ignore-file:${_C___RESET}"
  echo -e "  Gitter will look for a ${_C____PATH}.gitterignore${_C___RESET} file ${_C____ARGS}in the current directory.${_C___RESET}"
  echo -e "  If found, it will read patterns from the file to ignore matching repositories."
  echo -e "  Each line in the file should contain a pattern to match repository names or paths."
  echo -e "  Lines starting with ${_C___ERROR}#${_C___RESET} are treated as comments and ignored."
  echo -e "  Patterns:"
  echo -e "    ${_C___ERROR}relative/path/to/directory${_C___RESET} - Ignore directory at exact relative path ${_C____PATH}relative/path/to/directory${_C___RESET}"
  echo -e "    ${_C___ERROR}*/directory_name${_C___RESET}           - Ignore directories under any parent directory named ${_C____PATH}directory_name${_C___RESET}"
  echo -e "    ${_C___ERROR}directory_name/*${_C___RESET}           - Ignore directories directly under the top-level directory named ${_C____PATH}directory_name${_C___RESET}"
  echo
  echo -e "${_C_HEADING}Placeholders:${_C___RESET}"
  echo -e "  Within ${_C__OPTION}exec${_C___RESET} and ${_C__OPTION}git${_C___RESET} commands, the following placeholders can be used in arguments:"
  echo -e "    ${_C____ARGS}{_repo_}${_C___RESET}         - Name of the current git repository"
  echo -e "    ${_C____ARGS}{_path_}${_C___RESET}         - Relative path of the current working directory from where gitter was invoked"
  echo -e "    ${_C____ARGS}{_path:abs_}${_C___RESET}     - Absolute path of the current working directory"
  echo -e "    ${_C____ARGS}{_branch_}${_C___RESET}       - Current git branch name"
  echo -e "    ${_C____ARGS}{_commit_}${_C___RESET}       - Current git commit hash"
  echo -e "    ${_C____ARGS}{_commit:[int]_}${_C___RESET} - Current git commit hash abbreviated to [int] characters. i.e. ${_C____ARGS}{_commit:8_}${_C___RESET}"
  echo -e "    ${_C____ARGS}{_author_}${_C___RESET}       - Current git commit author email"
  echo
}
