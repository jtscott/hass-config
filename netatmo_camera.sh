#!/bin/bash
USERNAME=$(grep email_account secrets.yaml | cut -d " " -f2)
PASSWORD=$(grep netatmo_password secrets.yaml | cut -d " " -f2)

if [ -z "$1" ]; then #Start main loop
	echo "Specify a command: on, off, status. e.g. ./netatmo_camera.sh status"
else
   
   #Grab Cookies & Form
	if [ ! -f .storage/netatmo_cookies ]; then
		curl -s -c .storage/netatmo_cookies 'https://auth.netatmo.com/en-us/access/login' -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'DNT: 1' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36' -H 'Sec-Fetch-User: ?1' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' -H 'Sec-Fetch-Site: none' -H 'Sec-Fetch-Mode: navigate' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' --compressed > .storage/netatmo_form	
	fi
	
	#Process Cookies
	AUTHNETATMOCOMLARAVEL_SESSION=$(grep authnetatmocomlaravel_session .storage/netatmo_cookies | cut -d$'\t'  -f7)
	#echo authnetatmocomlaravel_session $AUTHNETATMOCOMLARAVEL_SESSION
	XSRF=$(grep XSRF-TOKEN .storage/netatmo_cookies | cut -d$'\t'  -f7)
	#echo XSRF $XSRF
	CSRF=$(grep csrf-token .storage/netatmo_form | cut -d "\"" -f4)
	#echo CSRF $CSRF
	TOKEN=$(grep _token .storage/netatmo_form | cut -d "\"" -f6)
	#echo TOKEN $TOKEN
	BEARER=$(grep netatmocomaccess_token .storage/netatmo_cookies | cut -d$'\t'  -f7 | sed 's/%7C/|/g') #Replace %7C with | for Bearer usage
	#echo BEARER $BEARER
	
	# Authenticate & Setup
	if [ -z "$BEARER" ]; then
		echo authenticating
		curl -s -c .storage/netatmo_cookies -b .storage/netatmo_cookies 'https://auth.netatmo.com/access/postlogin' -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'Origin: https://auth.netatmo.com' -H 'Upgrade-Insecure-Requests: 1' -H 'DNT: 1' -H 'Content-Type: application/x-www-form-urlencoded' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36' -H 'Sec-Fetch-User: ?1' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3' -H 'Sec-Fetch-Site: same-origin' -H 'Sec-Fetch-Mode: navigate' -H 'Referer: https://auth.netatmo.com/en-us/access/login' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' -H 'Cookie: netatmocomci_csrf_cookie_na='"$CSRF"'; netatmocomlast_app_used=app_camera; XSRF-TOKEN='"$XSRF"'; authnetatmocomlaravel_session='"$AUTHNETATMOCOMLARAVEL_SESSION"'' --data 'email='"$USERNAME"'&password='"$PASSWORD"'&stay_logged=on&_token='"$TOKEN"'' --compressed > /dev/null
		
		#Process Cookies
		BEARER=$(grep netatmocomaccess_token .storage/netatmo_cookies | cut -d$'\t'  -f7 | sed 's/%7C/|/g') #Replace %7C with | for Bearer usage
	fi
	
	#Fetch VPN URL
	VPNURL=$(curl -s -c .storage/netatmo_cookies -b .storage/netatmo_cookies 'https://app.netatmo.net/api/gethomedata' -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'Accept: application/json, text/plain, */*' -H 'Origin: https://my.netatmo.com' -H 'Authorization: Bearer '"$BEARER"'' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36' -H 'DNT: 1' -H 'Content-Type: application/json;charset=UTF-8' -H 'Sec-Fetch-Site: cross-site' -H 'Sec-Fetch-Mode: cors' -H 'Referer: https://my.netatmo.com/app/security' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' --data-binary '{}' --compressed | jq .body.homes[0].cameras[0].vpn_url | sed -e 's/^"//' -e 's/"$//')
	
	#Camera Functions
	if [ $1 = "status" ]; then
		curl -s -c .storage/netatmo_cookies -b .storage/netatmo_cookies 'https://app.netatmo.net/api/gethomedata' -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'Accept: application/json, text/plain, */*' -H 'Origin: https://my.netatmo.com' -H 'Authorization: Bearer '"$BEARER"'' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36' -H 'DNT: 1' -H 'Content-Type: application/json;charset=UTF-8' -H 'Sec-Fetch-Site: cross-site' -H 'Sec-Fetch-Mode: cors' -H 'Referer: https://my.netatmo.com/app/security' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' --data-binary '{}' --compressed | jq .body.homes[0].cameras[0].status | sed -e 's/^"//' -e 's/"$//'
	elif [ $1 = "on" ]; then
		curl -s ''"$VPNURL"'/command/changestatus?status=on' -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'Accept: application/json, text/plain, */*' -H 'Origin: https://my.netatmo.com' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36' -H 'DNT: 1' -H 'Sec-Fetch-Site: cross-site' -H 'Sec-Fetch-Mode: cors' -H 'Referer: https://my.netatmo.com/app/camera' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' --compressed > /dev/null
	elif [ $1 = "off" ]; then
		curl -s ''"$VPNURL"'/command/changestatus?status=off' -H 'Connection: keep-alive' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'Accept: application/json, text/plain, */*' -H 'Origin: https://my.netatmo.com' -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36' -H 'DNT: 1' -H 'Sec-Fetch-Site: cross-site' -H 'Sec-Fetch-Mode: cors' -H 'Referer: https://my.netatmo.com/app/camera' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' --compressed > /dev/null
	fi

fi #End main loop