#!/bin/bash

zsh ./rust.sh

git clone https://github.com/alacritty/alacritty.git /tmp/alacritty
cd /tmp/alacritty

sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

cargo build --release

sudo cp target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

cd - && rm -r /tmp/alacritty

ln -s $HOME/yggdrasil/alacritty $HOME/.config
