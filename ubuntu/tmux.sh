if [ $(command -v tmux &> /dev/null) ]; then
	exit 2
fi

sudo apt install tmux

if [ -d "$HOME/.config/tmux" ]; then
	mv $HOME/.config/tmux $HOME/.config/tmux_bak
	ln -s $HOME/yggdrasil/tmux $HOME/.config
	exit 3
fi

ln -s $HOME/ygdrasil/tmux $HOME/.config
