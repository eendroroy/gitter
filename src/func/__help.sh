#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

# shellcheck disable=SC2154
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
  echo -e "  ${GITTER_C___OPTION}--status            -s ${GITTER_C____RESET}<${GITTER_C____VALUE}status${GITTER_C____RESET}>${GITTER_C____RESET}  Set repository status format (overrides ${GITTER_C__COMMAND}GITTER_REPO_STATUS${GITTER_C____RESET} variable)"
  echo -e "  ${GITTER_C___OPTION}--max-depth         -d ${GITTER_C____RESET}<${GITTER_C____VALUE}depth${GITTER_C____RESET}>${GITTER_C____RESET}   Look for git repositories up to specified depth (default: ${GITTER_C______ARG}2${GITTER_C____RESET})"
  echo -e "  ${GITTER_C___OPTION}--filter            -f ${GITTER_C____RESET}<${GITTER_C____VALUE}pattern${GITTER_C____RESET}>${GITTER_C____RESET} Filter repositories matching the given pattern"
  echo -e "  ${GITTER_C___OPTION}--ask-confirmation  -a          ${GITTER_C____RESET} Ask for confirmation before executing commands in each repository"
  echo -e "  ${GITTER_C___OPTION}--continue-on-error -c          ${GITTER_C____RESET} Continue executing commands in other repositories even if an error occurs in one"
  echo -e "  ${GITTER_C___OPTION}--no-color                      ${GITTER_C____RESET} Disable colored output"
  echo -e "  ${GITTER_C___OPTION}--dry-run           -n          ${GITTER_C____RESET} Show what would be executed without actually running the commands"
  echo
  echo -e "${GITTER_C__HEADING}Commands:${GITTER_C____RESET}"
  echo -e "  ${GITTER_C___OPTION}git     g ${GITTER_C____RESET}        Run a git command (${GITTER_C______ARG}default${GITTER_C____RESET})"
  echo -e "  ${GITTER_C___OPTION}exec    x ${GITTER_C____RESET}        Run an arbitrary command"
  echo -e "  ${GITTER_C___OPTION}eval    e ${GITTER_C____RESET}        Evaluate a shell command - useful for complex commands involving pipes and redirections"
  echo -e "  ${GITTER_C___OPTION}bash    b ${GITTER_C____RESET}        Execute a bash script file"
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
  echo -e  "Gitter supports filters using bash expression evaluation format"
  echo -e  "For example: \"( ${GITTER_C____VALUE}filter1${GITTER_C____RESET} && ${GITTER_C____VALUE}filter2${GITTER_C____RESET} ) || ! ${GITTER_C____VALUE}filter3${GITTER_C____RESET}\""
  echo
  echo -e  "${GITTER_C__HEADING}Syntax:${GITTER_C____RESET}"
  echo -ne "  ${GITTER_C______DIM}<${GITTER_C____RESET}${GITTER_C____ERROR}prefix${GITTER_C____RESET}${GITTER_C______DIM}>${GITTER_C____RESET}"
  echo -ne "${GITTER_C______DIM}<${GITTER_C____RESET}${GITTER_C__HEADING}:${GITTER_C____RESET}${GITTER_C______DIM}>${GITTER_C____RESET}"
  echo  -e "${GITTER_C______DIM}<${GITTER_C____RESET}${GITTER_C____VALUE}value${GITTER_C____RESET}${GITTER_C______DIM}>${GITTER_C____RESET}"
  echo
  echo -e "${GITTER_C__HEADING}Prefixes:${GITTER_C____RESET}"
  echo -e "  ${GITTER_C____ERROR}path  ${GITTER_C____RESET}  [substr]   Match for path name"
  echo -e "  ${GITTER_C____ERROR}repo  ${GITTER_C____RESET}  [substr]   Match for repository name"
  echo -e "  ${GITTER_C____ERROR}branch${GITTER_C____RESET}  [substr]   Match for current git branch"
  echo -e "  ${GITTER_C____ERROR}remote${GITTER_C____RESET}  [substr]   Match for remote name (e.g., origin)"
  echo -e "  ${GITTER_C____ERROR}dirty ${GITTER_C____RESET}  [boolean]  Match for dirty state (default: ${GITTER_C______ARG}true${GITTER_C____RESET}. Use value ${GITTER_C____VALUE}false${GITTER_C____RESET} to match clean repositories)"
  echo -e "  ${GITTER_C____ERROR}stale ${GITTER_C____RESET}  [temporal] Match for stale repositories (supports duration format - e.g., ${GITTER_C____VALUE}7d${GITTER_C____RESET}, ${GITTER_C____VALUE}12h${GITTER_C____RESET}, ${GITTER_C____VALUE}30m${GITTER_C____RESET})"
  echo -e "  ${GITTER_C____ERROR}active${GITTER_C____RESET}  [temporal] Match for repositories with activity in current branch (supports duration format - e.g., ${GITTER_C____VALUE}7d${GITTER_C____RESET}, ${GITTER_C____VALUE}12h${GITTER_C____RESET}, ${GITTER_C____VALUE}30m${GITTER_C____RESET})"
  echo -e "  ${GITTER_C____ERROR}type  ${GITTER_C____RESET}  [full]     Match for project type (supports exact match only - ${GITTER_C____ERROR}type${GITTER_C____RESET}${GITTER_C__HEADING}:${GITTER_C____RESET}${GITTER_C____VALUE}project_type${GITTER_C____RESET})"
  echo
  echo -e "${GITTER_C__HEADING}'substr' Format:${GITTER_C____RESET}"
  echo -e "  ${GITTER_C____ERROR}+${GITTER_C____RESET}          Matches anywhere in the value (default if no anchors specified)"
  echo -e "   ${GITTER_C____VALUE}pattern${GITTER_C____RESET}${GITTER_C____ERROR}+${GITTER_C____RESET}  Matches the beginning of the value"
  echo -e "  ${GITTER_C____ERROR}+${GITTER_C____RESET}${GITTER_C____VALUE}pattern${GITTER_C____RESET}   Matches the end of the value"
  echo -e "  ${GITTER_C____ERROR}+${GITTER_C____RESET}${GITTER_C____VALUE}pattern${GITTER_C____RESET}${GITTER_C____ERROR}+${GITTER_C____RESET}  Matches substring anywhere in the value"
  echo -e "   ${GITTER_C____VALUE}pattern${GITTER_C____RESET}   Matches exactly the value"
  echo
  echo -e "${GITTER_C__HEADING}'temporal' Format:${GITTER_C____RESET}"
  echo -ne "  < <${GITTER_C____VALUE}Years${GITTER_C____RESET}>${GITTER_C____ERROR}y${GITTER_C____RESET}"
  echo -ne " | <${GITTER_C____VALUE}Months${GITTER_C____RESET}>${GITTER_C____ERROR}mo${GITTER_C____RESET}"
  echo -ne " | <${GITTER_C____VALUE}Weeks${GITTER_C____RESET}>${GITTER_C____ERROR}w${GITTER_C____RESET}"
  echo -ne " | <${GITTER_C____VALUE}Days${GITTER_C____RESET}>${GITTER_C____ERROR}d${GITTER_C____RESET}"
  echo -ne " | <${GITTER_C____VALUE}Hours${GITTER_C____RESET}>${GITTER_C____ERROR}h${GITTER_C____RESET}"
  echo -ne " | <${GITTER_C____VALUE}Minutes${GITTER_C____RESET}>${GITTER_C____ERROR}m${GITTER_C____RESET}"
  echo  -e " | <${GITTER_C____VALUE}Seconds${GITTER_C____RESET}>${GITTER_C____ERROR}s${GITTER_C____RESET} ...>"
  echo
  echo -e  "  Example:"
  echo -ne "    ${GITTER_C____VALUE}1${GITTER_C____RESET}${GITTER_C____ERROR}y${GITTER_C____RESET}"
  echo -ne "${GITTER_C____VALUE}6${GITTER_C____RESET}${GITTER_C____ERROR}mo${GITTER_C____RESET}"
  echo -e  "  1 year and 6 months"
  echo -ne  "    ${GITTER_C____VALUE}2${GITTER_C____RESET}${GITTER_C____ERROR}w${GITTER_C____RESET}"
  echo -ne "${GITTER_C____VALUE}3${GITTER_C____RESET}${GITTER_C____ERROR}d${GITTER_C____RESET}"
  echo -e  "   2 weeks and 3 days"
  echo -ne  "    ${GITTER_C____VALUE}1${GITTER_C____RESET}${GITTER_C____ERROR}d${GITTER_C____RESET}"
  echo -ne "${GITTER_C____VALUE}12${GITTER_C____RESET}${GITTER_C____ERROR}h${GITTER_C____RESET}"
  echo -e  "  1 day and 12 hours"
  echo
  echo -e "${GITTER_C__HEADING}'temporal' Unit Conversion Table:${GITTER_C____RESET}"
  echo
  echo -e "  ${GITTER_C____ERROR}  Unit ${GITTER_C____RESET}|${GITTER_C____ERROR} mo ${GITTER_C____RESET}|${GITTER_C____ERROR}  w ${GITTER_C____RESET}| ${GITTER_C____ERROR}  d ${GITTER_C____RESET}| ${GITTER_C____ERROR}    h ${GITTER_C____RESET}| ${GITTER_C____ERROR}      m ${GITTER_C____RESET}| ${GITTER_C____ERROR}         s${GITTER_C____RESET}"
  echo -e "  -------|----|----|-----|-------|---------|-----------"
  echo -e "  ${GITTER_C____ERROR}1 y  ${GITTER_C____RESET}= |${GITTER_C____VALUE} 12 ${GITTER_C____RESET}|${GITTER_C____VALUE} 52 ${GITTER_C____RESET}|${GITTER_C____VALUE} 365 ${GITTER_C____RESET}|${GITTER_C____VALUE} 8,760 ${GITTER_C____RESET}|${GITTER_C____VALUE} 525,600 ${GITTER_C____RESET}|${GITTER_C____VALUE} 31,536,000${GITTER_C____RESET}"
  echo -e "  ${GITTER_C____ERROR}1 mo ${GITTER_C____RESET}= |${GITTER_C____VALUE}    ${GITTER_C____RESET}|${GITTER_C____VALUE}  4 ${GITTER_C____RESET}|${GITTER_C____VALUE}  30 ${GITTER_C____RESET}|${GITTER_C____VALUE}   720 ${GITTER_C____RESET}|${GITTER_C____VALUE}  43,200 ${GITTER_C____RESET}|${GITTER_C____VALUE}  2,592,000${GITTER_C____RESET}"
  echo -e "  ${GITTER_C____ERROR}1 w  ${GITTER_C____RESET}= |${GITTER_C____VALUE}    ${GITTER_C____RESET}|${GITTER_C____VALUE}    ${GITTER_C____RESET}|${GITTER_C____VALUE}   7 ${GITTER_C____RESET}|${GITTER_C____VALUE}   168 ${GITTER_C____RESET}|${GITTER_C____VALUE}  10,080 ${GITTER_C____RESET}|${GITTER_C____VALUE}    604,800${GITTER_C____RESET}"
  echo -e "  ${GITTER_C____ERROR}1 d  ${GITTER_C____RESET}= |${GITTER_C____VALUE}    ${GITTER_C____RESET}|${GITTER_C____VALUE}    ${GITTER_C____RESET}|${GITTER_C____VALUE}     ${GITTER_C____RESET}|${GITTER_C____VALUE}    24 ${GITTER_C____RESET}|${GITTER_C____VALUE}   1,440 ${GITTER_C____RESET}|${GITTER_C____VALUE}     86,400${GITTER_C____RESET}"
  echo -e "  ${GITTER_C____ERROR}1 h  ${GITTER_C____RESET}= |${GITTER_C____VALUE}    ${GITTER_C____RESET}|${GITTER_C____VALUE}    ${GITTER_C____RESET}|${GITTER_C____VALUE}     ${GITTER_C____RESET}|${GITTER_C____VALUE}       ${GITTER_C____RESET}|${GITTER_C____VALUE}      60 ${GITTER_C____RESET}|${GITTER_C____VALUE}      3,600${GITTER_C____RESET}"
  echo -e "  ${GITTER_C____ERROR}1 m  ${GITTER_C____RESET}= |${GITTER_C____VALUE}    ${GITTER_C____RESET}|${GITTER_C____VALUE}    ${GITTER_C____RESET}|${GITTER_C____VALUE}     ${GITTER_C____RESET}|${GITTER_C____VALUE}       ${GITTER_C____RESET}|${GITTER_C____VALUE}         ${GITTER_C____RESET}|${GITTER_C____VALUE}         60${GITTER_C____RESET}"
  echo
  echo -e "${GITTER_C__HEADING}Project Types:${GITTER_C____RESET}"
  echo -ne "  "
  local _type_ct=0
  for type in "${!_type_checks[@]}"; do
    echo -ne "${GITTER_C____ERROR}${type}${GITTER_C____RESET} "
    ((_type_ct++))
    if (( _type_ct % 8 == 0 )); then
      echo
      echo -ne "  "
    fi
  done
  echo
  echo
  echo -e "${GITTER_C__HEADING}Examples:${GITTER_C____RESET}"
  echo -e "  ${GITTER_C__COMMAND}gitter ${GITTER_C___OPTION}--filter${GITTER_C____RESET} \"${GITTER_C____VALUE}path:src/+${GITTER_C____RESET}\"         Filter repositories with path starting with 'src/'"
  echo -e "  ${GITTER_C__COMMAND}gitter ${GITTER_C___OPTION}--filter${GITTER_C____RESET} \"${GITTER_C____VALUE}! repo:+-test${GITTER_C____RESET}\"      Filter repositories with name not ending with '-test'"
  echo -e "  ${GITTER_C__COMMAND}gitter ${GITTER_C___OPTION}--filter${GITTER_C____RESET} \"${GITTER_C____VALUE}branch:master${GITTER_C____RESET}\"      Filter repositories on branch 'master'"
  echo -e "  ${GITTER_C__COMMAND}gitter ${GITTER_C___OPTION}--filter${GITTER_C____RESET} \"${GITTER_C____VALUE}(path:+src/ || path:+test) & ! branch:hotfix/${GITTER_C____RESET}\""
  echo -e "                                       Filter repositories with path containing 'src/' or 'test' and not on any hotfix/ branch"
  echo -e "  ${GITTER_C__COMMAND}gitter ${GITTER_C___OPTION}--filter${GITTER_C____RESET} \"${GITTER_C____VALUE}(type:nodejs || type:gradle)${GITTER_C____RESET}\""
  echo -e "                                       Filter repositories which are either Node.js or Gradle projects"
  echo -e "  ${GITTER_C__COMMAND}gitter ${GITTER_C___OPTION}--filter${GITTER_C____RESET} \"${GITTER_C____VALUE}dirty && stale:7d${GITTER_C____RESET}\"  Filter repositories which are dirty and not updated in last 7 days"
  echo
}

__help_gitterignore() {
  echo
  echo -e "Gitter will look for a ${GITTER_C____VALUE}.gitterignore${GITTER_C____RESET} file ${GITTER_C______ARG}in the current directory.${GITTER_C____RESET}"
  echo -e "If found, it will read patterns from the file to ignore matching repositories."
  echo -e "Each line in the file should contain a pattern to match repository names or paths."
  echo -e "Lines starting with ${GITTER_C____ERROR}#${GITTER_C____RESET} are treated as comments and ignored."
  echo
  echo -e "${GITTER_C__HEADING}Patterns:${GITTER_C____RESET}"
  echo -e "  ${GITTER_C____ERROR}relative/path/to/directory${GITTER_C____RESET} Ignore directory at exact relative path ${GITTER_C_____REPO}relative/path/to/directory${GITTER_C____RESET}"
  echo -e "  ${GITTER_C____ERROR}*/directory_name${GITTER_C____RESET}           Ignore directories under any parent directory named ${GITTER_C_____REPO}directory_name${GITTER_C____RESET}"
  echo -e "  ${GITTER_C____ERROR}directory_name/*${GITTER_C____RESET}           Ignore directories directly under the top-level directory named ${GITTER_C_____REPO}directory_name${GITTER_C____RESET}"
  echo
}

__help_expander() {
  echo
  echo -e "Within ${GITTER_C___OPTION}exec${GITTER_C____RESET} and ${GITTER_C___OPTION}git${GITTER_C____RESET} commands, the following expanders can be used in arguments:"
  echo
  echo -e "  ${GITTER_C______ARG}{_repo_}      ${GITTER_C____RESET} Name of the current git repository"
  echo -e "  ${GITTER_C______ARG}{_path:r_}    ${GITTER_C____RESET} Relative path of the current working directory from where gitter was invoked"
  echo -e "  ${GITTER_C______ARG}{_path:a_}    ${GITTER_C____RESET} Absolute path of the current working directory"
  echo -e "  ${GITTER_C______ARG}{_branch_}    ${GITTER_C____RESET} Current git branch name"
  echo -e "  ${GITTER_C______ARG}{_commit:f_}  ${GITTER_C____RESET} Current git commit hash"
  echo -e "  ${GITTER_C______ARG}{_commit:<n>_}${GITTER_C____RESET} Current git commit hash abbreviated to <n> characters. i.e. ${GITTER_C______ARG}{_commit:8_}${GITTER_C____RESET}"
  echo -e "  ${GITTER_C______ARG}{_commit:c_}  ${GITTER_C____RESET} Current git commit count"
  echo -e "  ${GITTER_C______ARG}{_author:e_}  ${GITTER_C____RESET} Current git commit author email"
  echo -e "  ${GITTER_C______ARG}{_author:n_}  ${GITTER_C____RESET} Current git commit author name"
  echo -e "  ${GITTER_C______ARG}{_time:r_}    ${GITTER_C____RESET} Relative time of the current git commit (e.g., \"2 days ago\")"
  echo -e "  ${GITTER_C______ARG}{_time:d_}    ${GITTER_C____RESET} Date and time of the current git commit (e.g., \"2024-01-01 12:00:00\")"
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
  local separator="${GITTER_C______DIM}|${GITTER_C____RESET}"
  echo
  echo -e "Set ${GITTER_C__COMMAND}GITTER_REPO_STATUS${GITTER_C____RESET} variable or use ${GITTER_C___OPTION}--status${GITTER_C____RESET} option to define custom or predefined repository status format."
  echo
  echo -e "${GITTER_C__HEADING}Syntax:${GITTER_C____RESET}"
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
  echo -e "${GITTER_C__HEADING}Example:${GITTER_C____RESET}"
  echo -e "    ${GITTER_C__COMMAND}gitter${GITTER_C____RESET} ${GITTER_C___OPTION}list --status${GITTER_C____RESET} ${GITTER_C____VALUE}updated-by${GITTER_C____RESET}"
  echo -e "    ${GITTER_C__COMMAND}gitter${GITTER_C____RESET} ${GITTER_C___OPTION}list --status${GITTER_C____RESET} \"${GITTER_C____VALUE} on |[branch]${GITTER_C____RESET}\""
  echo
  echo -e "${GITTER_C__HEADING}Predefined patterns:${GITTER_C____RESET}"
  echo -e "    ${GITTER_C______ARG}default${GITTER_C____RESET}          \" ${GITTER_C____RESET}${separator}${GITTER_C______ARG}[branch]${GITTER_C____RESET}${separator} ${separator}${GITTER_C______ARG}[author:n]${GITTER_C____RESET}${separator} ${separator}${GITTER_C______ARG}[time:r]${GITTER_C____RESET}\""
  echo -e "    ${GITTER_C______ARG}branch${GITTER_C____RESET}           \"${GITTER_C______DIM} on ${GITTER_C____RESET}${separator}${GITTER_C______ARG}[branch]${GITTER_C____RESET}\""
  echo -e "    ${GITTER_C______ARG}updated${GITTER_C____RESET}          \"${GITTER_C______DIM} on ${GITTER_C____RESET}${separator}${GITTER_C______ARG}[branch]${GITTER_C____RESET}${separator} ${separator}${GITTER_C______ARG}[time:r]${GITTER_C____RESET}\""
  echo -e "    ${GITTER_C______ARG}updated-at${GITTER_C____RESET}       \"${GITTER_C______DIM} on ${GITTER_C____RESET}${separator}${GITTER_C______ARG}[branch]${GITTER_C____RESET}${separator} ${separator}${GITTER_C______ARG}[commit:8]${GITTER_C____RESET}${separator}${GITTER_C______DIM} at ${GITTER_C____RESET}${separator}${GITTER_C______ARG}[time:d]${GITTER_C____RESET}\""
  echo -e "    ${GITTER_C______ARG}updated-by${GITTER_C____RESET}       \"${GITTER_C______DIM} on ${GITTER_C____RESET}${separator}${GITTER_C______ARG}[branch]${GITTER_C____RESET}${separator} ${separator}${GITTER_C______ARG}[commit:8]${GITTER_C____RESET}${separator}${GITTER_C______DIM} by ${GITTER_C____RESET}${separator}${GITTER_C______ARG}[author:e]${GITTER_C____RESET}${separator} ${separator}${GITTER_C______ARG}[time:r]${GITTER_C____RESET}\""
  echo -e "    ${GITTER_C______ARG}updated-by-at${GITTER_C____RESET}    \"${GITTER_C______DIM} on ${GITTER_C____RESET}${separator}${GITTER_C______ARG}[branch]${GITTER_C____RESET}${separator} ${separator}${GITTER_C______ARG}[commit:8]${GITTER_C____RESET}${separator}${GITTER_C______DIM} by ${GITTER_C____RESET}${separator}${GITTER_C______ARG}[author:e]${GITTER_C____RESET}${separator} ${GITTER_C______DIM}at${GITTER_C____RESET} ${separator}${GITTER_C______ARG}[time:d]${GITTER_C____RESET}\""
  echo -e "    ${GITTER_C______ARG}commit-count${GITTER_C____RESET}     \"${GITTER_C______DIM} (${GITTER_C____RESET}${separator}${GITTER_C______ARG}[commit:c]${GITTER_C____RESET}${separator} ${GITTER_C______DIM}commits) on ${GITTER_C____RESET}${separator}${GITTER_C______ARG}[branch]${GITTER_C____RESET}\""
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
  ___print_config_value "" "                     GITTER_NO_COLOR" "'${GITTER_NO_COLOR}'"
  ___print_config_value "" "             GITTER_ASK_CONFIRMATION" "'${GITTER_ASK_CONFIRMATION}'"
  ___print_config_value "" "            GITTER_CONTINUE_ON_ERROR" "'${GITTER_CONTINUE_ON_ERROR}'"
  ___print_config_value "" "                  GITTER_REPO_STATUS" "'${GITTER_REPO_STATUS}'"

  echo
  echo -e "${GITTER_C__HEADING}Colors:${GITTER_C____RESET}"
  ___print_config_value "(${GITTER_C__SUCCESS}Success color      ${GITTER_C____RESET})    " "GITTER_C__SUCCESS" "'\\${GITTER_C__SUCCESS}'"
  ___print_config_value "(${GITTER_C____ERROR}Error color        ${GITTER_C____RESET})    " "GITTER_C____ERROR" "'\\${GITTER_C____ERROR}'"
  ___print_config_value "(${GITTER_C_____REPO}Repository color   ${GITTER_C____RESET})    " "GITTER_C_____REPO" "'\\${GITTER_C_____REPO}'"
  ___print_config_value "(${GITTER_C_____PATH}Path color         ${GITTER_C____RESET})    " "GITTER_C_____PATH" "'\\${GITTER_C_____PATH}'"
  ___print_config_value "(${GITTER_C______DIM}Dim color          ${GITTER_C____RESET})    " "GITTER_C______DIM" "'\\${GITTER_C______DIM}'"
  ___print_config_value "(${GITTER_C__HEADING}Heading color      ${GITTER_C____RESET})    " "GITTER_C__HEADING" "'\\${GITTER_C__HEADING}'"
  ___print_config_value "(${GITTER_C__COMMAND}Command color      ${GITTER_C____RESET})    " "GITTER_C__COMMAND" "'\\${GITTER_C__COMMAND}'"
  ___print_config_value "(${GITTER_C______ARG}Argument color     ${GITTER_C____RESET})    " "GITTER_C______ARG" "'\\${GITTER_C______ARG}'"
  ___print_config_value "(${GITTER_C___OPTION}Option color       ${GITTER_C____RESET})    " "GITTER_C___OPTION" "'\\${GITTER_C___OPTION}'"
  ___print_config_value "(${GITTER_C____VALUE}Value color        ${GITTER_C____RESET})    " "GITTER_C____VALUE" "'\\${GITTER_C____VALUE}'"
  ___print_config_value "(${GITTER_C___BRANCH}Branch color       ${GITTER_C____RESET})    " "GITTER_C___BRANCH" "'\\${GITTER_C___BRANCH}'"
  ___print_config_value "(${GITTER_C___COMMIT}Commit color       ${GITTER_C____RESET})    " "GITTER_C___COMMIT" "'\\${GITTER_C___COMMIT}'"
  ___print_config_value "(${GITTER_C__COMMITS}Commit count color ${GITTER_C____RESET})    " "GITTER_C__COMMITS" "'\\${GITTER_C__COMMITS}'"
  ___print_config_value "(${GITTER_C_TIME_REL}Relative Time color${GITTER_C____RESET})    " "GITTER_C_TIME_REL" "'\\${GITTER_C_TIME_REL}'"
  ___print_config_value "(${GITTER_C_TIME_ABS}Absolute Time color${GITTER_C____RESET})    " "GITTER_C_TIME_ABS" "'\\${GITTER_C_TIME_ABS}'"
  ___print_config_value "(${GITTER_C_AUTHOR_E}Author Email color ${GITTER_C____RESET})    " "GITTER_C_AUTHOR_E" "'\\${GITTER_C_AUTHOR_E}'"
  ___print_config_value "(${GITTER_C_AUTHOR_N}Author Name color  ${GITTER_C____RESET})    " "GITTER_C_AUTHOR_N" "'\\${GITTER_C_AUTHOR_N}'"
  echo
}