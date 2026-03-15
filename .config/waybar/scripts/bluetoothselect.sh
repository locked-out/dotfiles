#!/usr/bin/env bash

state=`echo show | bluetoothctl | grep Powered | awk '{print $2}'`
if [[ $state == 'yes' ]]; then    
  devices=`echo devices Paired | bluetoothctl | grep '^Device'` 

  selection=`cut -d ' ' -f "3-" <<< "$devices" | wofi -i --dmenu`
  selection=`grep "$selection" <<< "$devices" | cut -d ' ' -f 2`


  connect=`echo "info $selection" | bluetoothctl | grep "Connected:" | cut -d ' ' -f 2 `

  if [ "$connect" = "yes" ]; then
    connect="disconnect"
  else
    connect="connect"
  fi

  bluetoothctl "$connect" "$selection"
fi
