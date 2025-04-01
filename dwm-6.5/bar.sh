#!/bin/sh

# Pastikan DISPLAY terdeteksi
export DISPLAY=$(echo $DISPLAY)

# Ikon Nerd Font
wifi_icon=""  # WiFi
battery_icon="󰁹"  # Baterai
ram_icon="󰍛"  # RAM
cpu_icon="󰻠"  # CPU
clock_icon="󰥔"  # Jam

while true; do
    # Cek apakah X server masih berjalan tanpa mengubah status bar
    if ! xdpyinfo >/dev/null 2>&1; then
        echo " "
        exit 1
    fi

    # Ambil SSID Wi-Fi
    wifi_ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes" {print $2}')
    wifi_status="${wifi_icon} ${wifi_ssid:-Disconnected}"

    # Ambil status baterai
    battery="${battery_icon} $(cat /sys/class/power_supply/BAT1/capacity)%"

    # Ambil penggunaan RAM
    ram_used=$(free -m | awk '/^Mem/ {print $3}')
    ram_total=$(free -m | awk '/^Mem/ {print $2}')
    ram="${ram_icon} ${ram_used}/${ram_total}MB"

    # Ambil penggunaan CPU
    cpu_usage=$(top -bn1 | awk '/^%Cpu/ {print $2 + $4}')
    cpu="${cpu_icon} ${cpu_usage}%"

    # Ambil tanggal & waktu
    datetime="${clock_icon} $(date "+%d-%m-%Y %H:%M")"

    # Gabungkan ke status bar pakai /
    xsetroot -name " [ $wifi_status / $battery / $ram / $datetime ]"

    sleep 2  # Update tiap 2 detik
done

