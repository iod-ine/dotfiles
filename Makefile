create-symlinks:
	rm -f ~/.flake8 && ln -s $(CURDIR)/.flake8  ~/.flake8
	rm -rf ~/.config/tmux && ln -sf $(CURDIR)/tmux ~/.config/tmux
