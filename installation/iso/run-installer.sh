#!/usr/bin/env bash
set -eu

##### FUNCTIONS #####
check_connection() {
    if ping -c 1 8.8.8.8 &>/dev/null; then
        return 0
    else
        return 1
    fi
}
connect_to_internet() {
    if check_connection; then
        echo "Internet connection detected."
        return
    fi
    echo "No internet detected. Trying to connect via Wi-Fi..."
    
    echo "Available networks:"
    nmcli device wifi list

    read -p "Enter your SSID: " SSID

    nmcli device wifi connect "$SSID" --ask

    sleep 5
    if check_connection; then
        echo "Connected successfully!"
    else
        echo "Failed to connect. Please check your Wi-Fi credentials or network."
        exit 1
    fi
}

##### SCRIPT #####

##### Connect to internet #####
connect_to_internet

##### Clone repository #####
cd ~
echo "Cloning repository"
rm -rf nixos-config || true
git clone https://github.com/MarekJulien/nixos-config.git

##### Run installer #####
~/nixos-config/installation/scripts/nixos-installer.sh

