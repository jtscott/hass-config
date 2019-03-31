#!/bin/bash
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

#Install JQ 1.5
if [ ! -f /usr/bin/jq ]; then
  wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
  chmod +x jq-linux64
  mv jq-linux64 /usr/bin/jq
fi

#Fix Chromecast
apt-get update && apt-get --yes --force-yes upgrade
apt-get install --yes --force-yes git avahi-daemon avahi-utils libavahi-compat-libdnssd-dev libgmp-dev libmpfr-dev libmpc-dev
update-rc.d dbus enable
update-rc.d avahi-daemon enable
/etc/init.d/dbus start
/etc/init.d/avahi-daemon start

# #Fix Roomba
# git clone https://github.com/NickWaterton/Roomba980-Python.git /tmp/Roomba980-Python
# rm -rf /usr/local/lib/python3.7/site-packages/roomba/*
# cp -rf /tmp/Roomba980-Python/roomba/* /usr/local/lib/python3.7/site-packages/roomba/
# rm -rf /tmp/*