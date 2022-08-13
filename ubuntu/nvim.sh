#!/bin/bash

if [ -x $(command -v nvim &> /dev/null) ]; then
	exit 2
fi

sudo apt install neovim

if [ -L "$HOME/.config/nvim" ]; then
	mv $HOME/.config/nvim $HOME/.config/nvim_bak
	ln -s $HOME/yggdrasil/nvim $HOME/.config
	exit 3
fi

ln -s  $HOME/yggdrasil/nvim $HOME/.config
