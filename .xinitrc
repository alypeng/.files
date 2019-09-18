#!/usr/bin/env bash

xrdb -load $HOME/.Xresources
redshift -O 3500 -P
exec i3
