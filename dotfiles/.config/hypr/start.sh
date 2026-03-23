#!/usr/bin/env bash

# wallpaper daemon
swww init &
swww img ~/Pictures/wallpapers/wallpaper.png &

# networkmanager applet
nm-applet --indicator &

# desktop bar
waybar &

# notification daemon
dunst