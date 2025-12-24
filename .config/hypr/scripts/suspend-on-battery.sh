#!/usr/bin/env bash

# Check AC status (works on most laptops)
if [ -e /sys/class/power_supply/AC/online ]; then
    AC_ONLINE=$(cat /sys/class/power_supply/AC/online)
else
    # Fallback for systems using ACAD
    AC_ONLINE=$(cat /sys/class/power_supply/ACAD/online 2>/dev/null || echo 1)
fi

echo $AC_ONLINE
if [ "$AC_ONLINE" = "0" ]; then
    systemctl suspend
fi
