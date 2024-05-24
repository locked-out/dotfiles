#!/usr/bin/env bash

# connections=`nmcli connection show --active | grep -v ' loopback ' | tail -n +2 | count`
networks=`nmcli device wifi list --rescan yes | ~/.config/waybar/scripts/readwifitable.py --no-duplicates BARS SSID | grep -ve '--$'` 

selection=`wofi -im --dmenu <<< "$networks" | cut -f 2`

if [[ -n $selection ]]; then
  active=`nmcli -m multiline connection show --active | grep "$selection" | head -c 5`

  if [[ $active = "NAME:" ]]; then
    nmcli device disconnect wlan0
  else
    known_networks=`nmcli connection show | grep wifi | grep "$selection"`
    if [[ -z $known_networks ]]; then   
      kitty ~/.config/waybar/scripts/wifiaskpassword.sh "$selection"
    else
      nmcli device wifi connect "$selection"
    fi
  fi
fi

