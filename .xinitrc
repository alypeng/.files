#!/usr/bin/env bash

xrdb -load $HOME/.Xresources
setxkbmap -option caps:escape
xmodmap $HOME/.Xmodmap
redshift -O 4500 -P
exec i3
