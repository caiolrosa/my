#!/bin/bash

wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip"

sudo mkdir -p /usr/share/fonts/TTF

sudo unzip SourceCodePro.zip -d /usr/share/fonts/TTF

rm SourceCodePro.zip
