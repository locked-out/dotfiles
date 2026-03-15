#!/usr/bin/env bash

STATE=`echo show | bluetoothctl | grep Powered | awk '{print $2}'`
if [[ $STATE == 'yes' ]]; then    
    bluetoothctl power off    
else
    bluetoothctl power on
fi
