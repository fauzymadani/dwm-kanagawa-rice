#!/bin/sh

# status bar script with xsetroot
~/dwm-6.5/bar.sh &

dunst & # notification daemon

# Set wallpaper 
feh --bg-scale ~/Downloads/wallpaper/Kanagawa/sunset_kanagawa-dragon.jpg &

# auto lock screen with xautolock
~/.local/bin/autolock.sh & # Homemade script

# xautolock -time 9 -locker "~/.local/bin/lock-screen" -notify 60 -notifier "notify-send 'Locking in 1 minute' 'The system will be locked in one minute!'"
# xautolock -time 9 -locker slock -notify 60 -notifier notify-send 'Locking in 1 minute' 'The system will be locked in one minute!'

# DWM
exec dwm
