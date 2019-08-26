#!/usr/bin/env bash

xrdb -load $HOME/.Xresources
redshift -O 4000 -P
exec i3
