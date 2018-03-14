#!/bin/bash
#Instructions https://community.home-assistant.io/t/withings-scales/4853/13?u=jscolp
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
USERNAME=$(cat $SCRIPTPATH/secrets.txt | cut -d , -f1)
PASSWORD=$(cat $SCRIPTPATH/secrets.txt | cut -d , -f2)
CURUSER=$(cat $SCRIPTPATH/secrets.txt | cut -d , -f3)
DEVICEID=$(cat $SCRIPTPATH/secrets.txt | cut -d , -f4)
STARTDATE=$(date +%s -d "28 day ago")
ENDDATE=$(date +%s)

#Authenticate
curl -s -c $SCRIPTPATH/cookies.txt -b $SCRIPTPATH/cookies.txt 'https://account.health.nokia.com/connectionwou/account_login?r=https%3A%2F%2Fdashboard.health.nokia.com%2F' -H 'Pragma: no-cache' -H 'Origin: https://account.health.nokia.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Cache-Control: no-cache' -H 'Referer: https://account.health.nokia.com/connectionwou/account_login?r=https%3A%2F%2Fdashboard.health.nokia.com%2F' -H 'Connection: keep-alive' -H 'DNT: 1' --data 'email='"$USERNAME"'&password='"$PASSWORD"'&is_admin=' --compressed > /dev/null
#Grab Session
SESSIONKEY=$(cat $SCRIPTPATH/cookies.txt | grep nokia | grep session | cut -f7 -d$'\t')
#Grab Temperature
curl -s -c $SCRIPTPATH/cookies.txt -b $SCRIPTPATH/cookies.txt 'https://scalews.withings.net/cgi-bin/v2/measure' -H 'Pragma: no-cache' -H 'Origin: https://dashboard.health.nokia.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36' -H 'Content-Type: text/plain;charset=UTF-8' -H 'Accept: */*' -H 'Cache-Control: no-cache' -H 'Referer: https://dashboard.health.nokia.com/'"$CURUSER"'/environment/'"$DEVICEID"'' -H 'Connection: keep-alive' -H 'DNT: 1' --data-binary 'meastype=35%2C12&deviceid='"$DEVICEID"'&userid='"$CURUSER"'&startdate='"$STARTDATE"'&enddate='"$ENDDATE"'&sessionid='"$SESSIONKEY"'&action=getmeashf&appname=hmw&apppfm=web&appliver=19fe0fa' --compressed | jq .body.series[1].data[0].value
