#!/bin/bash

sudo apt install neovim

if [ -L "$HOME/.config/nvim" ]; then
	mv $HOME/.config/nvim $HOME/.config/nvim_bak
	ln -s $HOME/yggdrasil/nvim $HOME/.config
	exit 3
fi

ln -s  $HOME/yggdrasil/nvim $HOME/.config
