<!--
  Copyright (C) Indrajit Roy <eendroroy@gmail.com>

  SPDX-License-Identifier: AGPL-3.0-or-later

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as
  published by the Free Software Foundation, either version 3 of the
  License, or (at your option) any later version.
-->

# gitter

Run git or arbitrary command in multiple git repositories with filters in current directory

## Installation

Clone the repository:

```bash
git clone https://github.com/eendroroy/gitter.git ~/.gitter
```

Add below line to your shell configuration file (`~/.bashrc`, `~/.zshrc`, etc.):

```shell
export PATH="$HOME/.gitter/bin:$PATH"
export fpath=("${fpath[@]}" "${HOME}/.gitter/completions")
```

## Usage

```shell
gitter [--<option> ...] [git -- <args ...>|exec -- <args ...>|list|help]
```

Run `gitter help` for details.

## Configuration

```shell
# Configuration variables for gitter
export GITTER_MAX_DEPTH=2              # Maximum directory depth to search for git repositories (default: 2)
export GITTER_SUCCESS_SYMBOL=" ░"      # Symbol to indicate success status
export GITTER___ERROR_SYMBOL=" ░"      # Symbol to indicate error status
export GITTER_PRIMARY_SYMBOL=" ━"      # Symbol to indicate primary information

# Arg defaults
export GITTER_FILTERS=()               # Default empty filters
export GITTER_VERBOSE=false            # Disable verbose mode by default
export GITTER_FILTER_EXCLUDE=false     # Do not exclude matched repositories by default
export GITTER_NO_COLOR=false           # Enable colored output by default

# Color configuration
export GITTER_C____PATH='\e[35m'       # Path color
export GITTER_C_PATH_DM='\e[2;35m'     # Dimmed path color
export GITTER_C_COMMAND='\e[32m'       # Command color
export GITTER_C____ARGS='\e[33m'       # Arguments color
export GITTER_C__OPTION='\e[36m'       # Option color
export GITTER_C___VALUE='\e[2;35;1;3m' # Value color
export GITTER_C_____DIM='\e[2;38;5;3m' # Dim color
export GITTER_C_SUCCESS='\e[38;5;2m'   # Success color
export GITTER_C___ERROR='\e[38;5;9m'   # Error color
export GITTER_C_HEADING='\e[1;37m'     # Heading color
```

## Repository status patterns

When running git commands, gitter will display the repository status based on the configured patterns. The default
patterns are as follows:

```shell
# gitter list | gitter ll
export GITTER_REPO_STATUS=(" on " "[branch]") # default pattern

# gitter list --verbose | gitter ll
export GITTER_REPO_STATUS_VERBOSE=(" on " "[branch]" " " "[commit:a]" " by " "[author:e]" " " "[time:r]")  # default pattern
```

#### Available placeholders for patterns

- `[branch]`   : Current git branch name
- `[commit:a]` : Abbreviated (8) current git commit hash
- `[commit:f]` : Full current git commit hash
- `[time:r]`   : Relative time of the current git commit (e.g., "2 days ago")
- `[time:d]`   : Date and time of the current git commit (e.g., "2024-01-01 12:00:00")
- `[author:e]` : Current git commit author email
- `[author:n]` : Current git commit author name

## Filters

Filters allow you to include or exclude repositories based on specific criteria such as path, repository name, 
or branch name. You can use multiple filters to narrow down the selection of repositories.

#### Filter Format

`<prefix><:>[+]<pattern>[+]`

#### Prefixes

- `path`  : Match for path name
- `repo`  : Match for repository name
- `branch`: Match for current git branch

#### Patterns

- `+pattern+`: Matches substring anywhere in the value
- `pattern+` : Matches the beginning of the value
- `+pattern` : Matches the end of the value
- `pattern`  : Matches exactly the value

#### Examples

- `-f repo:+lib+`                : Includes repositories with "lib" anywhere in the repository name.
- `-f path:src+`                 : Includes repositories with paths starting with "src".
- `-f branch:feature/+`          : Includes repositories currently on branches starting with "feature/".
- `-f branch:main`               : Includes repositories currently on the "main" branch.
- `-e -f repo:+test+`            : Excludes repositories with "test" anywhere in the repository name.
- `-f path:+utils+ -f branch:dev`: Includes repositories with "utils" in the path or currently on the "dev" branch.

## .gitterignore

You can create a `.gitterignore` file in the current directory to specify repositories that should be ignored by
`gitter`. Each line in the file should contain a pattern to match repository names or paths. Lines starting with `#` are
treated as comments and ignored.

#### Patterns

- `relative/path/to/directory`: Ignore directory at exact relative path `relative/path/to/directory`
- `*/directory_name`          : Ignore directories under any parent directory named `directory_name`
- `directory_name/*`          : Ignore directories directly under the top-level directory named `directory_name`

## Argument expansion

Within `exec` and `git` commands, you can use the following placeholders in arguments:

- `{_repo_}`        : Name of the current git repository
- `{_path:r_}`      : Relative path of the current working directory from where gitter was invoked
- `{_path:a_}`      : Absolute path of the current working directory
- `{_branch_}`      : Current git branch name
- `{_commit:f_}`    : Current git commit hash
- `{_commit:[int]_}`: Current git commit hash abbreviated to `[int]` characters. i.e. `{_commit:8_}`
- `{_time:r_}`      : Relative time of the current git commit (e.g., "2 days ago")
- `{_time:d_}`      : Date and time of the current git commit (e.g., "2024-01-01 12:00:00")
- `{_author:e_}`    : Current git commit author email
- `{_author:n_}`    : Current git commit author name

## License

The project is available as open source under the terms of
the [AGPL3 License](https://www.fsf.org/licensing/licenses/agpl.html).
