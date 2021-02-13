#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
    HOMEBREW_INSTALLER="https://raw.githubusercontent.com/homebrew/install/master/install.sh"

    curl -fLsS $HOMEBREW_INSTALLER | bash

    brew analytics off

    brew update
    brew install fish

    which fish | sudo tee -a /etc/shells
else
    sudo dnf --refresh upgrade
    sudo dnf --refresh autoremove

    sudo dnf install \
        fish \
        git \
        tar \
        util-linux-user
fi

chsh -s "$(which fish)"

git clone https://github.com/alypeng/.files.git "$HOME"/.files

mkdir -p "$HOME"/.config

ln -fs "$HOME"/.files/.config/fish "$HOME"/.config
ln -fs "$HOME"/.files/.config/nixpkgs "$HOME"/.config

curl -fLsS https://nixos.org/nix/install | sh

# shellcheck disable=SC1090
source "$HOME"/.nix-profile/etc/profile.d/nix.sh
nix-env --install --attr nixpkgs.my-base-env
