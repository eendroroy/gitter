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

Add below line to your shell configuration file:

```shell
export PATH="$HOME/.gitter/bin:$PATH"

export fpath=("${fpath[@]}" "${HOME}/.gitter/completion/zsh") # ZSH Completion
source ~/.gitter/completion/bash/gitter.bash # Bash Completion
source ~/.gitter/completion/fish/gitter.fish # Fish Completion
```

## Usage

```shell
gitter  [--<option> ...] [command [-- <args ...>]]
```

Run `gitter help` for details.

## Configuration

```shell
# Configuration variables for gitter
export GITTER_SUCCESS_SYMBOL=" ░"      # Symbol to indicate success status
export GITTER___ERROR_SYMBOL=" ░"      # Symbol to indicate error status
export GITTER_PRIMARY_SYMBOL=" ━"      # Symbol to indicate primary information

# Arg defaults
export GITTER_MAX_DEPTH=2              # Maximum directory depth to search for git repositories (default: 2)
export GITTER_NO_COLOR=false           # Enable colored output by default
export GITTER_ASK_CONFIRMATION=false   # Proceed without asking for confirmation by default
export GITTER_CONTINUE_ON_ERROR=false  # ASk to continue on error by default

# Color configuration
export GITTER_C____ERROR='\e[38;5;9m'   # Error
export GITTER_C__SUCCESS='\e[38;5;2m'   # Success
export GITTER_C_____REPO='\e[35m'       # Repository name
export GITTER_C_____PATH='\e[2;35m'     # Path
export GITTER_C______DIM='\e[2;38;5;3m' # Dim text
export GITTER_C__HEADING='\e[1;37m'     # Heading
export GITTER_C__COMMAND='\e[32m'       # Command
export GITTER_C______ARG='\e[33m'       # Argument
export GITTER_C___OPTION='\e[36m'       # Option
export GITTER_C____VALUE='\e[2;35;1;3m' # Value

# Status colors
export GITTER_C___BRANCH='\e[32m'       # Branch
export GITTER_C___COMMIT='\e[2;35;1;3m' # Commit
export GITTER_C__COMMITS='\e[2;35;1;3m' # Commit count
export GITTER_C_TIME_REL='\e[33m'       # Relative time
export GITTER_C_TIME_ABS='\e[33m'       # Absolute time
export GITTER_C_AUTHOR_E='\e[36m'       # Author email
export GITTER_C_AUTHOR_N='\e[36m'       # Author name
```

## Repository status patterns

When running git commands, gitter will display the repository status based on the configured patterns.


#### Examples
- To customize the repository status pattern for `gitter list` command:

```shell
gitter list --status " on |[branch]| #|[commit:7]|(commits: |[commit:c]|) by |[author:e]| at |[time:d]"
```

- There are few predefined patterns are available as shortcuts:

```shell
gitter list --status branch        # " on |[branch]"
gitter list --status updated       # " on |[branch]| |[time:r]"
gitter list --status updated-at    # " on |[branch]| |[commit:8]| at |[time:d]"
gitter list --status updated-by    # " on |[branch]| |[commit:8]| by |[author:e]| |[time:r]"
gitter list --status updated-by-at # " on |[branch]| |[commit:8]| by |[author:e]| at |[time:d]"
gitter list --status commit-count  # " (|[commit:c]| commits)| on |[branch]"
```

The default patterns are as follows:

```shell
# gitter list | gitter ls
export GITTER_REPO_STATUS=" on |[branch]| |[commit:8]| by |[author:e]| |[time:r]" # default pattern
```

#### Available placeholders for repository status patterns

- `[type]      ` : Estimated project type (e.g., "maven", "nodejs", "python", etc.)
- `[branch]    ` : Current git branch name
- `[commit:a]  ` : Abbreviated (8) current git commit hash
- `[commit:f]  ` : Full current git commit hash
- `[commit:<n>]` : Current git commit hash abbreviated to `<n>` characters. e.g., `[commit:10]`
- `[time:r]    ` : Relative time of the current git commit (e.g., "2 days ago")
- `[time:d]    ` : Date and time of the current git commit (e.g., "2024-01-01 12:00:00")
- `[author:e]  ` : Current git commit author email
- `[author:n]  ` : Current git commit author name

## Filters

Filters allow you to include or exclude repositories based on specific criteria such as path, repository name,
or branch name. It supports bash expression evaluation format. 
For example: *`"( filter1 && filter2) || ! filter3"`*

#### Filter Format

`<prefix><:>[+]<pattern>[+]`

#### Prefixes

- `path  ` : Match for path name
- `repo  ` : Match for repository name
- `branch` : Match for current git branch
- `remote` : Match for remote name (e.g., origin)
- `type`   : Match for project type (supports exact match only - `type:<project_type>`)

#### Patterns

- `+pattern+` : Matches substring anywhere in the value
- ` pattern+` : Matches the beginning of the value
- `+pattern ` : Matches the end of the value
- ` pattern ` : Matches exactly the value

#### Project Types:

- `any`        : Any git repository (default)
- `android`    : Android project
- `angular`    : Angular project
- `angularjs`  : AngularJS project
- `bash`       : Bash script project
- `c`          : C project
- `cpp`        : C++ project
- `docker`     : Docker project
- `dotnet`     : .NET project
- `flutter`    : Flutter project
- `go`         : Go project
- `gradle`     : Gradle project
- `maven`      : Maven project
- `nextjs`     : Next.js project
- `nodejs`     : Node.js project
- `php`        : PHP project
- `python`     : Python project
- `react`      : React project
- `ruby`       : Ruby project
- `rust`       : Rust project
- `shell`      : Generic Shell scripts
- `springboot` : Spring Boot project
- `svelte`     : Svelte project
- `terraform`  : Terraform project
- `vue`        : Vue.js project
- `zsh`        : Zsh script project

#### Examples

- `-f "repo:+lib+"                ` : Includes repositories with "lib" anywhere in the repository name.
- `-f "path:src+"                 ` : Includes repositories with paths starting with "src".
- `-f "branch:feature/+"          ` : Includes repositories currently on branches starting with "feature/".
- `-f "branch:main"               ` : Includes repositories currently on the "main" branch.
- `-f "! repo:+test+"             ` : Excludes repositories with "test" anywhere in the repository name.
- `-f "path:+utils+ || branch:dev"` : Includes repositories with "utils" in the path or currently on the "dev" branch.

## .gitterignore

You can create a `.gitterignore` file in the current directory to specify repositories that should be ignored by
`gitter`. Each line in the file should contain a pattern to match repository names or paths.
Lines starting with `#` are treated as comments and ignored.

#### Patterns

- `relative/path/to/directory` : Ignore directory at exact relative path `relative/path/to/directory`
- `*/directory_name          ` : Ignore directories under any parent directory named `directory_name`
- `directory_name/*          ` : Ignore directories directly under the top-level directory named `directory_name`

## Argument expansion

Within `exec` and `git` commands, you can use the following expanders in arguments:

- `{_type_}      ` : Estimated project type (e.g., "maven", "nodejs", "python", etc.)
- `{_repo_}      ` : Name of the current git repository
- `{_path:r_}    ` : Relative path of the current working directory from where gitter was invoked
- `{_path:a_}    ` : Absolute path of the current working directory
- `{_branch_}    ` : Current git branch name
- `{_commit:f_}  ` : Current git commit hash
- `{_commit:<n>_}` : Current git commit hash abbreviated to `<n>` characters. i.e. `{_commit:8_}`
- `{_time:r_}    ` : Relative time of the current git commit (e.g., "2 days ago")
- `{_time:d_}    ` : Date and time of the current git commit (e.g., "2024-01-01 12:00:00")
- `{_author:e_}  ` : Current git commit author email
- `{_author:n_}  ` : Current git commit author name

## License

The project is available as open source under the terms of
the [AGPL3 License](https://www.fsf.org/licensing/licenses/agpl.html).
