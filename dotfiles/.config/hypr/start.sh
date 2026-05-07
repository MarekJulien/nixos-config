#!/usr/bin/env bash

# waybar
~/nixos-config/scripts/load-waybar.sh &

# wallpaper daemon
wallpapers="$HOME/Pictures/wallpapers"
awww-daemon &
awww img "${wallpapers}/default" &

# notification daemon
dunst &

# networkmanager applet
nm-applet --indicator &
