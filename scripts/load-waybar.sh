#!/usr/bin/env bash

waybarconfpath="$HOME/nixos-config/config-files/waybar"

# kill all existing processes
killall waybar

# start waybar
output=$(waybar -c "$waybarconfpath/config" -s "$waybarconfpath/style.css")
if [ "$output" ]; then
      dunstify -u critical "Waybar failed to start" "$output" | true
fi
