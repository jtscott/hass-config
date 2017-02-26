#!/bin/bash
USERNAME=$(cat /config/netatmo/secrets.txt | cut -d , -f1)
PASSWORD=$(cat /config/netatmo/secrets.txt | cut -d , -f2)

#Start session
curl -s -c /config/netatmo/cookies.txt -b /config/netatmo/cookies.txt https://auth.netatmo.com/en-US/access/login -H 'User-Agent: curl 7.38.0 (arm-unknown-linux-gnueabihf) libcurl/7.38.0 OpenSSL/1.0.1t zlib/1.2.8 libidn/1.29 libssh2/1.4.3 librtmp/2.3' > /dev/null
#Grab CSRF
CSRF=$(cat /config/netatmo/cookies.txt | grep csrf | cut -f7 -d$'\t')
#Authenticate
curl -s -c /config/netatmo/cookies.txt -b /config/netatmo/cookies.txt https://auth.netatmo.com/en-US/access/login -H 'User-Agent: curl 7.38.0 (arm-unknown-linux-gnueabihf) libcurl/7.38.0 OpenSSL/1.0.1t zlib/1.2.8 libidn/1.29 libssh2/1.4.3 librtmp/2.3' --data 'ci_csrf_netatmo='"$CSRF"'&mail='"$USERNAME"'&pass='"$PASSWORD"'&log_submit=LOGIN&stay_logged=accept' > /dev/null
#Grab Status
ACCESSTOKEN=$(cat /config/netatmo/cookies.txt | grep netatmocomaccess_token | cut -f7 -d$'\t' | sed 's/%7C/|/g')
#jq grabs the vpn url from json, sed strips the quotes
VPNURL=$(curl -s -b /config/netatmo/cookies.txt https://my.netatmo.com/api/gethomedata -H 'Authorization: Bearer '"$ACCESSTOKEN"'' -H 'Origin: https://my.netatmo.com' -H 'Content-Type: application/json;charset=UTF-8' -H 'Accept: application/json, text/plain, */*' -H 'User-Agent: curl 7.38.0 (arm-unknown-linux-gnueabihf) libcurl/7.38.0 OpenSSL/1.0.1t zlib/1.2.8 libidn/1.29 libssh2/1.4.3 librtmp/2.3' -H 'Referer: https://my.netatmo.com/app/camera' --data-binary '{}' | jq .body.homes[0].cameras[0].vpn_url | sed -e 's/^"//' -e 's/"$//')
#Send the switch
curl -s "$VPNURL/command/changestatus?status=$1"  > /dev/null