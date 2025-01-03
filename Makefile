create-symlinks:
	mkdir -p ~/.config
	rm -rf ~/.config/flake8 && ln -s $(CURDIR)/flake8  ~/.config/flake8
	rm -rf ~/.config/tmux && ln -sf $(CURDIR)/tmux ~/.config/tmux
	rm -rf ~/.config/nvim && ln -sf $(CURDIR)/nvim ~/.config/nvim
	rm -rf ~/.config/conda && ln -sf $(CURDIR)/conda ~/.config/conda
	rm -rf ~/.config/tridactyl && ln -sf $(CURDIR)/tridactyl ~/.config/tridactyl
	rm -rf ~/.config/aerospace && ln -sf $(CURDIR)/aerospace ~/.config/aerospace
	rm -rf ~/.config/wezterm && ln -sf $(CURDIR)/wezterm ~/.config/wezterm
