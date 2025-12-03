# fish

# Basic command completions (no file completion)
complete -c gitter -f -a 'git g exec x list ls help config' -d 'gitter command'

# Options that take an argument
complete -c gitter -l status -s s -r -d 'Show repository status (takes pattern)'
complete -c gitter -l max-depth -s d -r -d 'Maximum directory depth'
complete -c gitter -l exclude -s e -r -d 'Exclude pattern'
# --filter / -f requires an argument; provide pattern-prefix suggestions
complete -c gitter -l filter -s f -r -a 'path:_path_ path:_path_+ path:+_path_ path:+_path_+ repo:_repo_ repo:_repo_+ repo:+_repo_ repo:+_repo_+ branch:_branch_ branch:_branch_+ branch:+_branch_ branch:+_branch_+' -d 'Filter pattern'

# Flag options
complete -c gitter -l ask-confirmation -s a -d 'Ask for confirmation'
complete -c gitter -l continue-on-error -s c -d 'Continue on error'
complete -c gitter -l quiet -s q -d 'Quiet mode'
complete -c gitter -l no-color -d 'Disable color output'
complete -c gitter -l dry-run -s n -d 'Dry run (no changes)'

# End-of-options marker
complete -c gitter -a '--' -d 'End of options'

# Help topics when first argument is `help`
complete -c gitter -n '__fish_seen_subcommand_from help' -a 'filter gitterignore expander status' -d 'Help topic'