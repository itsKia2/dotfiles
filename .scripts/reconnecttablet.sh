#! bin/bash

sudo modprobe -r hid_m708
sudo modprobe hid_m708
sleep 1
sh /home/kia/.scripts/tabletmaps.sh
echo "Tablet reconnected"
