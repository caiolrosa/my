#!/bin/bash

sudo apt install taskwarrior

if [ -f "$HOME/.taskrc" ]; then
	mv $HOME/.taskrc $HOME/.taskrc.bak
	ln -s $HOME/yggdrasil/taskwarrior/.taskrc $HOME/.taskrc
	exit 3
fi

ln -s $HOME/yggdrasil/taskwarrior/.taskrc $HOME/.taskrc
