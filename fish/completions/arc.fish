complete -c arc -f

complete -c arc -n "__fish_use_subcommand" -a "checkout commit diff stash status"

complete -c arc -n "__fish_seen_subcommand_from checkout" -a "trunk"
complete -c arc -n "__fish_seen_subcommand_from diff" -l staged
complete -c arc -n "__fish_seen_subcommand_from stash" -a "push pop"
