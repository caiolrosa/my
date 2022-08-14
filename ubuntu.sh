#!/bin/bash

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

	asdf "Asdf"

	# Rust depends on asdf
	rust "Rust"

	# Alacritty depends on rust
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
