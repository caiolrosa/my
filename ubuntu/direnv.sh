if [ $(command -v direnv &> /dev/null) ]; then
	exit 2
fi

sudo apt install direnv
