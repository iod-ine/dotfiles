# dotfiles

<details>
<summary><h4>macOS</h4></summary>

Tools:
- [Homebrew](https://github.com/Homebrew/brew)
- [WezTerm](https://github.com/wez/wezterm)
- [fish](https://github.com/fish-shell/fish-shell)
- [Neovim](https://github.com/neovim/neovim)
- [AeroSpace](https://github.com/nikitabobko/AeroSpace)
- [Raycast](https://www.raycast.com/)
- [tmux](https://github.com/tmux/tmux)
- [uv](https://github.com/astral-sh/uv)
  - [Python LSP Server](https://github.com/python-lsp/python-lsp-server)
  - [Ruff](https://github.com/astral-sh/ruff)
  - [JupyterLab](https://github.com/jupyterlab/jupyterlab)
    - [jupyterlab-code-formatter](https://github.com/ryantam626/jupyterlab_code_formatter)
    - [jupyterlab-git](https://github.com/jupyterlab/jupyterlab-git)
    - [jupyterlab-vim](https://github.com/jupyterlab-contrib/jupyterlab-vim)
    - [jupyterlab-lsp](https://github.com/jupyter-lsp/jupyterlab-lsp)
    - ```shell
      uv tool install jupyterlab --with jupyterlab-code-formatter --with jupyterlab-git --with jupyterlab-vim --with jupyterlab-lsp
      ```
  - [nbdime](https://github.com/jupyter/nbdime)
- [tldr](https://github.com/tldr-pages/tldr)
- [zoxide](https://github.com/ajeetdsouza/zoxide)

Language servers:
- [ltex-ls](https://github.com/valentjn/ltex-ls)
- [lua-language-server](https://github.com/LuaLS/lua-language-server)
- [ccls](https://github.com/MaskRay/ccls)

<details>
<summary><h5>Hall of Fame</h5></summary>

Things I no longer use but that paved the way for the current setup.

- [Alacritty](https://github.com/alacritty/alacritty)
- [Alfred](https://www.alfredapp.com/)
- [Amethyst](https://github.com/ianyh/Amethyst)
- [miniconda](https://docs.anaconda.com/free/miniconda/)
- [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh)
- [Oh My Bash](https://github.com/ohmybash/oh-my-bash)
- [pdm](https://github.com/pdm-project/pdm)
- [pipx](https://github.com/pypa/pipx)
- [Poetry](https://github.com/python-poetry/poetry)
- [pyenv](https://github.com/pyenv/pyenv)
- [python-lsp-ruff](https://github.com/python-lsp/python-lsp-ruff)

</details>

</details>

### Git configs

```
git config --global diff.tool nvimdiff
git config --global merge.tool nvimdiff2
git config --global alias.logg 'log --oneline --graph --all'
git config --global rerere.enabled true

ln -sf (fd --type dir diff-highlight /opt/homebrew/Cellar/git/)diff-highlight ~/.local/bin/diff-highlight
git config --global pager.diff "diff-highlight | less"
git config --global pager.log  "diff-highlight | less"
git config --global pager.show "diff-highlight | less"
```
