sudo apt install awesome picom rofi

if [ -d "$HOME/.config/awesome" ]; then
	mv $HOME/.config/awesome $HOME/.config/awesome_bak
fi

ln -s $HOME/yggdrasil/awesome $HOME/.config


if [ -d "$HOME/.config/picom" ]; then
	mv $HOME/.config/picom $HOME/.config/picom_bak
fi

ln -s $HOME/yggdrasil/picom $HOME/.config

if [ -d "$HOME/.config/rofi" ]; then
	mv $HOME/.config/rofi $HOME/.config/rofi_bak
fi

ln -s $HOME/yggdrasil/rofi $HOME/.config
