#!/bin/bash

sudo apt install zsh

sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

if ! hash zsh; then
	echo -e "\n>>>>> Installing zsh <<<<<\n"
	bash ubuntu/zsh.sh
	echo -e "\n>>>>> Finished installing zsh <<<<<\n"
else
	ln -s $HOME/yggdrasil/oh_my_zsh/.zshrc $HOME

	git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
