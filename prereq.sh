#!/bin/bash
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

if [ ! -f /usr/bin/jq ]; then
  wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64
  chmod +x jq-linux64
  mv jq-linux64 /usr/bin/jq
fi

pip3 install --upgrade --force-reinstall netdisco
apt-get update && apt-get --yes --force-yes upgrade
apt-get install --yes --force-yes avahi-daemon avahi-utils
update-rc.d dbus enable
update-rc.d avahi-daemon enable
/etc/init.d/dbus start
/etc/init.d/avahi-daemon start