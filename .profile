# disabling the annoying bell
setterm -blength 0

# theme
#export QT_QPA_PLATFORMTHEME=kde
#export QT_QPA_PLATFORMTHEME=qt5ct

if [ "$XDG_CURRENT_DESKTOP" == "KDE" ]; then
	export QT_QPA_PLATFORMTHEME=kde
else
	export QT_QPA_PLATFORMTHEME=qt5ct
fi

# firefox wayland setting
if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
	export MOZ_ENABLE_WAYLAND=1
fi
