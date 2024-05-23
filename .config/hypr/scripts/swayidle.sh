#!/usr/bin/env bash

lockScript=swaylock

swayidle timeout 600 "$lockScript" before-sleep "$lockScript" 
