# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

# Nushell completion for gitter
# Add the following to your env.nu or config.nu:
#   source ~/path/to/.gitter/completion/nushell/gitter.nu

def "nu-complete gitter commands" [] {
  [
    { value: "git",     description: "Run a git command (default)" },
    { value: "g",       description: "Run a git command (alias)" },
    { value: "exec",    description: "Run an arbitrary command" },
    { value: "x",       description: "Run an arbitrary command (alias)" },
    { value: "eval",    description: "Evaluate a shell command" },
    { value: "e",       description: "Evaluate a shell command (alias)" },
    { value: "bash",    description: "Execute a bash script file" },
    { value: "b",       description: "Execute a bash script file (alias)" },
    { value: "list",    description: "List repositories only" },
    { value: "ls",      description: "List repositories only (alias)" },
    { value: "help",    description: "Show help" },
    { value: "config",  description: "Print current configuration" },
    { value: "version", description: "Show version" },
    { value: "v",       description: "Show version (alias)" },
  ]
}

def "nu-complete gitter status" [] {
  [
    { value: "default",        description: " |[branch]| |[author:n]| |[time:r]" },
    { value: "branch",         description: " on |[branch]" },
    { value: "updated",        description: " on |[branch]| |[time:r]" },
    { value: "updated-at",     description: " on |[branch]| |[commit:8]| at |[time:d]" },
    { value: "updated-by",     description: " on |[branch]| |[commit:8]| by |[author:e]| |[time:r]" },
    { value: "updated-by-at",  description: " on |[branch]| |[commit:8]| by |[author:e]| at |[time:d]" },
    { value: "commit-count",   description: " (|[commit:c]| commits)| on |[branch]" },
  ]
}

def "nu-complete gitter help-topics" [] {
  [
    { value: "filter",       description: "Show help about filter patterns" },
    { value: "gitterignore", description: "Show help about .gitterignore file" },
    { value: "expander",     description: "Show help about available expanders" },
    { value: "status",       description: "Show help about status placeholders" },
  ]
}

# gitter — run git or arbitrary commands in multiple repositories
export extern "gitter" [
  subcommand?: string@"nu-complete gitter commands"  # Subcommand to run
  ...args: string                                     # Arguments forwarded to the subcommand
  --status(-s): string@"nu-complete gitter status"   # Custom status format
  --max-depth(-d): int                                # Max depth to search for git repos (default: 2)
  --filter(-f): string                                # Filter repositories (see 'gitter help filter')
  --ask-confirmation(-a)                              # Ask for confirmation before executing
  --continue-on-error(-c)                             # Continue executing even on errors
  --no-color                                          # Disable colored output
  --dry-run(-n)                                       # Show what would be done, without executing
]

export extern "gitter help" [
  topic?: string@"nu-complete gitter help-topics"    # Help topic
]

export extern "gitter git" [
  ...args: string                                     # git arguments
  --status(-s): string@"nu-complete gitter status"
  --max-depth(-d): int
  --filter(-f): string
  --ask-confirmation(-a)
  --continue-on-error(-c)
  --no-color
  --dry-run(-n)
]

export extern "gitter exec" [
  command: string                                     # Command to execute
  ...args: string
  --status(-s): string@"nu-complete gitter status"
  --max-depth(-d): int
  --filter(-f): string
  --ask-confirmation(-a)
  --continue-on-error(-c)
  --no-color
  --dry-run(-n)
]

export extern "gitter list" [
  --status(-s): string@"nu-complete gitter status"
  --max-depth(-d): int
  --filter(-f): string
  --no-color
]

export extern "gitter ls" [
  --status(-s): string@"nu-complete gitter status"
  --max-depth(-d): int
  --filter(-f): string
  --no-color
]

