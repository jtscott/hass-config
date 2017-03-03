#!/bin/bash
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd -P`
popd > /dev/null

USERNAME=$(cat $SCRIPTPATH/secrets.txt | cut -d , -f1)
PASSWORD=$(cat $SCRIPTPATH/secrets.txt | cut -d , -f2)

#Start session
curl -s -c $SCRIPTPATH/cookies.txt -b $SCRIPTPATH/cookies.txt https://auth.netatmo.com/en-US/access/login -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36 Edge/14.14359' > /dev/null
#Grab CSRF
CSRF=$(cat $SCRIPTPATH/cookies.txt | grep csrf | cut -f7 -d$'\t')
#Authenticate
curl -s -c $SCRIPTPATH/cookies.txt -b $SCRIPTPATH/cookies.txt https://auth.netatmo.com/en-US/access/login -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36 Edge/14.14359' --data 'ci_csrf_netatmo='"$CSRF"'&mail='"$USERNAME"'&pass='"$PASSWORD"'&log_submit=LOGIN&stay_logged=accept' > /dev/null
#Grab Status
ACCESSTOKEN=$(cat $SCRIPTPATH/cookies.txt | grep netatmocomaccess_token | cut -f7 -d$'\t' | sed 's/%7C/|/g')
#jq grabs the status from json, sed strips the quotes
curl -s -b $SCRIPTPATH/cookies.txt https://my.netatmo.com/api/gethomedata -H 'Authorization: Bearer '"$ACCESSTOKEN"'' -H 'Origin: https://my.netatmo.com' -H 'Content-Type: application/json;charset=UTF-8' -H 'Accept: application/json, text/plain, */*' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.82 Safari/537.36 Edge/14.14359' -H 'Referer: https://my.netatmo.com/app/camera' --data-binary '{}' | jq .body.homes[0].cameras[0].status | sed -e 's/^"//' -e 's/"$//'