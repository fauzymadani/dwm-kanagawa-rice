#!/bin/sh

# =========================== dwm is the default ============================ #

# Keyring daemon
# eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
# export SSH_AUTH_SOCK

# lxpolkit &

dunst &

# ~/.local/bin/autolock.sh &

/home/fauzy/dwm-6.5/bar.sh &

feh --bg-fill /home/fauzy/Downloads/wallpaper/Kanagawa/sunset_kanagawa-dragon.jpg &

notify-send "Halo sayang!" "DWM session started successfully."

exec dwm

# =========================== other wm's ===================================== #
#exec 2bwm
#exec chadwm
#exec dusk
#exec frankenwm
#exec herbstluftwm
#exec i3
#exec i3-with-shmlog
#exec openbox
#exec spectrwm
#exec xfce-session  # Untuk XFCE
#exec startlxde  # Untuk LXDE

# ============================================================================ #
