#!/bin/bash

sudo apt install tmux

if [ -L "$HOME/.config/tmux" ]; then
	mv $HOME/.config/tmux $HOME/.config/tmux_bak
	ln -s $HOME/yggdrasil/tmux $HOME/.config
	exit 3
fi

ln -s $HOME/ygdrasil/tmux $HOME/.config
