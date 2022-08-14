#!/bin/bash

wget -O /tmp/i3lock https://github.com/Raymo111/i3lock-color/releases/download/2.13.c.4/i3lock
sudo chmod +x /tmp/i3lock
sudo mv /tmp/i3lock /usr/local/bin

sudo apt install imagemagick

wget -O /tmp/main.zip https://github.com/pavanjadhaw/betterlockscreen/archive/refs/heads/main.zip
unzip /tmp/main.zip

chmod u+x /tmp/betterlockscreen-main/betterlockscreen
sudo cp /tmp/betterlockscreen-main/betterlockscreen /usr/local/bin/

sudo cp /tmp/betterlockscreen-main/system/betterlockscreen@.service /usr/lib/systemd/system/
sudo systemctl enable betterlockscreen@$USER

rm -rf /tmp/main.zip /tmp/betterlockscreen-main

betterlockscreen -u $HOME/yggdrasil/awesome/wallpaper.jpg
