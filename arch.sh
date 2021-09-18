#! /bin/bash

should_update=$(yggui/target/release/yggui confirm "Do you want to update the system before starting")
if [ $should_update -eq 'true' ]; then
	sudo pacman -Syu --no-confirm
fi

sudo pacman --no-confirm -S yay
if [ $? -ne 0 ]; then
	echo "Failed installing yay"; exit 1
fi

yay --no-confirm -S base-devel
if [ $? -ne 0 ]; then
	echo "Failed installing baseline packages"; exit 1
fi

IFS=","

terminal=(
	alacritty "Alacritty"
	oh_my_zsh "Oh My Zsh"
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
	qtile "Qtile"
	xmonad "Xmonad"
	betterlockscreen "BetterLockScreen"
)

wms_title="Which window managers do you want to install?"
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

handle_result() {
	case $1 in
		0) echo "$2 installed successfully" ;;
		1) RESULTS[errors]+=" $2" ;;
		2) RESULTS[skipped]+=" $2" ;;
		3) RESULTS[backup]+=" $2" ;;
	esac
}

for choice in ${choices[@]}; do
	case $choice in
		("alacritty")
			status=$(bash arch/install.sh alacritty)
			handle_result $status "Alacritty"
			;;
		("oh_my_zsh") bash arch/install.sh oh_my_zsh ;;
		("tmux") bash arch/install.sh tmux ;;
		("nerd_fonts") bash arch/install.sh nerd_fonts ;;
		("direnv") bash arch/install.sh direnv ;;
		("taskwarrior") bash arch/install.sh taskwarrior ;;
		("nvim")
			status=$(bash arch/install.sh nvim)
			handle_result $status "Neovim"
			;;
		("asdf") bash arch/install.sh asdf ;;
		("qtile") bash arch/install.sh qtile ;;
		("xmonad") bash arch/install.sh xmonad ;;
		("betterlockscreen") bash arch/install.sh betterlockscreen ;;
		("brave") bash arch/install.sh brave ;;
		("google_chrome") bash arch/install.sh google_chrome ;;
		("docker") bash arch/install.sh docker ;;
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
