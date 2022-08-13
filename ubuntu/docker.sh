#!/bin/bash

curl -fsSL https://get.docker.com -o get-docker.sh

sudo sh get-docker.sh

rm get-docker.sh

if ! [ $(getent group docker) ]; then
	sudo groupadd docker
fi

sudo usermod -aG docker $USER
