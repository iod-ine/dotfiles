directory::
	mkdir -p ~/.config

nvim:: directory
	rm -rf ~/.config/nvim && ln -sf $(CURDIR)/nvim ~/.config/nvim

tmux:: directory
	rm -rf ~/.config/tmux && ln -sf $(CURDIR)/tmux ~/.config/tmux

aerospace:: directory
	rm -rf ~/.config/aerospace && ln -sf $(CURDIR)/aerospace ~/.config/aerospace

fish:: directory
	rm -rf ~/.config/fish && ln -s $(CURDIR)/fish ~/.config/fish

wezterm:: directory
	rm -rf ~/.config/wezterm && ln -sf $(CURDIR)/wezterm ~/.config/wezterm

tridactyl:: directory
	rm -rf ~/.config/tridactyl && ln -sf $(CURDIR)/tridactyl ~/.config/tridactyl

leetcode::
	mkdir -p ~/.leetcode
	rm -f ~/.leetcode/leetcode.toml && ln -s $(CURDIR)/leetcode.toml ~/.leetcode/leetcode.toml
	@echo "Don't forget to setup the cookie!"

bin-directory::
	mkdir -p ~/.local/bin

fetch-nvim:: bin-directory
	wget -O ~/.local/bin/nvim.tgz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
	tar xf ~/.local/bin/nvim.tgz -C ~/.local/bin
	ln -s ~/.local/bin/nvim-linux-x86_64/bin/nvim ~/.local/bin/nvim

fetch-wezterm:: bin-directory
	wget -O ~/.local/bin/wezterm https://github.com/wezterm/wezterm/releases/download/nightly/WezTerm-nightly-Ubuntu20.04.AppImage
	chmod +x ~/.local/bin/wezterm

fetch-uv::
	curl -LsSf https://astral.sh/uv/install.sh | sh

fetch-omb::
	bash -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

fetch-fzf:: bin-directory
	curl -s https://api.github.com/repos/junegunn/fzf/releases/latest \
	 | jq '.assets[] | select(.name | test("linux_amd64.tar.gz$$")) | .browser_download_url' \
	 | xargs wget -O ~/.local/bin/fzf.tgz
	tar xf ~/.local/bin/fzf.tgz -C ~/.local/bin
