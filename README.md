# My Home Assistant Configuration
Check out all the cool things you can do with [Home Assistant](https://home-assistant.io/). Note that Netatmo Welcome and Withings devices have custom scripts for their integration.

## Requirements
- Install [jq 1.5 manually](https://stedolan.github.io/jq/download/). Jessie repos have old versions that have a bug accessing the last item in an array. Needed for withings scripts.
- Curl
- Scripts based on Debian

## Shout Out
- Check out Facu ZAK's Roomba 980 [Library](https://github.com/koalazak/dorita980) and [Rest API](https://github.com/koalazak/rest980)!
- All the [HASS examples](https://home-assistant.io/cookbook/) and contributors.

## Layout
- The *Home* group is the default_view and shows relevant house based sensors.
- The *Weather* group is a dashboard with the most forecast information.
- The *City* group is a dashboard with the most useful region based information. Designed to start the day quickly and get us out the door.
- The *System* group shows the docker host status, version & firmware information, batteries, and signal strengths.
- The *Automations* group has toggles for various automations.

## Screenshots
![Home Screen](https://www.dropbox.com/s/xlvqcir6aca3zv0/home.png?raw=1)
![Security](https://www.dropbox.com/s/uh25niflfb2dcgt/security.PNG?raw=1)
![Weather](https://www.dropbox.com/s/y0ywfv9fs6z5m6j/weather.PNG?raw=1)
![Calgary](https://www.dropbox.com/s/ng2ejh96jn8g52k/calgary.PNG?raw=1)
![System](https://www.dropbox.com/s/qx3ibaoaw93pvze/debug.PNG?raw=1)
![Automations](https://www.dropbox.com/s/ks0phkdk0q33xdx/automation.PNG?raw=1)

## Devices
- Arlo Pro Cameras
- Chamberlain MyQ
- Ecobee Thermostat
- Harmony Hub
- Nvidia Shield TV
- Roomba 980
- Samsung UN65F8000
- Unifi Wireless
- Wemo Insight Switch
- Wink Hub 2

## Automations
- Turn the inside camera on/off if we leave/arrive.
- Turn the patio light on/off with the sun if we are away.
- Turn the patio light off if we arrive home.
- Commute high traffic notifications.
- Roomba scheduling and docking.
- Climate control based on internal and external temperatures.
