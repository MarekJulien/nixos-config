#!/usr/bin/env bash

# waybar
~/nixos-config/scripts/load-waybar.sh &

# wallpaper daemon
awww-daemon &

# notification daemon
dunst &

# networkmanager applet
nm-applet --indicator &
