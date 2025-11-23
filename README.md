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

Clone the repo:

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
Gitter
  Run git or arbitrary command in multiple git repositories with filters in current directory

Usage:
  gitter [--exclude] [--filter <pattern> ...] [--<option> ...] [git|exec|list|help] [-- <args ...>]

Commands:
  git   g       Run a git command (default)
  exec  x       Run an arbitrary command
  list  ls      List repositories only
        lb      List repositories with branch name
        ll      Equivalent to list --verbose command
  help          Show this help menu

Options:
  --filter   -f <pattern>  Match repo directory name exactly
  --exclude  -e            Exclude matched repositories instead of including
  --verbose  -v            Enable verbose mode
  --no-color               Disable colored output

Filers:
  <prefix><:>[+]<pattern>[+]

  Prefixes:
    path   P   Match for path name
    repo   R   Match for repo name
    branch B   Match for current git branch

  Patterns:
    +          Matches anywhere in the value (default if no anchors specified)
     pattern+  Matches the beginning of the value
    +pattern   Matches the end of the value
    +pattern+  Matches substring anywhere in the value
     pattern   Matches exactly the value

Ignore-file:
  Gitter will look for a .gitterignore file in the current directory.
  If found, it will read patterns from the file to ignore matching repositories.
  Each line in the file should contain a pattern to match repository names or paths.
  Lines starting with # are treated as comments and ignored.
  Patterns:
    relative/path/to/directory - Ignore directory at exact relative path relative/path/to/directory
    */directory_name           - Ignore directories under any parent directory named directory_name
    directory_name/*           - Ignore directories directly under the top-level directory named directory_name

Placeholders:
  Within exec and git commands, the following placeholders can be used in arguments:
    {_repo_}         - Name of the current git repository
    {_path_}         - Relative path of the current working directory from where gitter was invoked
    {_path:abs_}     - Absolute path of the current working directory
    {_branch_}       - Current git branch name
    {_commit_}       - Current git commit hash
    {_commit:[int]_} - Current git commit hash abbreviated to [int] characters. i.e. {_commit:8_}
    {_author_}       - Current git commit author email
```

## License

The project is available as open source under the terms of the [AGPL3 License](https://www.fsf.org/licensing/licenses/agpl.html).
