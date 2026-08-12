complete -c arc -f

complete -c arc -n "__fish_use_subcommand" -a "add branch checkout commit diff log mv pull push rebase stash status"

complete -c arc -n "__fish_seen_subcommand_from add" -F
complete -c arc -n "__fish_seen_subcommand_from branch" -a "(arc branch | sed -e 's/* //' -e 's/  //')"
complete -c arc -n "__fish_seen_subcommand_from checkout" -a "(arc branch | sed -e 's/* //' -e 's/  //'; arc diff --relative=. --name-only)"
complete -c arc -n "__fish_seen_subcommand_from diff" -l "staged"
complete -c arc -n "__fish_seen_subcommand_from log" -F -a "(arc branch | sed -e 's/* //' -e 's/  //')"
complete -c arc -n "__fish_seen_subcommand_from mv" -F
complete -c arc -n "__fish_seen_subcommand_from rebase" -a "trunk"
complete -c arc -n "__fish_seen_subcommand_from rebase" -l "abort" -l "continue"
complete -c arc -n "__fish_seen_subcommand_from stash" -a "push pop"
