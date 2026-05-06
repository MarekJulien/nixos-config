#!/usr/bin/env bash

# wallpaper daemon
awww-daemon &
awww img ~/Pictures/wallpapers/wallpaper.png

# networkmanager applet
nm-applet --indicator &

# waybar
~/nixos-config/scripts/load-waybar.sh

# notification daemon
dunst
