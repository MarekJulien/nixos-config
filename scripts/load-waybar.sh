#!/usr/bin/env bash

waybarconfpath="$HOME/nixos-config/config-files/waybar"

# kill all existing processes
killall waybar

# start waybar
waybar -c $waybarconfpath/config -s $waybarconfpath/style.css &