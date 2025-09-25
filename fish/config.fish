fish_add_path "/Users/ivandubrovin/.local/bin"

set -g fish_key_bindings fish_vi_key_bindings

set __fish_git_prompt_show_informative_status 1

set EDITOR nvim

alias ya ~/arcadia/ya
alias vh3 "~/arcadia/ya tool vh3"
alias yt "~/arcadia/ya tool yt"

set -x YT_PROXY kolmogorov

zoxide init fish | source
