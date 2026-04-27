#!/usr/bin/env bash

action=$(echo -e "test\nswitch" | rofi -dmenu -p "nixos-rebuild");
command="sudo nixos-rebuild ${action} --flake ~/nixos-config/nixos#${NIX_FLAKE_HOST}"

alacritty -e bash -c '
cd ~/nixos-config/nixos
while true; do
  clear
  if [[ -n "$(git ls-files --others --exclude-standard)" ]]; then
  printf "Config contains untracked files! Continue? [y/n]: "
  read -r -n 1 key
  printf "\n\n"
  if [[ "$key" != "y" && "$key" != "Y" ]]; then
    exit 1
  fi
fi
  eval "$0"
  printf "\n\nPress r to rerun, any other key to close this window"
  read -rsn 1 key
  [[ $key == "r" ]] || break
done
' "$command"