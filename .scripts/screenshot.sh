#!/bin/sh

grim -g "$(slurp)" $HOME/Pictures/Screenshots/$(date +'%F_%H-%M.png') 
notify-send "Screenshot taken"
