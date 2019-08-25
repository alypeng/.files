#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
    HOMEBREW_INSTALLER="https://raw.githubusercontent.com/homebrew/install/master/install"
else
    sudo dnf --refresh upgrade
    sudo dnf --refresh autoremove

    sudo dnf install ruby
    sudo dnf install tar

    export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH

    HOMEBREW_INSTALLER="https://raw.githubusercontent.com/linuxbrew/install/master/install"
fi

ruby -e "$(curl -fLsS $HOMEBREW_INSTALLER)"

brew analytics off

if [ "$(uname)" == "Darwin" ]; then
    brew update
    brew install fish

    which fish | sudo tee -a /etc/shells
else
    sudo dnf install fish
    sudo dnf install util-linux-user
fi

chsh -s "$(which fish)"

git clone git@github.com:alypeng/.files.git $HOME/.files

mkdir -p $HOME/.config
ln -fs $HOME/.files/.config/fish $HOME/.config
