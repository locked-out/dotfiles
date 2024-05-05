#!/usr/bin/env bash

state=`bluetoothctl show | grep Powered | awk '{print $2}'`
if [[ $state == 'yes' ]]; then    
  devices=`bluetoothctl devices Paired` 

  selection=`cut -d ' ' -f "3-" <<< "$devices" | wofi -i --dmenu`
  selection=`grep "$selection" <<< "$devices" | cut -d ' ' -f 2`


  connect=`xargs bluetoothctl info <<< "$selection" | grep "Connected:" | cut -d ' ' -f 2`

  if [ "$connect" = "yes" ]; then
    connect="disconnect"
  else
    connect="connect"
  fi

  bluetoothctl "$connect" "$selection"
fi
