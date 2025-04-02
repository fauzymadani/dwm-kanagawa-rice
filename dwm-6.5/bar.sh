#!/bin/sh

# Look for the display
export DISPLAY=$(echo $DISPLAY)

wifi_icon=""  # WiFi
battery_icon="󰁹"  # Battery
ram_icon="󰍛"  # RAM
cpu_icon="󰻠"  # CPU
clock_icon="󰥔"  # Clock

while true; do
    # check for the X server
    if ! xdpyinfo >/dev/null 2>&1; then
        echo " "
        exit 1
    fi

    # get wifi SSID
    wifi_ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes" {print $2}')
    wifi_status="${wifi_icon} ${wifi_ssid:-Disconnected}"

    # batteru status
    battery="${battery_icon} $(cat /sys/class/power_supply/BAT1/capacity)%"

    # RAM usage
    ram_used=$(free -m | awk '/^Mem/ {print $3}')
    ram_total=$(free -m | awk '/^Mem/ {print $2}')
    ram="${ram_icon} ${ram_used}/${ram_total}MB"

    # CPU
    cpu_usage=$(top -bn1 | awk '/^%Cpu/ {print $2 + $4}')
    cpu="${cpu_icon} ${cpu_usage}%"

    # Date
    datetime="${clock_icon} $(date "+%d-%m-%Y %H:%M")"

    
    xsetroot -name " [ $wifi_status / $battery / $ram / $datetime ]"

    sleep 2  # Update every 2 second
done

