#!/usr/bin/env bash

xrdb -load $HOME/.Xresources
setxkbmap -option caps:escape
redshift -O 3500 -P
exec i3
