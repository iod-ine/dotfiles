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
