#!/bin/bash
USERNAME=$(cat /home/pi/.homeassistant/netatmo/secrets.txt | cut -d , -f3)
PASSWORD=$(cat /home/pi/.homeassistant/netatmo/secrets.txt | cut -d , -f4)

curl -s 'https://4.vpn.netatmo.net/10.255.4.161/'"$USERNAME"'/'"$PASSWORD"',/command/changestatus?status=off'  > /dev/null