alacritty() {
	if command -v alacritty &> /dev/null; then
		return 2
	fi

	yay --noconfirm -S alacritty

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
	if command -v tmux &> /dev/null; then
		return 2
	fi

	yay --noconfirm -S tmux

	if [ $? -ne 0 ]; then
		return 1
	fi

	if [ -d "$HOME/.config/tmux" ]; then
		mv $HOME/.config/tmux $HOME/.config/tmux_bak
		ln -s $HOME/yggdrasil/tmux $HOME/.config
		return 3
	fi

	ln -s $HOME/ygdrasil/tmux $HOME/.config
}

nerd_fonts() {
	wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip"
	sudo mkdir -p /usr/share/fonts/TTF
	sudo unzip SourceCodePro.zip -d /usr/share/fonts/TTF
	rm SourceCodePro.zip

	return 0
}

direnv() {
	if command -v direnv &> /dev/null; then
		return 2
	fi

	yay --noconfirm -S direnv

	if [ $? -ne 0 ]; then
		return 1
	fi

	return 0
}

taskwarrior() {
	if command -v task &> /dev/null; then
		return 1
	fi

	yay --noconfirm -S task

	if [ $? -ne 0 ]; then
		return 1
	fi

	if [ -f "$HOME/.taskrc" ]; then
		mv $HOME/.taskrc $HOME/.taskrc.bak
		ln -s $HOME/yggdrasil/taskwarrior/.taskrc $HOME/.taskrc
		return 3
	fi

	ln -s $HOME/yggdrasil/taskwarrior/.taskrc $HOME/.taskrc

	return 0
}

nvim() {
	if command -v nvim &> /dev/null; then
		return 2
	fi

	yay --noconfirm -S neovim

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
	if command -v qtile &> /dev/null; then
		return 2
	fi

	yay --noconfirm -S qtile python-setuptools

	if [ $? -ne 0 ]; then
		return 1
	fi

	if [ -d "$HOME/.config/qtile" ]; then
		mv $HOME/.config/qtile $HOME/.config/qtile_bak
		ln -s $HOME/yggdrasil/qtile $HOME/.config
		return 3
	fi

	ln -s $HOME/yggdrasil/qtile $HOME/.config
	return 0
}

xmonad() {
	if command -v xmonad &> /dev/null; then
		return 2
	fi

	yay --noconfirm -S xmonad xmobar

	if [ $? -ne 0 ]; then
		return 1
	fi

	if [ -d "$HOME/.xmonad" ]; then
		mv $HOME/.xmonad/ $HOME/.xmonad_bak
		ln -s $HOME/yggdrasil/xmonad $HOME/.config/.xmonad
		return 3
	fi

	ln -s $HOME/yggdrasil/xmonad $HOME/.config/.xmonad
	return 0
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
