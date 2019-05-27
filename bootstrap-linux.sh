#!/usr/bin/env bash

sudo apt update
sudo apt upgrade
sudo apt autoremove

sudo apt install build-essential
sudo apt install curl
sudo apt install file
sudo apt install git
sudo apt install ruby

INSTALLER="https://raw.githubusercontent.com/linuxbrew/install/master/install"

ruby -e "$(curl -fLsS $INSTALLER)"

export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
