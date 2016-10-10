# My Home Assistant Configuration
Check out all the cool things you can do with [Home Assistant](https://home-assistant.io/) on an RPi3. Note that Netatmo Welcome, Withings, and Roomba devices have custom scripts for their integration.
## Requirements
- Install jq 1.5 manually. RPi raspian jessie repos have old versions that have a bug accessing the last item in an array. Needed for withings scripts.
- NPM for Roomba/dorita980
- Curl
## Shout Out
- Check out [Facu ZAK's Roomba 980 Library](https://github.com/koalazak/dorita980) it saved me a lot of work!
- All the [HASS examples](https://home-assistant.io/cookbook/) and contributors.
## Layout
- The *Home* group is the default_view and shows relevant house based sensors.
- The *Calgary* group is a local dashboard with the most useful region based information. Designed to start the day quickly and get us out the door.
- The *Debug* group shows automation toggles and HASS version check.
## Devices
- RPi3 on Raspian Jessie
- Nest
- Wemo Light Switches
- Roomba 980
- Withings WS-50
- Nvidia Shield TV
- Netatmo Welcome
- Unifi Wireless
## To-do & Problems
- Plex Media Server isn't working?
- Samsung UN65F8000
- Turn off the patio light when we arrive home.
