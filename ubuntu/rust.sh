#!/bin/bash

source $HOME/.zshrc
asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git
asdf install rust latest
asdf global rust latest