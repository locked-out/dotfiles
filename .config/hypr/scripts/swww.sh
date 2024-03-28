#!/usr/bin/env bash

# Check swww daemon
swww query
if [ $? -eq 1 ] ; then
    swww-daemon &
fi
swww img ~/.config/hypr/background.jpg

