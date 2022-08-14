#!/bin/bash

should_update=$(yggui/target/release/yggui confirm "Do you want to update the system before starting")
if [ $should_update == "true" ]; then
	sudo apt update && sudo apt upgrade
fi

sudo apt install build-essential
if [ $? -ne 0 ]; then
	echo "Failed installing baseline packages"; exit 1
fi

if ! hash zsh; then
	echo -e "\n>>>>> Installing zsh <<<<<\n"
	bash ubuntu/zsh.sh
	echo -e "\n>>>>> Finished installing zsh <<<<<\n"
else
	ln -s $HOME/yggdrasil/oh_my_zsh/.zshrc $HOME

	git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

	source $HOME/.zshrc
fi


IFS=","

apps_title="Which applications should be installed?"
apps=(
	tmux "Tmux"
	nerd_fonts "Nerd Fonts"
	direnv "Direnv"
	nvim "Neovim"
	awesome "Awesome"
	betterlockscreen "BetterLockScreen"
	taskwarrior "Taskwarrior"
	brave "Brave"
	google_chrome "Google Chrome"
	docker "Docker"

	# Depends on rust installed which depends on asdf
	asdf "Asdf"
	rust "Rust"
	alacritty "Alacritty"
)
apps_selection=($(yggui/target/release/yggui checklist "${apps_title}" ${apps[@]}))

choices=(${apps_selection[@]})

IFS=""

declare -A RESULTS
RESULTS=([errors]="" [skipped]="" [backup]="")

for choice in ${choices[@]}; do
	echo -e "\n>>>>> Installing $choice <<<<<\n"
	bash ubuntu/$choice.sh
	case $? in
		0) echo -e "\n>>>>> Installed $choice successfully <<<<<\n";;
		1) RESULTS[errors]+=" $choice"
	           echo -e "\n>>>>> Failed installing $choice <<<<<\n";;
		2) RESULTS[skipped]+=" $choice" ;;
		3) RESULTS[backup]+=" $choice" ;;
	esac
done

echo "ERRORS:"
errs=(${RESULTS[errors]})
for err in ${errs}; do
	echo -e "\t${err}"
done

echo "SKIPPED:"
skipped=(${RESULTS[skipped]})
for skip in ${skipped}; do
	echo -e "\t${skip}"
done

echo "BACKUP:"
backup=(${RESULTS[backup]})
for back in ${backup}; do
	echo -e "\t${back}"
done
