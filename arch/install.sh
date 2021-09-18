alacritty() {
	if command -v alacritty &> /dev/null; then
		return 2
	fi

	yay --no-confirm -S alacritty

	if [ $? -ne 0 ]; then
		return 1
	fi

	if [ -d "$HOME/.config/alacritty" ]; then
		mv $HOME/.config/alacritty $HOME/.config/alacritty_bak
		ln -s $HOME/yggdrasil/alacritty $HOME/.config
		return 3
	fi

	ln -s $HOME/yggdrasil/alacritty $HOME/.config
	return 0
}

oh_my_zsh() {
	echo OhMyZsh
}

tmux() {
	echo Tmux
}

nerd_fonts() {
	echo Nerd Fonts
}

direnv() {
	echo Direnv
}

taskwarrior() {
	echo Taskwarrior
}

nvim() {
	if command -v nvim &> /dev/null; then
		return 2
	fi

	yay --no-confirm -S neovim

	if [ $? -ne 0 ]; then
		return 1
	fi
	
	if [ -d "$HOME/.config/nvim" ]; then
		mv $HOME/.config/nvim $HOME/.config/nvim_bak
		ln -s $HOME/yggdrasil/nvim $HOME/.config
		return 3
	fi

	ln -s  $HOME/yggdrasil/nvim $HOME/.config
	return 0
}

asdf() {
	echo Asdf
}

qtile() {
	echo Qtile
}

xmonad() {
	echo Xmonad
}

betterlockscreen() {
	echo BetterLockScreen
}

brave() {
	echo Brave
}

google_chrome() {
	echo Google Chrome
}

docker() {
	echo Docker
}

$1
