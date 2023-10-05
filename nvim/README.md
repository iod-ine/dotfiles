- `init.lua` is the entry point for Neovim.
- `lua/` contains requireable Lua scripts.

Python LSP prerequisites:
```shell
pipx install "python-lsp-server[flake8,pylint]"
pipx runpip python-lsp-server install pyls-isort python-lsp-black
```
