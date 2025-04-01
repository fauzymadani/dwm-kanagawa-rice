#!/bin/sh
while true; do
    # Jika idle lebih dari 9 menit (540000 ms) dan slock belum berjalan, kunci layar
    if [ "$(xssstate -i)" -ge 540000 ] && ! pgrep slock > /dev/null; then
        slock
    fi
    sleep 10
done

