# fish

set -l gitter_status_fields 'branch updated updated-at updated-by updated-by-at commit-count'

# Basic command completions (no file completion)
complete -c gitter -f -a 'git g exec x list ls help config' -d 'gitter command'

complete -c gitter -l max-depth         -s d -r -d 'Maximum directory depth'
complete -c gitter -l filter            -s f -r -d 'Filter pattern (Run 'gitter help filter' for details)'
complete -c gitter -l status            -s s -r -d 'Show repository status (takes pattern)'  -a $gitter_status_fields
complete -c gitter -l processable       -s f    -d 'Processable output'
complete -c gitter -l ask-confirmation  -s a    -d 'Ask for confirmation'
complete -c gitter -l continue-on-error -s c    -d 'Continue on error'
complete -c gitter -l no-color                  -d 'Disable color output'
complete -c gitter -l dry-run           -s n    -d 'Dry run (no changes)'

# End-of-options marker
complete -c gitter -a '--' -d 'End of options'

# Help topics when first argument is `help`
complete -c gitter -n '__fish_seen_subcommand_from help' -a 'filter gitterignore expander status' -d 'Help topic'