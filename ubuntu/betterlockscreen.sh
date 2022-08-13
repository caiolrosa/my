if [ $(command -v betterlockscreen &> /dev/null) ]; then
	exit 2
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
