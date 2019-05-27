#!/usr/bin/env bash

INSTALLER="https://raw.githubusercontent.com/linuxbrew/install/master/install"

ruby -e "$(curl -fLsS $INSTALLER)"

export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
