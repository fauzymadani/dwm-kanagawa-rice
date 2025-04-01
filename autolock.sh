#!/bin/sh
while true; do
    # if there's no activity for 9 minutes, lock the screen. if not, sleep
    if [ "$(xssstate -i)" -ge 540000 ] && ! pgrep slock > /dev/null; then
        slock
    fi
    sleep 10
done

