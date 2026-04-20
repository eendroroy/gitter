# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

# PowerShell completion for gitter
# Add the following to your $PROFILE:
#   . ~/path/to/.gitter/completion/pwsh/gitter.ps1

Register-ArgumentCompleter -Native -CommandName gitter -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)

  $commands     = @('git','g','exec','x','eval','e','bash','b','list','ls','help','config','version','v')
  $options      = @('--status','-s','--max-depth','-d','--filter','-f',
                    '--ask-confirmation','-a','--continue-on-error','-c',
                    '--no-color','--dry-run','-n','--')
  $statuses     = @('default','branch','updated','updated-at','updated-by','updated-by-at','commit-count')
  $helpTopics   = @('filter','gitterignore','expander','status')

  $allTokens  = $commandAst.CommandElements
  $tokenCount = $allTokens.Count

  # Determine the token immediately before the cursor
  $prev = if ($tokenCount -ge 2) { $allTokens[$tokenCount - 2].ToString() } else { '' }

  # After --status / -s → complete status names
  if ($prev -in @('--status', '-s')) {
    return $statuses | Where-Object { $_ -like "$wordToComplete*" } |
      ForEach-Object { [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_) }
  }

  # After --max-depth / -d → no useful completions
  if ($prev -in @('--max-depth', '-d')) { return }

  # After --filter / -f → hint examples
  if ($prev -in @('--filter', '-f')) {
    $hints = @('repo:+name+','branch:main','dirty','stale:7d','active:1d')
    return $hints | Where-Object { $_ -like "$wordToComplete*" } |
      ForEach-Object { [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_) }
  }

  # Options
  if ($wordToComplete -like '-*') {
    return $options | Where-Object { $_ -like "$wordToComplete*" } |
      ForEach-Object { [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterName', $_) }
  }

  # First positional argument → subcommand
  $positional = $allTokens | Where-Object { -not $_.ToString().StartsWith('-') }
  if ($positional.Count -eq 1) {
    return $commands | Where-Object { $_ -like "$wordToComplete*" } |
      ForEach-Object { [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_) }
  }

  # Second positional after 'help' → help topics
  if ($positional.Count -eq 2 -and $positional[1].ToString() -eq 'help') {
    return $helpTopics | Where-Object { $_ -like "$wordToComplete*" } |
      ForEach-Object { [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_) }
  }
}

