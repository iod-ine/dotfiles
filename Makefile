create-symlinks:
	mkdir -p ~/.config
	rm -rf ~/.config/flake8 && ln -s $(CURDIR)/.flake8  ~/.config/flake8
	rm -rf ~/.config/tmux && ln -sf $(CURDIR)/tmux ~/.config/tmux
	rm -rf ~/.config/nvim && ln -sf $(CURDIR)/nvim ~/.config/nvim
