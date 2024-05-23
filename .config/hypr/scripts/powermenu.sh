#!/usr/bin/env bash

op=$( echo -e "  Poweroff\n  Reboot\n󰤄  Hibernate\n󰏤  Suspend\n  Lock\n  Logout" | \
  wofi --sort-order=default --prompt="Power Options" -i --dmenu | \
  awk '{print tolower($2)}' )


case $op in 
        poweroff)
                ;&
        reboot)
                ;&
        hibernate)
                ;&
        suspend)
                systemctl $op
                ;;
        lock)
                hyprlock
                ;;
        logout)
                hyprctl dispatch exit
                ;;
esac
