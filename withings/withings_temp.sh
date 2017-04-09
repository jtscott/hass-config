#!/bin/bash
#Instructions https://community.home-assistant.io/t/withings-scales/4853/13?u=jscolp
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null
USERNAME=$(cat $SCRIPTPATH/secrets.txt | cut -d , -f1)
PASSWORD=$(cat $SCRIPTPATH/secrets.txt | cut -d , -f2)
CURUSER=$(cat $SCRIPTPATH/secrets.txt | cut -d , -f3)
DEVICEID=$(cat $SCRIPTPATH/secrets.txt | cut -d , -f4)

#Grab CSRFTOKEN
curl -s 'https://account.withings.com/connectionuser/account_login?appname=my2&appliver=df77ca8f&r=https%3A%2F%2Fhealthmate.withings.com%2F' > $SCRIPTPATH/csrf.txt
CSRFTOKEN=$( grep csrf $SCRIPTPATH/csrf.txt | awk -F'"' '$0=$6')
#Authenticate
curl -s -c $SCRIPTPATH/cookies.txt -b $SCRIPTPATH/cookies.txt 'https://account.withings.com/connectionuser/account_login?appname=my2&appliver=df77ca8f&r=https%3A%2F%2Fhealthmate.withings.com%2F' -H 'Origin: https://account.withings.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.8' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Referer: https://account.withings.com/connectionuser/account_login?appname=my2&appliver=df77ca8f&r=https%3A%2F%2Fhealthmate.withings.com%2F' -H 'Connection: keep-alive' -H 'DNT: 1' --data 'email='"$USERNAME"'&password='"\"$PASSWORD\""'&is_admin=&csrf_token='"$CSRFTOKEN"'' --compressed > /dev/null
#Grab Session
SESSIONKEY=$(cat $SCRIPTPATH/cookies.txt | grep session | cut -f7 -d$'\t')
#Grab Temperature
curl -s -c $SCRIPTPATH/cookies.txt -b $SCRIPTPATH/cookies.txt "https://healthmate.withings.com/index/service/v2/measure" -H "Cookie: session_key="$SESSIONKEY"; current_user="$CURUSER"" -H 'Origin: https://healthmate.withings.com' --data "sessionid="$SESSIONKEY"&meastype=12"%"2C35&deviceid="$DEVICEID"&appname=my2&appliver=a9467957&apppfm=web&action=getmeashf" | jq .body.series[0].data[-1].value