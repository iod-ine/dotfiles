.PHONY: help
help:
	@echo "Available commands:"
	@echo "  nvim: fetch and configure Neovim"
	@echo "  opencode: fetch and configure OpenCode"
	@echo "  codex: fetch and configure Codex"

.PHONY: config-directory
config-directory: $(HOME)/.config
$(HOME)/.config:
	mkdir -p $(HOME)/.config

.PHONY: bin-directory
bin-directory: $(HOME)/.local/bin
$(HOME)/.local/bin:
	mkdir -p $(HOME)/.local/bin

# ---------------------------------------------------------------------------------------
# Targets for fetching and configuring tools
# The fetching part is only for Linux machines. Homebrew handles the fetching for macOS.
# ---------------------------------------------------------------------------------------

.PHONY: nvim nvim-fetch nvim-configure
nvim: nvim-fetch nvim-configure ripgrep-fetch fzf-fetch
nvim-configure: config-directory
	rm -rf $(HOME)/.config/nvim && ln -sf $(CURDIR)/nvim $(HOME)/.config/nvim
nvim-fetch: bin-directory $(HOME)/.local/bin/nvim
$(HOME)/.local/bin/nvim:
	mkdir -p /tmp/nvim
	wget -O /tmp/nvim/nvim.tgz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	tar xf /tmp/nvim/nvim.tgz -C $(HOME)/.local/bin
	ln -s $(HOME)/.local/bin/nvim-linux-x86_64/bin/nvim $(HOME)/.local/bin/nvim

.PHONY: opencode opencode-fetch opencode-configure
opencode: opencode-fetch opencode-configure
opencode-fetch: $(HOME)/.opencode/bin/opencode
$(HOME)/.opencode/bin/opencode:
	curl -fsSL https://opencode.ai/install | bash
# OpenCode keeps things in its config directory that I don't need in my repository, so
# don't link the whole folder, only individual files.
opencode-configure:
	mkdir -p $(HOME)/.config/opencode
	ln -sf $(CURDIR)/AGENTS.md $(HOME)/.config/opencode/
	ln -sf $(CURDIR)/opencode/opencode.json $(HOME)/.config/opencode/
	ln -sf $(CURDIR)/opencode/tui.json $(HOME)/.config/opencode/

.PHONY: codex codex-fetch codex-configure
codex: codex-fetch codex-configure
codex-fetch: $(HOME)/.local/bin/codex
$(HOME)/.local/bin/codex:
	curl -fsSL https://chatgpt.com/codex/install.sh | sh
# Codex also keeps a bunch of stuff in its config directory, so only link individual files.
codex-configure:
	mkdir -p $(HOME)/.codex
	ln -sf $(CURDIR)/AGENTS.md $(HOME)/.codex/AGENTS.md

.PHONY: oh-my-bash oh-my-bash-fetch oh-my-bash-configure oh-my-bash-completions
oh-my-bash: oh-my-bash-fetch oh-my-bash-configure
oh-my-bash-fetch: $(HOME)/.oh-my-bash
$(HOME)/.oh-my-bash:
	bash -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
oh-my-bash-configure:
	ln -sf $(CURDIR)/.bashrc $(HOME)/.bashrc
	ln -sf $(CURDIR)/oh-my-bash/functions/*.sh $(HOME)/.oh-my-bash/custom/
oh-my-bash-completions: $(HOME)/.oh-my-bash/custom/completions/arc.completion.sh
oh-my-bash-completions: $(HOME)/.oh-my-bash/custom/completions/wezterm.completion.sh
oh-my-bash-completions: $(HOME)/.oh-my-bash/custom/completions/ya.completion.sh
$(HOME)/.oh-my-bash/custom/completions/arc.completion.sh:
	arc completion bash >| $(HOME)/.oh-my-bash/custom/completions/arc.completion.sh
$(HOME)/.oh-my-bash/custom/completions/wezterm.completion.sh:
	@if command -v wezterm > /dev/null 2>&1; then \
		wezterm shell-completion --shell bash >| ~/.oh-my-bash/custom/completions/wezterm.completion.sh; \
	else \
		echo "Wezterm not installed, skipping completions."; \
	fi
$(HOME)/.oh-my-bash/custom/completions/ya.completion.sh:
	@if command -v ya > /dev/null 2>&1; then \
		ya completion --bash; \
		mv $(HOME)/.ya.completion/bash/ya $(HOME)/.oh-my-bash/custom/completions/ya.completion.sh; \
		rm -rf $(HOME)/.ya.completion; \
	else \
		echo "Could not find the ya executable, skipping completions."; \
	fi

# WezTerm also has both the fetch and configure, but fetch is only needed for Linux virtual machines
# while configure is only needed for the macOS host. No reason to combine them into a single target.

# ------------------------------
# Targets for configuring tools
# ------------------------------

.PHONY: aerospace-configure
aerospace-configure: config-directory
	rm -rf $(HOME)/.config/aerospace && ln -sf $(CURDIR)/aerospace $(HOME)/.config/aerospace

.PHONY: fish-configure
fish-configure: config-directory
	rm -rf $(HOME)/.config/fish && ln -sf $(CURDIR)/fish $(HOME)/.config/fish

.PHONY: leetcode-configure
leetcode-configure:
	mkdir -p $(HOME)/.leetcode
	rm -f $(HOME)/.leetcode/leetcode.toml && ln -s $(CURDIR)/leetcode.toml $(HOME)/.leetcode/leetcode.toml
	@echo "Don't forget to set up the cookie!"

.PHONY: tridactyl-configure
tridactyl-configure: config-directory
	rm -rf $(HOME)/.config/tridactyl && ln -sf $(CURDIR)/tridactyl $(HOME)/.config/tridactyl

.PHONY: wezterm-configure
wezterm-configure: config-directory
	rm -rf $(HOME)/.config/wezterm && ln -sf $(CURDIR)/wezterm $(HOME)/.config/wezterm

.PHONY: skills
skills:
	mkdir -p $(HOME)/.agents/skills
	ln -sf $(HOME)/arcadia/ai/artifacts/skills/community/arcanum-client $(HOME)/.agents/skills/
	ln -sf $(HOME)/arcadia/ai/artifacts/skills/community/ast-index $(HOME)/.agents/skills/
	ln -sf $(HOME)/arcadia/ai/artifacts/skills/community/codesearch $(HOME)/.agents/skills/
	ln -sf $(HOME)/arcadia/ai/artifacts/skills/community/datalens $(HOME)/.agents/skills/
	ln -sf $(HOME)/arcadia/ai/artifacts/skills/community/nirvana $(HOME)/.agents/skills/
	ln -sf $(HOME)/arcadia/ai/artifacts/skills/community/underdeep $(HOME)/.agents/skills/
	ln -sf $(HOME)/arcadia/ai/artifacts/skills/community/ya-make $(HOME)/.agents/skills/
	ln -sf $(HOME)/arcadia/ai/artifacts/skills/community/yql $(HOME)/.agents/skills/
	ln -sf $(HOME)/arcadia/ai/artifacts/skills/community/yt $(HOME)/.agents/skills/
	ln -sf $(HOME)/arcadia/ai/artifacts/skills/infra/arc $(HOME)/.agents/skills/
	ln -sf $(HOME)/arcadia/ai/artifacts/skills/infra/tracker-mcp $(HOME)/.agents/skills/

# -----------------------------------
# Targets for fetching tool binaries
# -----------------------------------

.PHONY: fzf-fetch
fzf-fetch: bin-directory $(HOME)/.local/bin/fzf
$(HOME)/.local/bin/fzf:
	curl -s https://api.github.com/repos/junegunn/fzf/releases/latest \
	 | jq '.assets[] | select(.name | test("linux_amd64.tar.gz$$")) | .browser_download_url' \
	 | xargs wget -O /tmp/fzf.tgz
	tar xf /tmp/fzf.tgz -C $(HOME)/.local/bin

.PHONY: ripgrep-fetch
ripgrep-fetch: bin-directory $(HOME)/.local/bin/rg
$(HOME)/.local/bin/rg:
	mkdir -p /tmp/ripgrep
	curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest \
	 | jq '.assets[] | select(.name | test("x86_64.+linux.+tar.gz$$")) | .browser_download_url' \
	 | xargs wget -O /tmp/ripgrep/rg.tgz
	tar --strip-components=1 -xf /tmp/ripgrep/rg.tgz -C /tmp/ripgrep
	mv /tmp/ripgrep/rg $(HOME)/.local/bin

.PHONY: tree-sitter-fetch
tree-sitter-fetch: bin-directory $(HOME)/.local/bin/tree-sitter
$(HOME)/.local/bin/tree-sitter:
	mkdir -p /tmp/tree-sitter
	curl -s https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest \
	 | jq '.assets[] | select(.name | test("linux-x64.zip$$")) | .browser_download_url' \
	 | xargs wget -O /tmp/tree-sitter/tree-sitter.zip
	unzip -d $(HOME)/.local/bin /tmp/tree-sitter/tree-sitter.zip
	chmod +x $(HOME)/.local/bin/tree-sitter

.PHONY: uv-fetch
uv-fetch: $(HOME)/.local/bin/uv
$(HOME)/.local/bin/uv:
	curl -LsSf https://astral.sh/uv/install.sh | sh

.PHONY: wezterm-fetch
wezterm-fetch: bin-directory $(HOME)/.local/bin/wezterm
$(HOME)/.local/bin/wezterm:
	wget -O $(HOME)/.local/bin/wezterm https://github.com/wezterm/wezterm/releases/download/nightly/WezTerm-nightly-Ubuntu20.04.AppImage
	chmod +x $(HOME)/.local/bin/wezterm
