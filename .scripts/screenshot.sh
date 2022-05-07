#!/bin/sh

grim -g "$(slurp)" $HOME/Pictures/Screenshots/$('%F_%H-%M.png') 
notify-send "Screenshot taken"
