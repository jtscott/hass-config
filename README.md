# My Home Assistant Configuration
Check out all the cool things you can do with [Home Assistant](https://home-assistant.io/) on a RPi3. Note that Netatmo Welcome and Withings devices have custom scripts for their integration.

## Requirements
- Install [jq 1.5 manually](https://stedolan.github.io/jq/download/). RPi raspian jessie repos have old versions that have a bug accessing the last item in an array. Needed for withings scripts.
- NPM for [Belkin-WeMo-Command-Line-Tools](https://github.com/agilemation/Belkin-WeMo-Command-Line-Tools)
- Curl

## Shout Out
- Check out Facu ZAK's Roomba 980 [Library](https://github.com/koalazak/dorita980) and [Rest API](https://github.com/koalazak/rest980) it saved me a lot of work!
- All the [HASS examples](https://home-assistant.io/cookbook/) and contributors.

## Layout
- The *Home* group is the default_view and shows relevant house based sensors.
- The *Calgary* group is a local dashboard with the most useful region based information. Designed to start the day quickly and get us out the door.
- The *Debug* group shows automation toggles and HASS version check.

## Screenshots
![Home Screen](https://www.dropbox.com/s/xlvqcir6aca3zv0/home.png?raw=1)
![Calgary](https://www.dropbox.com/s/ng2ejh96jn8g52k/calgary.PNG?raw=1)
![Debug](https://www.dropbox.com/s/qx3ibaoaw93pvze/debug.PNG?raw=1)

## Devices
- Wink Hub 2
- Nest Thermostat
- Wemo Light & Insight Switches
- Roomba 980
- Withings WS-50
- Nvidia Shield TV
- Netatmo Welcome
- Unifi Wireless
- Samsung UN65F8000
- Harmony Hub
- Plex Media Server
- [iPhone Live-Reporter+](https://itunes.apple.com/us/app/live-reporter-security-and-broadcasting-camera/id1033020349?mt=8)

## Automations
- Turn the inside camera on/off if we leave/arrive.
- Turn the patio light on/off with the sun if we are away.
- Turn the patio light off if we arrive home.
- Commute high traffic notifications.
- Roomba scheduling and docking.
- Climate control based on internal and external temperatures.