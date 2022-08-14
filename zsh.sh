#!/bin/bash

if ! hash zsh; then
	echo -e "\n>>>>> Installing zsh <<<<<\n"
	sudo apt install zsh
	sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
	echo -e "\n>>>>> Finished installing zsh <<<<<\n"
else
	mv $HOME/.zshrc $HOME/.zshrc_bak
	ln -s $HOME/yggdrasil/oh_my_zsh/.zshrc $HOME

	git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

sudo chsh -s $(which zsh) $USER
