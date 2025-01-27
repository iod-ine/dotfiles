fish_add_path "/Users/ivandubrovin/.local/bin"

set -g fish_key_bindings fish_vi_key_bindings

set __fish_git_prompt_show_informative_status 1

set EDITOR nvim

abbr --add gds git diff --staged

zoxide init fish | source
