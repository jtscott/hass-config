#!/bin/bash
USERNAME=$(cat /home/pi/.homeassistant/netatmo/secrets.txt | cut -d , -f3)
PASSWORD=$(cat /home/pi/.homeassistant/netatmo/secrets.txt | cut -d , -f4)
ENDPOINT=$(cat /home/pi/.homeassistant/netatmo/secrets.txt | cut -d , -f5)

curl -s 'https://4.vpn.netatmo.net/'"$ENDPOINT"'/'"$USERNAME"'/'"$PASSWORD"',/command/changestatus?status='"$1"''  > /dev/null