#!/usr/bin/env bash

# wallpaper daemon
swww init &
swww img ~/Pictures/wallpapers/wallpaper.png &

# networkmanager applet
nm-applet --indicator &

# waybar
~/nixos-config/scripts/load-waybar.sh

# notification daemon
dunst