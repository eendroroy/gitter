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
  echo -e "${GITTER_C_HEADING}Version:${GITTER_C___RESET} ${GITTER_C__OPTION}${____GITTER_VERSION}${GITTER_C___RESET}"
  echo
  echo -e "${GITTER_C_HEADING}Usage:${GITTER_C___RESET}"
  echo -ne "  ${GITTER_C_COMMAND}gitter${GITTER_C___RESET}"
  echo -ne "  [${GITTER_C__OPTION}--<option>${GITTER_C___RESET} ...]"
  echo -e  " [${GITTER_C__OPTION}command${GITTER_C___RESET} [${GITTER_C__OPTION}--${GITTER_C___RESET} <${GITTER_C_____ARG}args ...${GITTER_C___RESET}>${GITTER_C___RESET}]]"
  echo
  echo -e "${GITTER_C_HEADING}Options:${GITTER_C___RESET}"
  echo -e "  ${GITTER_C__OPTION}--max-depth         -d <${GITTER_C___VALUE}depth${GITTER_C___RESET}>${GITTER_C___RESET}   Look for git repositories up to specified depth (default: ${GITTER_C_____ARG}2${GITTER_C___RESET})"
  echo -e "  ${GITTER_C__OPTION}--filter            -f <${GITTER_C___VALUE}pattern${GITTER_C___RESET}>${GITTER_C___RESET} Filter repositories matching the given pattern (can be specified multiple times)"
  echo -e "  ${GITTER_C__OPTION}--exclude           -e          ${GITTER_C___RESET} Exclude matched repositories instead of including"
  echo -e "  ${GITTER_C__OPTION}--ask-confirmation  -a          ${GITTER_C___RESET} Ask for confirmation before executing commands in each repository"
  echo -e "  ${GITTER_C__OPTION}--continue-on-error -c          ${GITTER_C___RESET} Continue executing commands in other repositories even if an error occurs in one"
  echo -e "  ${GITTER_C__OPTION}--quiet             -q          ${GITTER_C___RESET} Enable quiet mode (suppress output of successful commands)"
  echo -e "  ${GITTER_C__OPTION}--no-color                      ${GITTER_C___RESET} Disable colored output"
  echo -e "  ${GITTER_C__OPTION}--verbose           -v          ${GITTER_C___RESET} Enable verbose mode"
  echo -e "  ${GITTER_C__OPTION}--dry-run           -n          ${GITTER_C___RESET} Show what would be executed without actually running the commands"
  echo
  echo -e "${GITTER_C_HEADING}Commands:${GITTER_C___RESET}"
  echo -e "  ${GITTER_C__OPTION}git     g ${GITTER_C___RESET}        Run a git command (${GITTER_C_____ARG}default${GITTER_C___RESET})"
  echo -e "  ${GITTER_C__OPTION}exec    x ${GITTER_C___RESET}        Run an arbitrary command"
  echo -e "  ${GITTER_C__OPTION}eval    e ${GITTER_C___RESET}        Evaluate a shell command - useful for complex commands involving pipes and redirections"
  echo -e "  ${GITTER_C__OPTION}list    ls${GITTER_C___RESET}        List repositories only"
  echo -e "  ${GITTER_C__OPTION}        ll${GITTER_C___RESET}        Equivalent to ${GITTER_C__OPTION}list --verbose${GITTER_C___RESET} command"
  echo -e "  ${GITTER_C__OPTION}config  c ${GITTER_C___RESET}        Print current (effective) configuration"
  echo -e "  ${GITTER_C__OPTION}version v ${GITTER_C___RESET}        Show version"
  echo -e "  ${GITTER_C__OPTION}help      ${GITTER_C___RESET} [${GITTER_C___VALUE}item${GITTER_C___RESET}] Show help"
  echo

  echo -e  "${GITTER_C_HEADING}Help items:${GITTER_C___RESET}"
  echo -ne "  ${GITTER_C_COMMAND}gitter${GITTER_C___RESET}"
  echo -ne " ${GITTER_C__OPTION}help${GITTER_C___RESET}"
  echo -ne " [${GITTER_C_____ARG}filter${GITTER_C___RESET}|"
  echo -ne "${GITTER_C_____ARG}gitterignore${GITTER_C___RESET}"
  echo -ne "|${GITTER_C_____ARG}placeholder${GITTER_C___RESET}"
  echo -e  "|${GITTER_C_____ARG}status${GITTER_C___RESET}]"
  echo
  echo -e "  ${GITTER_C_____ARG}filter      ${GITTER_C___RESET} Show help about filter patterns"
  echo -e "  ${GITTER_C_____ARG}gitterignore${GITTER_C___RESET} Show help about .gitterignore file"
  echo -e "  ${GITTER_C_____ARG}placeholder ${GITTER_C___RESET} Show help about available placeholders"
  echo -e "  ${GITTER_C_____ARG}status      ${GITTER_C___RESET} Show help about status placeholders"
  echo
  echo -e "${GITTER_C_HEADING}For more information, visit: ${GITTER_C___RESET} ${____GITTER____LINK}"
  echo
}

__help_filter() {
  echo
  echo -e "${GITTER_C_HEADING}Gitter${GITTER_C___RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -ne "${GITTER_C_HEADING}Syntax:${GITTER_C___RESET}"
  echo -ne "   ${GITTER_C_____DIM}<${GITTER_C___RESET}${GITTER_C___ERROR}prefix${GITTER_C___RESET}${GITTER_C_____DIM}>${GITTER_C___RESET}"
  echo -ne "${GITTER_C_____DIM}<${GITTER_C___RESET}${GITTER_C_HEADING}:${GITTER_C___RESET}${GITTER_C_____DIM}>${GITTER_C___RESET}"
  echo -ne "${GITTER_C_____DIM}[${GITTER_C___RESET}${GITTER_C___ERROR}+${GITTER_C___RESET}${GITTER_C_____DIM}]${GITTER_C___RESET}"
  echo -ne "${GITTER_C_____DIM}<${GITTER_C___RESET}${GITTER_C___VALUE}pattern${GITTER_C___RESET}${GITTER_C_____DIM}>${GITTER_C___RESET}"
  echo -e  "${GITTER_C_____DIM}[${GITTER_C___RESET}${GITTER_C___ERROR}+${GITTER_C___RESET}${GITTER_C_____DIM}]${GITTER_C___RESET}"
  echo
  echo -e "${GITTER_C_HEADING}Prefixes:${GITTER_C___RESET}"
  echo -e "  ${GITTER_C___ERROR}path  ${GITTER_C___RESET}  Match for path name"
  echo -e "  ${GITTER_C___ERROR}repo  ${GITTER_C___RESET}  Match for repository name"
  echo -e "  ${GITTER_C___ERROR}branch${GITTER_C___RESET}  Match for current git branch"
  echo
  echo -e "${GITTER_C_HEADING}Patterns:${GITTER_C___RESET}"
  echo -e "  ${GITTER_C___ERROR}+${GITTER_C___RESET}          Matches anywhere in the value (default if no anchors specified)"
  echo -e "   ${GITTER_C___VALUE}pattern${GITTER_C___RESET}${GITTER_C___ERROR}+${GITTER_C___RESET}  Matches the beginning of the value"
  echo -e "  ${GITTER_C___ERROR}+${GITTER_C___RESET}${GITTER_C___VALUE}pattern${GITTER_C___RESET}   Matches the end of the value"
  echo -e "  ${GITTER_C___ERROR}+${GITTER_C___RESET}${GITTER_C___VALUE}pattern${GITTER_C___RESET}${GITTER_C___ERROR}+${GITTER_C___RESET}  Matches substring anywhere in the value"
  echo -e "   ${GITTER_C___VALUE}pattern${GITTER_C___RESET}   Matches exactly the value"
  echo
  echo -e "${GITTER_C_HEADING}Examples:${GITTER_C___RESET}"
  echo -e "  ${GITTER_C_COMMAND}gitter ${GITTER_C__OPTION}--filter${GITTER_C___RESET} ${GITTER_C___VALUE}path:src/+${GITTER_C___RESET}                     Filter repositories with path starting with 'src/'"
  echo -e "  ${GITTER_C_COMMAND}gitter ${GITTER_C__OPTION}--exclude --filter${GITTER_C___RESET} ${GITTER_C___VALUE}repo:+-test${GITTER_C___RESET}          Filter repositories with name NOT ending with '-test'"
  echo -e "  ${GITTER_C_COMMAND}gitter ${GITTER_C__OPTION}--filter${GITTER_C___RESET} ${GITTER_C___VALUE}branch:master${GITTER_C___RESET}                  Filter repositories on branch 'master'"
  echo -e "  ${GITTER_C_COMMAND}gitter ${GITTER_C__OPTION}--filter${GITTER_C___RESET} ${GITTER_C___VALUE}path:+src/${GITTER_C___RESET} ${GITTER_C__OPTION}--filter${GITTER_C___RESET} ${GITTER_C___VALUE}path:+test${GITTER_C___RESET} Filter repositories with path containing 'src/' or 'test'"
  echo
}

__help_gitterignore() {
  echo
  echo -e "${GITTER_C_HEADING}Gitter${GITTER_C___RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -e "${GITTER_C_HEADING}Ignore-file:${GITTER_C___RESET}"
  echo -e "  Gitter will look for a ${GITTER_C____PATH}.gitterignore${GITTER_C___RESET} file ${GITTER_C_____ARG}in the current directory.${GITTER_C___RESET}"
  echo -e "  If found, it will read patterns from the file to ignore matching repositories."
  echo -e "  Each line in the file should contain a pattern to match repository names or paths."
  echo -e "  Lines starting with ${GITTER_C___ERROR}#${GITTER_C___RESET} are treated as comments and ignored."
  echo -e "  Patterns:"
  echo -e "    ${GITTER_C___ERROR}relative/path/to/directory${GITTER_C___RESET} Ignore directory at exact relative path ${GITTER_C____PATH}relative/path/to/directory${GITTER_C___RESET}"
  echo -e "    ${GITTER_C___ERROR}*/directory_name${GITTER_C___RESET}           Ignore directories under any parent directory named ${GITTER_C____PATH}directory_name${GITTER_C___RESET}"
  echo -e "    ${GITTER_C___ERROR}directory_name/*${GITTER_C___RESET}           Ignore directories directly under the top-level directory named ${GITTER_C____PATH}directory_name${GITTER_C___RESET}"
  echo
}

__help_placeholder() {
  echo
  echo -e "${GITTER_C_HEADING}Gitter${GITTER_C___RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -e "${GITTER_C_HEADING}Placeholders:${GITTER_C___RESET}"
  echo -e "  Within ${GITTER_C__OPTION}exec${GITTER_C___RESET} and ${GITTER_C__OPTION}git${GITTER_C___RESET} commands, the following placeholders can be used in arguments:"
  echo -e "    ${GITTER_C_____ARG}{_repo_}        ${GITTER_C___RESET} Name of the current git repository"
  echo -e "    ${GITTER_C_____ARG}{_path:r_}      ${GITTER_C___RESET} Relative path of the current working directory from where gitter was invoked"
  echo -e "    ${GITTER_C_____ARG}{_path:a_}      ${GITTER_C___RESET} Absolute path of the current working directory"
  echo -e "    ${GITTER_C_____ARG}{_branch_}      ${GITTER_C___RESET} Current git branch name"
  echo -e "    ${GITTER_C_____ARG}{_commit:f_}    ${GITTER_C___RESET} Current git commit hash"
  echo -e "    ${GITTER_C_____ARG}{_commit:[int]_}${GITTER_C___RESET} Current git commit hash abbreviated to [int] characters. i.e. ${GITTER_C_____ARG}{_commit:8_}${GITTER_C___RESET}"
  echo -e "    ${GITTER_C_____ARG}{_commit:c_}    ${GITTER_C___RESET} Current git commit count"
  echo -e "    ${GITTER_C_____ARG}{_author:e_}    ${GITTER_C___RESET} Current git commit author email"
  echo -e "    ${GITTER_C_____ARG}{_author:n_}    ${GITTER_C___RESET} Current git commit author name"
  echo -e "    ${GITTER_C_____ARG}{_time:r_}      ${GITTER_C___RESET} Relative time of the current git commit (e.g., \"2 days ago\")"
  echo -e "    ${GITTER_C_____ARG}{_time:d_}      ${GITTER_C___RESET} Date and time of the current git commit (e.g., \"2024-01-01 12:00:00\")"
  echo
  echo -e "${GITTER_C_HEADING}Example Usage:${GITTER_C___RESET}"
  echo -e "  ${GITTER_C_COMMAND}gitter${GITTER_C___RESET} ${GITTER_C__OPTION}exec${GITTER_C___RESET} -- echo \
\"Repository: ${GITTER_C_____ARG}{_repo_}${GITTER_C___RESET}, \
Branch: ${GITTER_C_____ARG}{_branch_}${GITTER_C___RESET}, \
Commit: ${GITTER_C_____ARG}{_commit:8_}${GITTER_C___RESET}\
Author: ${GITTER_C_____ARG}{_author:e_}${GITTER_C___RESET}, \
Date: ${GITTER_C_____ARG}{_time:d_}${GITTER_C___RESET}\""
  echo
}

__help_status() {
  echo
  echo -e "${GITTER_C_HEADING}Gitter${GITTER_C___RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -e "${GITTER_C_HEADING}Available placeholders:${GITTER_C___RESET}"
  echo -e "    ${GITTER_C_____ARG}[branch]  ${GITTER_C___RESET} Current git branch name"
  echo -e "    ${GITTER_C_____ARG}[commit:a]${GITTER_C___RESET} Abbreviated (8) current git commit hash"
  echo -e "    ${GITTER_C_____ARG}[commit:f]${GITTER_C___RESET} Full current git commit hash"
  echo -e "    ${GITTER_C_____ARG}[commit:c]${GITTER_C___RESET} Current git commit count"
  echo -e "    ${GITTER_C_____ARG}[time:r]  ${GITTER_C___RESET} Relative time of the current git commit (e.g., "2 days ago")"
  echo -e "    ${GITTER_C_____ARG}[time:d]  ${GITTER_C___RESET} Date and time of the current git commit (e.g., "2024-01-01 12:00:00")"
  echo -e "    ${GITTER_C_____ARG}[author:e]${GITTER_C___RESET} Current git commit author email"
  echo -e "    ${GITTER_C_____ARG}[author:n]${GITTER_C___RESET} Current git commit author name"
  echo
  echo -e "${GITTER_C_HEADING}Example Configuration for status:${GITTER_C___RESET}"
  echo -e " Set ${GITTER_C_COMMAND}GITTER_REPO_STATUS${GITTER_C___RESET}=${GITTER_C_____ARG}(\"on\" \"[branch]\")${GITTER_C___RESET}"
  echo
  echo -e  "${GITTER_C_HEADING}Example Configuration for verbose status:${GITTER_C___RESET}"
  echo -ne " Set ${GITTER_C_COMMAND}GITTER_REPO_STATUS_VERBOSE${GITTER_C___RESET}="
  echo -e  "${GITTER_C_____ARG}(\" on \" \"[branch]\" \" \" \"[commit:a]\" \" by \" \"[author:e]\" \" \" \"[time:r]\")${GITTER_C___RESET}"
  echo
}

__version() {
  echo -e "${GITTER_C__OPTION}${____GITTER_VERSION}${GITTER_C___RESET}"
}

___print_config_value() {
  echo -e "  ${GITTER_C__OPTION}${1}${GITTER_C___RESET}${GITTER_C_COMMAND}${2}${GITTER_C___RESET}=${GITTER_C_____ARG}${3}${GITTER_C___RESET}"
}

__print_config() {
  echo
  echo -e "${GITTER_C_HEADING}Symbols:${GITTER_C___RESET}"
  ___print_config_value "" "               GITTER_SUCCESS_SYMBOL" "'${GITTER_SUCCESS_SYMBOL}'"
  ___print_config_value "" "               GITTER___ERROR_SYMBOL" "'${GITTER___ERROR_SYMBOL}'"
  ___print_config_value "" "               GITTER_PRIMARY_SYMBOL" "'${GITTER_PRIMARY_SYMBOL}'"
  echo
  echo -e "${GITTER_C_HEADING}Configurations:${GITTER_C___RESET}"
  ___print_config_value "" "                    GITTER_MAX_DEPTH" "'${GITTER_MAX_DEPTH}'"
  ___print_config_value "" "                      GITTER_FILTERS" "(${GITTER_FILTERS[*]})"
  ___print_config_value "" "                      GITTER_VERBOSE" "'${GITTER_VERBOSE}'"
  ___print_config_value "" "               GITTER_FILTER_EXCLUDE" "'${GITTER_FILTER_EXCLUDE}'"
  ___print_config_value "" "                     GITTER_NO_COLOR" "'${GITTER_NO_COLOR}'"
  ___print_config_value "" "             GITTER_ASK_CONFIRMATION" "'${GITTER_ASK_CONFIRMATION}'"
  ___print_config_value "" "            GITTER_CONTINUE_ON_ERROR" "'${GITTER_CONTINUE_ON_ERROR}'"
  ___print_config_value "" "                  GITTER_REPO_STATUS" "(${GITTER_REPO_STATUS[*]})"
  ___print_config_value "" "          GITTER_REPO_STATUS_VERBOSE" "(${GITTER_REPO_STATUS_VERBOSE[*]})"
  echo
  echo -e "${GITTER_C_HEADING}Colors:${GITTER_C___RESET}"
  ___print_config_value "(${GITTER_C_SUCCESS}Success color ${GITTER_C___RESET})    " "GITTER_C_SUCCESS" "'\\${GITTER_C_SUCCESS}'"
  ___print_config_value "(${GITTER_C___ERROR}Error color   ${GITTER_C___RESET})    " "GITTER_C___ERROR" "'\\${GITTER_C___ERROR}'"
  ___print_config_value "(${GITTER_C____PATH}Path color    ${GITTER_C___RESET})    " "GITTER_C____PATH" "'\\${GITTER_C____PATH}'"
  ___print_config_value "(${GITTER_C_PATH_DM}Path Dim color${GITTER_C___RESET})    " "GITTER_C_PATH_DM" "'\\${GITTER_C_PATH_DM}'"
  ___print_config_value "(${GITTER_C_____DIM}Dim color     ${GITTER_C___RESET})    " "GITTER_C_____DIM" "'\\${GITTER_C_____DIM}'"
  ___print_config_value "(${GITTER_C_HEADING}Heading color ${GITTER_C___RESET})    " "GITTER_C_HEADING" "'\\${GITTER_C_HEADING}'"
  ___print_config_value "(${GITTER_C_COMMAND}Command color ${GITTER_C___RESET})    " "GITTER_C_COMMAND" "'\\${GITTER_C_COMMAND}'"
  ___print_config_value "(${GITTER_C_____ARG}Argument color${GITTER_C___RESET})    " "GITTER_C_____ARG" "'\\${GITTER_C_____ARG}'"
  ___print_config_value "(${GITTER_C__OPTION}Option color  ${GITTER_C___RESET})    " "GITTER_C__OPTION" "'\\${GITTER_C__OPTION}'"
  ___print_config_value "(${GITTER_C___VALUE}Value color   ${GITTER_C___RESET})    " "GITTER_C___VALUE" "'\\${GITTER_C___VALUE}'"
  echo
}