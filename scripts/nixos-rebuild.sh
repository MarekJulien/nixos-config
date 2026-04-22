#!/usr/bin/env bash

action=$(echo -e "test\nswitch" | rofi -dmenu -p "nixos-rebuild");
command="sudo nixos-rebuild ${action} --flake ~/nixos-config/nixos#${NIX_FLAKE_HOST}"

alacritty -e bash -c '
while true; do
  clear
  eval "$0"
  printf "\n\nPress r to rerun, any other key to close this window"
  read -rsn 1 key
  [[ $key == "r" ]] || break
done
' "$command"