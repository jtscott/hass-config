#!/bin/bash
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

apt-get update && apt-get upgrade -y
apt-get install -y flex bison gcc make autotools-dev npm fontconfig 
npm install -g belkin-wemo-command-line-tools
wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-1.5.tar.gz
wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
tar xfvz jq-1.5.tar.gz
tar xfvj phantomjs-2.1.1-linux-x86_64.tar.bz2
mv phantomjs-2.1.1-linux-x86_64 phantomjs
cd jq-1.5
./configure
make
make install
ln -s /usr/local/bin/jq /usr/bin/jq
ln -s $SCRIPTPATH/phantomjs/bin/phantomjs /usr/bin/phantomjs
rm -rf $SCRIPTPATH/jq-1.5/
rm -rf $SCRIPTPATH/jq-1.5.tar.gz
rm -rf $SCRIPTPATH/phantomjs-2.1.1-linux-x86_64.tar.bz2