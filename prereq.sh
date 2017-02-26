#!/bin/bash
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

apt-get update && apt-get install -y flex bison gcc make autotools-dev npm
wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-1.5.tar.gz
tar xfvz jq-1.5.tar.gz
cd jq-1.5
./configure
make
make install
ln -s /usr/local/bin/jq /usr/bin/jq
rm -rf $SCRIPTPATH/jq-1.5/
rm -rf $SCRIPTPATH/jq-1.5.tar.gz
npm install -g belkin-wemo-command-line-tools
apt-get -y --purge autoremove
apt-get clean