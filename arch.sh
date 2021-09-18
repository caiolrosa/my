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
terminal_selection=$(yggui/target/release/yggui checklist "${terminal_title}" ${terminal[@]})

dev=(
	direnv "Direnv"
	taskwarrior "Taskwarrior"
	nvim "Neovim"
	asdf "Asdf"
)

dev_title="Which development tools do you want to install?"
dev_selection=$(yggui/target/release/yggui checklist "${dev_title}" ${dev[@]})

wms=(
	qtile "Qtile"
	xmonad "Xmonad"
	betterlockscreen "BetterLockScreen"
)

wms_title="Which window managers do you want to install?"
wms_selection=$(yggui/target/release/yggui checklist "${wms_title}" ${wms[@]})

software=(
	brave "Brave"
	google_chrome "Google Chrome"
	docker "Docker"
)

software_title="Which software do you want to install?"
software_selection=$(yggui/target/release/yggui checklist "${software_title}" ${softwares[@]})

choices=(${terminal_selection[@]} ${dev_selection[@]} ${wms_selection[@]} ${software_selection[@]})

IFS=""

for choice in ${choices}; do
	case choice in
		("alacritty") install_alacritty ;;
		("oh_my_zsh") install_oh_my_zsh ;;
		("tmux") install_tmux ;;
		("nerd_fonts") install_nerd_fonts ;;
		("direnv") install_direnv ;;
		("taskwarrior") install_taskwarrior ;;
		("nvim") install_nvim ;;
		("asdf") install_asdf ;;
		("qtile") install_qtile ;;
		("xmonad") install_xmonad ;;
		("betterlockscreen") install_betterlockscreen ;;
		("brave") install_brave ;;
		("google_chrome") install_google_chrome ;;
		("docker") install_docker ;;
	esac
done
