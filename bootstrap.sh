#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
    HOMEBREW_INSTALLER="https://raw.githubusercontent.com/homebrew/install/master/install"
else
    sudo apt update
    sudo apt upgrade
    sudo apt autoremove

    sudo apt install build-essential
    sudo apt install curl
    sudo apt install file
    sudo apt install git
    sudo apt install ruby

    export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH

    HOMEBREW_INSTALLER="https://raw.githubusercontent.com/linuxbrew/install/master/install"
fi

ruby -e "$(curl -fLsS $HOMEBREW_INSTALLER)"

brew analytics off

brew update
brew install fish

which fish | sudo tee -a /etc/shells
chsh -s "$(which fish)"

git clone git@github.com:alypeng/.files.git $HOME/.files

mkdir -p $HOME/.config
ln -s $HOME/.files/.config/fish $HOME/.config
