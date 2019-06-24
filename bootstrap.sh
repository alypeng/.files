#!/usr/bin/env bash

if [ "$(uname)" == "Linux" ]; then
    sudo apt update
    sudo apt install git
fi

git clone git@github.com:alypeng/.files.git $HOME/.files

if [ "$(uname)" == "Darwin" ]; then
    source $HOME/.files/bootstrap-macos.sh
else
    source $HOME/.files/bootstrap-linux.sh
fi

brew analytics off

brew update
brew install fish

which fish | sudo tee -a /etc/shells
chsh -s "$(which fish)"

mkdir -p $HOME/.config
ln -s $HOME/.files/.config/fish $HOME/.config
