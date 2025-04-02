#!/bin/sh

# detect the display e.g (:1, :2)
export DISPLAY=$(echo $DISPLAY)

# Icon
wifi_icon=""  # WiFi
battery_icon="󰁹"  # Baterai
ram_icon="󰍛"  # RAM
cpu_icon="󰻠"  # CPU
clock_icon="󰥔"  # Clock
download_icon=""  # Download
upload_icon=""  # Upload
apt_upgrades_icon="󰏔"

net_interface="wlp2s0"

get_net_speed() {
    rx_bytes_old=$(cat /sys/class/net/$net_interface/statistics/rx_bytes)
    tx_bytes_old=$(cat /sys/class/net/$net_interface/statistics/tx_bytes)

    sleep 1  # wait

    rx_bytes_new=$(cat /sys/class/net/$net_interface/statistics/rx_bytes)
    tx_bytes_new=$(cat /sys/class/net/$net_interface/statistics/tx_bytes)

    rx_speed=$(( (rx_bytes_new - rx_bytes_old) / 1024 )) # KB/s
    tx_speed=$(( (tx_bytes_new - tx_bytes_old) / 1024 )) # KB/s

    # make sure the value is not negative
    [ "$rx_speed" -lt 0 ] && rx_speed=0
    [ "$tx_speed" -lt 0 ] && tx_speed=0
}

get_apt_upgrades() {
    count=$(apt list --upgradable 2>/dev/null | grep -c '^')
    echo "$count"
}

while true; do
    # Check if the display server is active
    if ! xdpyinfo >/dev/null 2>&1; then
        echo " "
        exit 1
    fi

    # Check wifi status
    wifi_connected=$(nmcli -t -f ACTIVE dev wifi | grep -q '^yes' && echo "Connected" || echo "Disconnected")
    wifi_status="${wifi_icon} ${wifi_connected}"

    # Get battery status
    battery="${battery_icon} $(cat /sys/class/power_supply/BAT1/capacity)%"

    # Get RAM usage
    ram_used=$(free -m | awk '/^Mem/ {print $3}')
    ram_total=$(free -m | awk '/^Mem/ {print $2}')
    ram="${ram_icon} ${ram_used}/${ram_total}MB"

    # Get CPU usage
    cpu_usage=$(top -bn1 | awk '/^%Cpu/ {print $2 + $4}')
    cpu="${cpu_icon} ${cpu_usage}%"

    # Get datetime
    datetime="${clock_icon} $(date "+%d-%m-%Y %H:%M")"

    get_net_speed
    download_speed="${download_icon} ${rx_speed}KB/s"
    upload_speed="${upload_icon} ${tx_speed}KB/s"
    apt_upgrades="${apt_upgrades_icon} $(get_apt_upgrades) updates"

    # Update status bar
    xsetroot -name " [ $wifi_status / $download_speed / $upload_speed / $apt_upgrades / $battery / $datetime ]"

    sleep 2  # Update every 2 seconds
done
