help::
	@echo "Available commands:"
	@echo "  nvim: fetch and configure Neovim"

config-directory: $(HOME)/.config
$(HOME)/.config:
	mkdir -p ~/.config

bin-directory: $(HOME)/.local/bin
$(HOME)/.local/bin:
	mkdir -p ~/.local/bin

nvim:: fetch-nvim configure-nvim fetch-ripgrep fetch-fzf
configure-nvim:: config-directory
	rm -rf ~/.config/nvim && ln -sf $(CURDIR)/nvim ~/.config/nvim
fetch-nvim:: bin-directory $(HOME)/.local/bin/nvim
$(HOME)/.local/bin/nvim:
	mkdir -p /tmp/nvim
	wget -O /tmp/nvim/nvim.tgz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	tar xf /tmp/nvim/nvim.tgz -C ~/.local/bin
	ln -s ~/.local/bin/nvim-linux-x86_64/bin/nvim ~/.local/bin/nvim

tmux:: config-directory
	rm -rf ~/.config/tmux && ln -sf $(CURDIR)/tmux ~/.config/tmux

aerospace:: config-directory
	rm -rf ~/.config/aerospace && ln -sf $(CURDIR)/aerospace ~/.config/aerospace

fish:: config-directory
	rm -rf ~/.config/fish && ln -s $(CURDIR)/fish ~/.config/fish

wezterm:: config-directory
	rm -rf ~/.config/wezterm && ln -sf $(CURDIR)/wezterm ~/.config/wezterm

tridactyl:: config-directory
	rm -rf ~/.config/tridactyl && ln -sf $(CURDIR)/tridactyl ~/.config/tridactyl

opencode:: config-directory
	rm -rf ~/.config/opencode && ln -sf $(CURDIR)/opencode ~/.config/opencode

leetcode::
	mkdir -p ~/.leetcode
	rm -f ~/.leetcode/leetcode.toml && ln -s $(CURDIR)/leetcode.toml ~/.leetcode/leetcode.toml
	@echo "Don't forget to setup the cookie!"

fetch-wezterm:: bin-directory
	wget -O ~/.local/bin/wezterm https://github.com/wezterm/wezterm/releases/download/nightly/WezTerm-nightly-Ubuntu20.04.AppImage
	chmod +x ~/.local/bin/wezterm

fetch-uv::
	curl -LsSf https://astral.sh/uv/install.sh | sh

fetch-omb::
	bash -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

fetch-fzf:: bin-directory $(HOME)/.local/bin/fzf
$(HOME)/.local/bin/fzf:
	curl -s https://api.github.com/repos/junegunn/fzf/releases/latest \
	 | jq '.assets[] | select(.name | test("linux_amd64.tar.gz$$")) | .browser_download_url' \
	 | xargs wget -O /tmp/fzf.tgz
	tar xf /tmp/fzf.tgz -C ~/.local/bin

fetch-ripgrep:: bin-directory $(HOME)/.local/bin/rg
$(HOME)/.local/bin/rg:
	mkdir -p /tmp/ripgrep
	curl -s https://api.github.com/repos/BurntSushi/ripgrep/releases/latest \
	 | jq '.assets[] | select(.name | test("x86_64.+linux.+tar.gz$$")) | .browser_download_url' \
	 | xargs wget -O /tmp/ripgrep/rg.tgz
	tar --strip-components=1 -xf /tmp/ripgrep/rg.tgz -C /tmp/ripgrep
	mv /tmp/ripgrep/rg ~/.local/bin
