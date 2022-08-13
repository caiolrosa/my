#!/bin/bash

sudo add-apt-repository ppa:aslatter/alacritty

sudo apt update
sudo apt install alacritty

if [ -L "$HOME/.config/alacritty" ]; then
	mv $HOME/.config/alacritty $HOME/.config/alacritty_bak
	ln -s $HOME/yggdrasil/alacritty $HOME/.config
	exit 3
fi

ln -s $HOME/yggdrasil/alacritty $HOME/.config
