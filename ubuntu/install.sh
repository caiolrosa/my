alacritty() {
	if [ $(command -v alacritty &> /dev/null) ]; then
		return 2
	fi

	sudo add-apt-repository ppa:mmstick76/alacritty

	if [ $? -ne 0 ]; then
		return 1
	fi

	sudo apt update
	sudo apt install alacritty

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
	if [ $(command -v tmux &> /dev/null) ]; then
		return 2
	fi

	sudo apt install tmux

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

awesome() {
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

	return 0
}

direnv() {
	if [ $(command -v direnv &> /dev/null) ]; then
		return 2
	fi

	sudo apt install direnv

	if [ $? -ne 0 ]; then
		return 1
	fi

	return 0
}

taskwarrior() {
	if [ $(command -v task &> /dev/null) ]; then
		return 1
	fi

	sudo apt install taskwarrior

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
	if [ $(command -v nvim &> /dev/null) ]; then
		return 2
	fi

	sudo apt install neovim

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
	sudo apt install curl git

	if [ $? -ne 0 ]; then
		return 1
	fi

	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
}

betterlockscreen() {
	if [ $(command -v betterlockscreen &> /dev/null) ]; then
		return 2
	fi

	wget https://github.com/Raymo111/i3lock-color/releases/download/2.13.c.4/i3lock
	sudo chmod +x i3lock
	sudo mv i3lock /usr/local/bin

	sudo apt install imagemagick

	wget https://github.com/pavanjadhaw/betterlockscreen/archive/refs/heads/main.zip
	unzip main.zip

	cd betterlockscreen-main/
	chmod u+x betterlockscreen-main/betterlockscreen
	sudo cp betterlockscreen-main/betterlockscreen /usr/local/bin/

	sudo cp betterlockscreen-main/system/betterlockscreen@.service /usr/lib/systemd/system/
	sudo systemctl enable betterlockscreen@$USER

	rm -rf main.zip betterlockscreen-main

	betterlockscreen -u $HOME/yggdrasil/awesome/wallpaper.jpg
}

brave() {
	sudo apt install apt-transport-https curl

	if [ $? -ne 0 ]; then
		return 1
	fi

	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

	if [ $? -ne 0 ]; then
		return 1
	fi

	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

	sudo apt update

	sudo apt install brave-browser

	if [ $? -ne 0 ]; then
		return 1
	fi

	return 0
}

google_chrome() {
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

	if [ $? -ne 0 ]; then
		return 1
	fi

	sudo dpkg -i google-chrome-stable_current_amd64.deb

	if [ $? -ne 0 ]; then
		return 1
	fi

	rm google-chrome-stable_current_amd64.deb

	return 0
}

docker() {
	if [ $(command -v docker &> /dev/null) ]; then
		return 2
	fi

	curl -fsSL https://get.docker.com -o get-docker.sh

	sudo sh get-docker.sh

	if [ $? -ne 0 ]; then
		return 1
	fi

	rm get-docker.sh

	if ! [ $(getent group docker) ]; then
		sudo groupadd docker
	fi

	sudo usermod -aG docker $USER

	return 0
}

"$@"
