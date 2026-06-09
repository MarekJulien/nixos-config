#!/usr/bin/env bash

selected_option=$(
    printf "suspend\nhibernate\njust lock\n" |
    rofi -dmenu -p "Lock screen options:"
)

if [ -z "$selected_option" ]; then
  exit
fi

# Execute selected option
case "$selected_option" in
  suspend)
    systemctl suspend
    ;;
  hibernate)
    systemctl hibernate
    ;;
  "just lock")
    return
    ;;
esac

# Lock screen
hyprlock
