#!/usr/bin/env bash

action=$(echo -e "test\nswitch" | rofi -dmenu -p "nixos.rebuild");
command="sudo nixos-rebuild ${action} --flake ~/nixos-config/nixos#${NIX_FLAKE_HOST}"

alacritty -e bash -c "$command; printf '\n\nPress any key to close this window'; read -sn 1"