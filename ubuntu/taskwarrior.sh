if [ $(command -v task &> /dev/null) ]; then
	exit 2
fi

sudo apt install taskwarrior

if [ $? -ne 0 ]; then
	exit 1
fi

if [ -f "$HOME/.taskrc" ]; then
	mv $HOME/.taskrc $HOME/.taskrc.bak
	ln -s $HOME/yggdrasil/taskwarrior/.taskrc $HOME/.taskrc
	exit 3
fi

ln -s $HOME/yggdrasil/taskwarrior/.taskrc $HOME/.taskrc
