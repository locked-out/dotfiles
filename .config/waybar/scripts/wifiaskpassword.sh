#!/usr/bin/env bash

echo "Password for $1:"
read -s password
echo "Authenticating..."
nmcli device wifi connect "$1" password "$password"
sleep 2
