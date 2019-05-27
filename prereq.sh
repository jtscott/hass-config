#!/bin/bash
#set zigbee channel to 25
sed -i 's/channel=15/channel=25/g' /usr/local/lib/python3.7/site-packages/bellows/zigbee/application.py

#Install JQ 1.5
if [ ! -f /usr/bin/jq ]; then
  wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
  chmod +x jq-linux64
  mv jq-linux64 /usr/bin/jq
fi

#Install Dependencies
#Chromecast, Homekit, etc.
apt-get update && apt-get --yes --force-yes upgrade
apt-get install --yes --force-yes avahi-daemon avahi-utils libavahi-compat-libdnssd-dev libgmp-dev libmpfr-dev libmpc-dev
update-rc.d dbus enable
update-rc.d avahi-daemon enable
/etc/init.d/dbus start
/etc/init.d/avahi-daemon start