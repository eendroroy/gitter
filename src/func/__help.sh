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
  echo -e "${GITTER_C_HEADING}Gitter${GITTER_C___RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -e "${GITTER_C_HEADING}Usage:${GITTER_C___RESET}"
  echo -ne "  ${GITTER_C_COMMAND}gitter${GITTER_C___RESET} [[${GITTER_C__OPTION}--exclude${GITTER_C___RESET}] ${GITTER_C__OPTION}--filter <${GITTER_C___VALUE}pattern${GITTER_C___RESET}${GITTER_C__OPTION}>${GITTER_C___RESET} ...] [${GITTER_C__OPTION}--<option>${GITTER_C___RESET} ...]"
  echo -ne " [${GITTER_C__OPTION}git${GITTER_C___RESET} ${GITTER_C__OPTION}--${GITTER_C___RESET} <${GITTER_C____ARGS}args ...${GITTER_C___RESET}>${GITTER_C___RESET}"
  echo -ne "|${GITTER_C__OPTION}exec${GITTER_C___RESET} ${GITTER_C__OPTION}--${GITTER_C___RESET} <${GITTER_C____ARGS}args ...${GITTER_C___RESET}>${GITTER_C___RESET}"
  echo -ne "|${GITTER_C__OPTION}list${GITTER_C___RESET}"
  echo -e "|${GITTER_C__OPTION}help${GITTER_C___RESET}]"
  echo
  echo -e "${GITTER_C_HEADING}Commands:${GITTER_C___RESET}"
  echo -e "  ${GITTER_C__OPTION}git   g  ${GITTER_C___RESET} Run a git command (${GITTER_C____ARGS}default${GITTER_C___RESET})"
  echo -e "  ${GITTER_C__OPTION}exec  x  ${GITTER_C___RESET} Run an arbitrary command"
  echo -e "  ${GITTER_C__OPTION}list  ls ${GITTER_C___RESET} List repositories only"
  echo -e "  ${GITTER_C__OPTION}      ll ${GITTER_C___RESET} Equivalent to ${GITTER_C__OPTION}list --verbose${GITTER_C___RESET} command"
  echo -e "  ${GITTER_C__OPTION}help     ${GITTER_C___RESET} Show this help menu"
  echo
  echo -e "${GITTER_C_HEADING}Options:${GITTER_C___RESET}"
  echo -e "  ${GITTER_C__OPTION}--filter   -f <${GITTER_C___VALUE}pattern${GITTER_C___RESET}> ${GITTER_C___RESET} Match repo directory name exactly"
  echo -e "  ${GITTER_C__OPTION}--exclude  -e           ${GITTER_C___RESET} Exclude matched repositories instead of including"
  echo -e "  ${GITTER_C__OPTION}--verbose  -v           ${GITTER_C___RESET} Enable verbose mode"
  echo -e "  ${GITTER_C__OPTION}--no-color              ${GITTER_C___RESET} Disable colored output"
  echo
  echo -e "${GITTER_C_HEADING}Filers:${GITTER_C___RESET}"
  echo -e "  Syntax:"
  echo -ne "    ${GITTER_C_____DIM}<${GITTER_C___RESET}${GITTER_C___ERROR}prefix${GITTER_C___RESET}${GITTER_C_____DIM}>${GITTER_C___RESET}"
  echo -ne   "${GITTER_C_____DIM}<${GITTER_C___RESET}${GITTER_C_HEADING}:${GITTER_C___RESET}${GITTER_C_____DIM}>${GITTER_C___RESET}"
  echo -ne   "${GITTER_C_____DIM}[${GITTER_C___RESET}${GITTER_C___ERROR}+${GITTER_C___RESET}${GITTER_C_____DIM}]${GITTER_C___RESET}"
  echo -ne   "${GITTER_C_____DIM}<${GITTER_C___RESET}${GITTER_C___VALUE}pattern${GITTER_C___RESET}${GITTER_C_____DIM}>${GITTER_C___RESET}"
  echo -e   "${GITTER_C_____DIM}[${GITTER_C___RESET}${GITTER_C___ERROR}+${GITTER_C___RESET}${GITTER_C_____DIM}]${GITTER_C___RESET}"
  echo
  echo -e "  Prefixes:"
  echo -e "    ${GITTER_C___ERROR}path  ${GITTER_C___RESET}  Match for path name"
  echo -e "    ${GITTER_C___ERROR}repo  ${GITTER_C___RESET}  Match for repo name"
  echo -e "    ${GITTER_C___ERROR}branch${GITTER_C___RESET}  Match for current git branch"
  echo
  echo -e "  Patterns:"
  echo -e "    ${GITTER_C___ERROR}+${GITTER_C___RESET}          Matches anywhere in the value (default if no anchors specified)"
  echo -e "     ${GITTER_C___VALUE}pattern${GITTER_C___RESET}${GITTER_C___ERROR}+${GITTER_C___RESET}  Matches the beginning of the value"
  echo -e "    ${GITTER_C___ERROR}+${GITTER_C___RESET}${GITTER_C___VALUE}pattern${GITTER_C___RESET}   Matches the end of the value"
  echo -e "    ${GITTER_C___ERROR}+${GITTER_C___RESET}${GITTER_C___VALUE}pattern${GITTER_C___RESET}${GITTER_C___ERROR}+${GITTER_C___RESET}  Matches substring anywhere in the value"
  echo -e "     ${GITTER_C___VALUE}pattern${GITTER_C___RESET}   Matches exactly the value"
  echo
  echo -e "${GITTER_C_HEADING}Ignore-file:${GITTER_C___RESET}"
  echo -e "  Gitter will look for a ${GITTER_C____PATH}.gitterignore${GITTER_C___RESET} file ${GITTER_C____ARGS}in the current directory.${GITTER_C___RESET}"
  echo -e "  If found, it will read patterns from the file to ignore matching repositories."
  echo -e "  Each line in the file should contain a pattern to match repository names or paths."
  echo -e "  Lines starting with ${GITTER_C___ERROR}#${GITTER_C___RESET} are treated as comments and ignored."
  echo -e "  Patterns:"
  echo -e "    ${GITTER_C___ERROR}relative/path/to/directory${GITTER_C___RESET} Ignore directory at exact relative path ${GITTER_C____PATH}relative/path/to/directory${GITTER_C___RESET}"
  echo -e "    ${GITTER_C___ERROR}*/directory_name${GITTER_C___RESET}           Ignore directories under any parent directory named ${GITTER_C____PATH}directory_name${GITTER_C___RESET}"
  echo -e "    ${GITTER_C___ERROR}directory_name/*${GITTER_C___RESET}           Ignore directories directly under the top-level directory named ${GITTER_C____PATH}directory_name${GITTER_C___RESET}"
  echo
  echo -e "${GITTER_C_HEADING}Placeholders:${GITTER_C___RESET}"
  echo -e "  Within ${GITTER_C__OPTION}exec${GITTER_C___RESET} and ${GITTER_C__OPTION}git${GITTER_C___RESET} commands, the following placeholders can be used in arguments:"
  echo -e "    ${GITTER_C____ARGS}{_repo_}${GITTER_C___RESET}         Name of the current git repository"
  echo -e "    ${GITTER_C____ARGS}{_path_}${GITTER_C___RESET}         Relative path of the current working directory from where gitter was invoked"
  echo -e "    ${GITTER_C____ARGS}{_path:abs_}${GITTER_C___RESET}     Absolute path of the current working directory"
  echo -e "    ${GITTER_C____ARGS}{_branch_}${GITTER_C___RESET}       Current git branch name"
  echo -e "    ${GITTER_C____ARGS}{_commit_}${GITTER_C___RESET}       Current git commit hash"
  echo -e "    ${GITTER_C____ARGS}{_commit:[int]_}${GITTER_C___RESET} Current git commit hash abbreviated to [int] characters. i.e. ${GITTER_C____ARGS}{_commit:8_}${GITTER_C___RESET}"
  echo -e "    ${GITTER_C____ARGS}{_author_}${GITTER_C___RESET}       Current git commit author email"
  echo
}
