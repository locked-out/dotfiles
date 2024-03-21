#!/usr/bin/env bash

lockScript=~/.config/hypr/scripts/lock.sh

swayidle timeout 600 "$lockScript" before-sleep "$lockScript" 
