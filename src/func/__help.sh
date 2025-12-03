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
  echo -e "${GITTER_C__HEADING}Gitter${GITTER_C____RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -e "${GITTER_C__HEADING}Version:${GITTER_C____RESET} ${GITTER_C___OPTION}${____GITTER_VERSION}${GITTER_C____RESET}"
  echo
  echo -e "${GITTER_C__HEADING}Usage:${GITTER_C____RESET}"
  echo -ne "  ${GITTER_C__COMMAND}gitter${GITTER_C____RESET}"
  echo -ne "  [${GITTER_C___OPTION}--<option>${GITTER_C____RESET} ...]"
  echo -e  " [${GITTER_C___OPTION}command${GITTER_C____RESET} [${GITTER_C___OPTION}--${GITTER_C____RESET} <${GITTER_C______ARG}args ...${GITTER_C____RESET}>${GITTER_C____RESET}]]"
  echo
  echo -e "${GITTER_C__HEADING}Options:${GITTER_C____RESET}"
  echo -e "  ${GITTER_C___OPTION}--status            -s <${GITTER_C____VALUE}status${GITTER_C____RESET}>${GITTER_C____RESET}  Set repository status format (overrides ${GITTER_C__COMMAND}GITTER_REPO_STATUS${GITTER_C____RESET} variable)"
  echo -e "  ${GITTER_C___OPTION}--max-depth         -d <${GITTER_C____VALUE}depth${GITTER_C____RESET}>${GITTER_C____RESET}   Look for git repositories up to specified depth (default: ${GITTER_C______ARG}2${GITTER_C____RESET})"
  echo -e "  ${GITTER_C___OPTION}--filter            -f <${GITTER_C____VALUE}pattern${GITTER_C____RESET}>${GITTER_C____RESET} Filter repositories matching the given pattern (can be specified multiple times)"
  echo -e "  ${GITTER_C___OPTION}--exclude           -e          ${GITTER_C____RESET} Exclude matched repositories instead of including"
  echo -e "  ${GITTER_C___OPTION}--ask-confirmation  -a          ${GITTER_C____RESET} Ask for confirmation before executing commands in each repository"
  echo -e "  ${GITTER_C___OPTION}--continue-on-error -c          ${GITTER_C____RESET} Continue executing commands in other repositories even if an error occurs in one"
  echo -e "  ${GITTER_C___OPTION}--quiet             -q          ${GITTER_C____RESET} Enable quiet mode (suppress output of successful commands)"
  echo -e "  ${GITTER_C___OPTION}--no-color                      ${GITTER_C____RESET} Disable colored output"
  echo -e "  ${GITTER_C___OPTION}--dry-run           -n          ${GITTER_C____RESET} Show what would be executed without actually running the commands"
  echo
  echo -e "${GITTER_C__HEADING}Commands:${GITTER_C____RESET}"
  echo -e "  ${GITTER_C___OPTION}git     g ${GITTER_C____RESET}        Run a git command (${GITTER_C______ARG}default${GITTER_C____RESET})"
  echo -e "  ${GITTER_C___OPTION}exec    x ${GITTER_C____RESET}        Run an arbitrary command"
  echo -e "  ${GITTER_C___OPTION}eval    e ${GITTER_C____RESET}        Evaluate a shell command - useful for complex commands involving pipes and redirections"
  echo -e "  ${GITTER_C___OPTION}list    ls${GITTER_C____RESET}        List repositories only"
  echo -e "  ${GITTER_C___OPTION}config  c ${GITTER_C____RESET}        Print current (effective) configuration"
  echo -e "  ${GITTER_C___OPTION}version v ${GITTER_C____RESET}        Show version"
  echo -e "  ${GITTER_C___OPTION}help      ${GITTER_C____RESET} [${GITTER_C____VALUE}item${GITTER_C____RESET}] Show help"
  echo

  echo -e  "${GITTER_C__HEADING}Help items:${GITTER_C____RESET}"
  echo -ne "  ${GITTER_C__COMMAND}gitter${GITTER_C____RESET}"
  echo -ne " ${GITTER_C___OPTION}help${GITTER_C____RESET}"
  echo -ne " [${GITTER_C______ARG}filter${GITTER_C____RESET}|"
  echo -ne "${GITTER_C______ARG}gitterignore${GITTER_C____RESET}"
  echo -ne "|${GITTER_C______ARG}expander${GITTER_C____RESET}"
  echo -e  "|${GITTER_C______ARG}status${GITTER_C____RESET}]"
  echo
  echo -e "  ${GITTER_C______ARG}filter      ${GITTER_C____RESET} Show help about filter patterns"
  echo -e "  ${GITTER_C______ARG}gitterignore${GITTER_C____RESET} Show help about .gitterignore file"
  echo -e "  ${GITTER_C______ARG}expander    ${GITTER_C____RESET} Show help about available expanders"
  echo -e "  ${GITTER_C______ARG}status      ${GITTER_C____RESET} Show help about status placeholders"
  echo
  echo -e "${GITTER_C__HEADING}For more information, visit: ${GITTER_C____RESET} ${____GITTER____LINK}"
  echo
}

__help_filter() {
  echo
  echo -e "${GITTER_C__HEADING}Gitter${GITTER_C____RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -ne "${GITTER_C__HEADING}Syntax:${GITTER_C____RESET}"
  echo -ne "   ${GITTER_C______DIM}<${GITTER_C____RESET}${GITTER_C____ERROR}prefix${GITTER_C____RESET}${GITTER_C______DIM}>${GITTER_C____RESET}"
  echo -ne "${GITTER_C______DIM}<${GITTER_C____RESET}${GITTER_C__HEADING}:${GITTER_C____RESET}${GITTER_C______DIM}>${GITTER_C____RESET}"
  echo -ne "${GITTER_C______DIM}[${GITTER_C____RESET}${GITTER_C____ERROR}+${GITTER_C____RESET}${GITTER_C______DIM}]${GITTER_C____RESET}"
  echo -ne "${GITTER_C______DIM}<${GITTER_C____RESET}${GITTER_C____VALUE}pattern${GITTER_C____RESET}${GITTER_C______DIM}>${GITTER_C____RESET}"
  echo -e  "${GITTER_C______DIM}[${GITTER_C____RESET}${GITTER_C____ERROR}+${GITTER_C____RESET}${GITTER_C______DIM}]${GITTER_C____RESET}"
  echo
  echo -e "${GITTER_C__HEADING}Prefixes:${GITTER_C____RESET}"
  echo -e "  ${GITTER_C____ERROR}path  ${GITTER_C____RESET}  Match for path name"
  echo -e "  ${GITTER_C____ERROR}repo  ${GITTER_C____RESET}  Match for repository name"
  echo -e "  ${GITTER_C____ERROR}branch${GITTER_C____RESET}  Match for current git branch"
  echo
  echo -e "${GITTER_C__HEADING}Patterns:${GITTER_C____RESET}"
  echo -e "  ${GITTER_C____ERROR}+${GITTER_C____RESET}          Matches anywhere in the value (default if no anchors specified)"
  echo -e "   ${GITTER_C____VALUE}pattern${GITTER_C____RESET}${GITTER_C____ERROR}+${GITTER_C____RESET}  Matches the beginning of the value"
  echo -e "  ${GITTER_C____ERROR}+${GITTER_C____RESET}${GITTER_C____VALUE}pattern${GITTER_C____RESET}   Matches the end of the value"
  echo -e "  ${GITTER_C____ERROR}+${GITTER_C____RESET}${GITTER_C____VALUE}pattern${GITTER_C____RESET}${GITTER_C____ERROR}+${GITTER_C____RESET}  Matches substring anywhere in the value"
  echo -e "   ${GITTER_C____VALUE}pattern${GITTER_C____RESET}   Matches exactly the value"
  echo
  echo -e "${GITTER_C__HEADING}Examples:${GITTER_C____RESET}"
  echo -e "  ${GITTER_C__COMMAND}gitter ${GITTER_C___OPTION}--filter${GITTER_C____RESET} ${GITTER_C____VALUE}path:src/+${GITTER_C____RESET}                     Filter repositories with path starting with 'src/'"
  echo -e "  ${GITTER_C__COMMAND}gitter ${GITTER_C___OPTION}--exclude --filter${GITTER_C____RESET} ${GITTER_C____VALUE}repo:+-test${GITTER_C____RESET}          Filter repositories with name NOT ending with '-test'"
  echo -e "  ${GITTER_C__COMMAND}gitter ${GITTER_C___OPTION}--filter${GITTER_C____RESET} ${GITTER_C____VALUE}branch:master${GITTER_C____RESET}                  Filter repositories on branch 'master'"
  echo -e "  ${GITTER_C__COMMAND}gitter ${GITTER_C___OPTION}--filter${GITTER_C____RESET} ${GITTER_C____VALUE}path:+src/${GITTER_C____RESET} ${GITTER_C___OPTION}--filter${GITTER_C____RESET} ${GITTER_C____VALUE}path:+test${GITTER_C____RESET} Filter repositories with path containing 'src/' or 'test'"
  echo
}

__help_gitterignore() {
  echo
  echo -e "${GITTER_C__HEADING}Gitter${GITTER_C____RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -e "${GITTER_C__HEADING}Ignore-file:${GITTER_C____RESET}"
  echo -e "  Gitter will look for a ${GITTER_C_____REPO}.gitterignore${GITTER_C____RESET} file ${GITTER_C______ARG}in the current directory.${GITTER_C____RESET}"
  echo -e "  If found, it will read patterns from the file to ignore matching repositories."
  echo -e "  Each line in the file should contain a pattern to match repository names or paths."
  echo -e "  Lines starting with ${GITTER_C____ERROR}#${GITTER_C____RESET} are treated as comments and ignored."
  echo -e "  Patterns:"
  echo -e "    ${GITTER_C____ERROR}relative/path/to/directory${GITTER_C____RESET} Ignore directory at exact relative path ${GITTER_C_____REPO}relative/path/to/directory${GITTER_C____RESET}"
  echo -e "    ${GITTER_C____ERROR}*/directory_name${GITTER_C____RESET}           Ignore directories under any parent directory named ${GITTER_C_____REPO}directory_name${GITTER_C____RESET}"
  echo -e "    ${GITTER_C____ERROR}directory_name/*${GITTER_C____RESET}           Ignore directories directly under the top-level directory named ${GITTER_C_____REPO}directory_name${GITTER_C____RESET}"
  echo
}

__help_expander() {
  echo
  echo -e "${GITTER_C__HEADING}Gitter${GITTER_C____RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -e "${GITTER_C__HEADING}Expanders:${GITTER_C____RESET}"
  echo -e "  Within ${GITTER_C___OPTION}exec${GITTER_C____RESET} and ${GITTER_C___OPTION}git${GITTER_C____RESET} commands, the following expanders can be used in arguments:"
  echo -e "    ${GITTER_C______ARG}{_repo_}      ${GITTER_C____RESET} Name of the current git repository"
  echo -e "    ${GITTER_C______ARG}{_path:r_}    ${GITTER_C____RESET} Relative path of the current working directory from where gitter was invoked"
  echo -e "    ${GITTER_C______ARG}{_path:a_}    ${GITTER_C____RESET} Absolute path of the current working directory"
  echo -e "    ${GITTER_C______ARG}{_branch_}    ${GITTER_C____RESET} Current git branch name"
  echo -e "    ${GITTER_C______ARG}{_commit:f_}  ${GITTER_C____RESET} Current git commit hash"
  echo -e "    ${GITTER_C______ARG}{_commit:<n>_}${GITTER_C____RESET} Current git commit hash abbreviated to <n> characters. i.e. ${GITTER_C______ARG}{_commit:8_}${GITTER_C____RESET}"
  echo -e "    ${GITTER_C______ARG}{_commit:c_}  ${GITTER_C____RESET} Current git commit count"
  echo -e "    ${GITTER_C______ARG}{_author:e_}  ${GITTER_C____RESET} Current git commit author email"
  echo -e "    ${GITTER_C______ARG}{_author:n_}  ${GITTER_C____RESET} Current git commit author name"
  echo -e "    ${GITTER_C______ARG}{_time:r_}    ${GITTER_C____RESET} Relative time of the current git commit (e.g., \"2 days ago\")"
  echo -e "    ${GITTER_C______ARG}{_time:d_}    ${GITTER_C____RESET} Date and time of the current git commit (e.g., \"2024-01-01 12:00:00\")"
  echo
  echo -e "${GITTER_C__HEADING}Example Usage:${GITTER_C____RESET}"
  echo -e "  ${GITTER_C__COMMAND}gitter${GITTER_C____RESET} ${GITTER_C___OPTION}exec${GITTER_C____RESET} -- echo \
\"Repository: ${GITTER_C______ARG}{_repo_}${GITTER_C____RESET}, \
Branch: ${GITTER_C______ARG}{_branch_}${GITTER_C____RESET}, \
Commit: ${GITTER_C______ARG}{_commit:8_}${GITTER_C____RESET}, \
Author: ${GITTER_C______ARG}{_author:e_}${GITTER_C____RESET}, \
Date: ${GITTER_C______ARG}{_time:d_}${GITTER_C____RESET}\""
  echo
}

__help_status() {
  echo
  echo -e "${GITTER_C__HEADING}Gitter${GITTER_C____RESET}"
  echo -e "  Run git or arbitrary command in multiple git repositories with filters in current directory"
  echo
  echo -e "${GITTER_C__HEADING}Repository status patters:${GITTER_C____RESET}"
  echo -e "    ${GITTER_C______DIM}[${GITTER_C____RESET}${GITTER_C______ARG}text${GITTER_C____RESET}${GITTER_C______DIM}]${GITTER_C____RESET}${GITTER_C______ARG}|${GITTER_C____RESET}${GITTER_C______DIM}[${GITTER_C____RESET}${GITTER_C______ARG}placeholder${GITTER_C____RESET}${GITTER_C______DIM}]...${GITTER_C____RESET}"
  echo
  echo -e "${GITTER_C__HEADING}Available placeholders:${GITTER_C____RESET}"
  echo -e "    ${GITTER_C______ARG}[branch]    ${GITTER_C____RESET} Current git branch name"
  echo -e "    ${GITTER_C______ARG}[commit:a]  ${GITTER_C____RESET} Abbreviated (8) current git commit hash"
  echo -e "    ${GITTER_C______ARG}[commit:<n>]${GITTER_C____RESET} Abbreviated (<n>) current git commit hash"
  echo -e "    ${GITTER_C______ARG}[commit:f]  ${GITTER_C____RESET} Full current git commit hash"
  echo -e "    ${GITTER_C______ARG}[commit:c]  ${GITTER_C____RESET} Current git commit count"
  echo -e "    ${GITTER_C______ARG}[time:r]    ${GITTER_C____RESET} Relative time of the current git commit (e.g., "2 days ago")"
  echo -e "    ${GITTER_C______ARG}[time:d]    ${GITTER_C____RESET} Date and time of the current git commit (e.g., "2024-01-01 12:00:00")"
  echo -e "    ${GITTER_C______ARG}[author:e]  ${GITTER_C____RESET} Current git commit author email"
  echo -e "    ${GITTER_C______ARG}[author:n]  ${GITTER_C____RESET} Current git commit author name"
  echo
  echo -e "${GITTER_C__HEADING}Example Configuration for status:${GITTER_C____RESET}"
  echo -e " Set ${GITTER_C__COMMAND}GITTER_REPO_STATUS${GITTER_C____RESET}=${GITTER_C______ARG}\" on |[branch]\"${GITTER_C____RESET}"
  echo
}

__version() {
  echo -e "${GITTER_C___OPTION}${____GITTER_VERSION}${GITTER_C____RESET}"
}

___print_config_value() {
  echo -e "  ${GITTER_C___OPTION}${1}${GITTER_C____RESET}${GITTER_C__COMMAND}${2}${GITTER_C____RESET}=${GITTER_C______ARG}${3}${GITTER_C____RESET}"
}

__print_config() {
  echo
  echo -e "${GITTER_C__HEADING}Symbols:${GITTER_C____RESET}"
  ___print_config_value "" "               GITTER_SUCCESS_SYMBOL" "'${GITTER_SUCCESS_SYMBOL}'"
  ___print_config_value "" "               GITTER___ERROR_SYMBOL" "'${GITTER___ERROR_SYMBOL}'"
  ___print_config_value "" "               GITTER_PRIMARY_SYMBOL" "'${GITTER_PRIMARY_SYMBOL}'"
  echo
  echo -e "${GITTER_C__HEADING}Configurations:${GITTER_C____RESET}"
  ___print_config_value "" "                    GITTER_MAX_DEPTH" "'${GITTER_MAX_DEPTH}'"
  ___print_config_value "" "                      GITTER_FILTERS" "(${GITTER_FILTERS[*]})"
  ___print_config_value "" "               GITTER_FILTER_EXCLUDE" "'${GITTER_FILTER_EXCLUDE}'"
  ___print_config_value "" "                     GITTER_NO_COLOR" "'${GITTER_NO_COLOR}'"
  ___print_config_value "" "             GITTER_ASK_CONFIRMATION" "'${GITTER_ASK_CONFIRMATION}'"
  ___print_config_value "" "            GITTER_CONTINUE_ON_ERROR" "'${GITTER_CONTINUE_ON_ERROR}'"
  ___print_config_value "" "                  GITTER_REPO_STATUS" "'${GITTER_REPO_STATUS}'"
  echo
  echo -e "${GITTER_C__HEADING}Colors:${GITTER_C____RESET}"
  ___print_config_value "(${GITTER_C__SUCCESS}Success color ${GITTER_C____RESET})    " "GITTER_C__SUCCESS" "'\\${GITTER_C__SUCCESS}'"
  ___print_config_value "(${GITTER_C____ERROR}Error color   ${GITTER_C____RESET})    " "GITTER_C____ERROR" "'\\${GITTER_C____ERROR}'"
  ___print_config_value "(${GITTER_C_____REPO}Path color    ${GITTER_C____RESET})    " "GITTER_C_____REPO" "'\\${GITTER_C_____REPO}'"
  ___print_config_value "(${GITTER_C_____PATH}Path Dim color${GITTER_C____RESET})    " "GITTER_C_____PATH" "'\\${GITTER_C_PATH_DM}'"
  ___print_config_value "(${GITTER_C______DIM}Dim color     ${GITTER_C____RESET})    " "GITTER_C______DIM" "'\\${GITTER_C______DIM}'"
  ___print_config_value "(${GITTER_C__HEADING}Heading color ${GITTER_C____RESET})    " "GITTER_C__HEADING" "'\\${GITTER_C__HEADING}'"
  ___print_config_value "(${GITTER_C__COMMAND}Command color ${GITTER_C____RESET})    " "GITTER_C__COMMAND" "'\\${GITTER_C__COMMAND}'"
  ___print_config_value "(${GITTER_C______ARG}Argument color${GITTER_C____RESET})    " "GITTER_C______ARG" "'\\${GITTER_C______ARG}'"
  ___print_config_value "(${GITTER_C___OPTION}Option color  ${GITTER_C____RESET})    " "GITTER_C___OPTION" "'\\${GITTER_C___OPTION}'"
  ___print_config_value "(${GITTER_C____VALUE}Value color   ${GITTER_C____RESET})    " "GITTER_C____VALUE" "'\\${GITTER_C____VALUE}'"
  echo
}