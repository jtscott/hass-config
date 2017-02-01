#!/bin/bash
#Instructions https://community.home-assistant.io/t/withings-scales/4853/13?u=jscolp
USERNAME=$(cat /home/pi/.homeassistant/withings/secrets.txt | cut -d , -f1)
PASSWORD=$(cat /home/pi/.homeassistant/withings/secrets.txt | cut -d , -f2)
CURUSER=$(cat /home/pi/.homeassistant/withings/secrets.txt | cut -d , -f3)
DEVICEID=$(cat /home/pi/.homeassistant/withings/secrets.txt | cut -d , -f4)

#Authenticate
curl -s -c /home/pi/.homeassistant/withings/cookies.txt -b /home/pi/.homeassistant/withings/cookies.txt 'https://account.withings.com/connectionuser/account_login?appname=my2&appliver=a9467957&r=https%3A%2F%2Fhealthmate.withings.com%2F' --data 'email='"$USERNAME"'&password='"$PASSWORD"'&is_admin=' > /dev/null
#Grab Session
SESSIONKEY=$(cat /home/pi/.homeassistant/withings/cookies.txt | grep session | cut -f7 -d$'\t')
#Grab Temperature
curl -s -b /home/pi/.homeassistant/withings/cookies.txt "https://healthmate.withings.com/index/service/v2/measure" -H "Cookie: session_key="$SESSIONKEY"; current_user="$CURUSER"" --data "sessionid="$SESSIONKEY"&meastype=12"%"2C35&deviceid="$DEVICEID"&appname=my2&appliver=a9467957&apppfm=web&action=getmeashf" | jq .body.series[0].data[-1].value