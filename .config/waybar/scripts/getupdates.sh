#!/usr/bin/env bash

updates=`(paru -Qu) | wc -l`
if [[ $updates != 0 ]]; then
# updates="2"
  echo " $updates"
fi
