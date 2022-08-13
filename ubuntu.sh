#!/bin/bash

should_update=$(yggui/target/release/yggui confirm "Do you want to update the system before starting")
if [ $should_update == "true" ]; then
	sudo apt update
fi

sudo apt install build-essential
if [ $? -ne 0 ]; then
	echo "Failed installing baseline packages"; exit 1
fi

IFS=","

terminal=(
	alacritty "Alacritty"
	zsh "Zsh"
	tmux "Tmux"
	nerd_fonts "Nerd Fonts"
)

terminal_title="Which terminal tools do you want to install?"
terminal_selection=($(yggui/target/release/yggui checklist "${terminal_title}" ${terminal[@]}))

dev=(
	direnv "Direnv"
	taskwarrior "Taskwarrior"
	nvim "Neovim"
	asdf "Asdf"
)

dev_title="Which development tools do you want to install?"
dev_selection=($(yggui/target/release/yggui checklist "${dev_title}" ${dev[@]}))

wms=(
	awesome "Awesome"
	betterlockscreen "BetterLockScreen"
)

wms_title="Which window managers and lockscreens do you want to install?"
wms_selection=($(yggui/target/release/yggui checklist "${wms_title}" ${wms[@]}))

softwares=(
	brave "Brave"
	google_chrome "Google Chrome"
	docker "Docker"
)

software_title="Which software do you want to install?"
software_selection=($(yggui/target/release/yggui checklist "${software_title}" ${softwares[@]}))

choices=(${terminal_selection[@]} ${dev_selection[@]} ${wms_selection[@]} ${software_selection[@]})

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
