# My Home Assistant Configuration
Check out all the cool things you can do with [Home Assistant](https://home-assistant.io/).

## Layout
- The *Status* view shows things that are on, or open, or otherwise dynamic states we need to know about
- The *Outside* view is for things like the security panel, perimeter lights, etc.
- Each floor has its own view separated into 1 2 and B
- The *Pets* view watches our cat pals
- The *Weather* view is a dashboard with the most forecast information.
- The *City* view is a dashboard with the most useful region based information. Designed to start the day quickly and get us out the door.
- The *System* view shows the docker host status, version & firmware information, batteries, and signal strengths.

## Screenshots
### Status
![Status](https://www.dropbox.com/s/44zs82n1el5entx/status.PNG?raw=1)
### Outside
![Outside](https://www.dropbox.com/s/6de2yt740tui38s/outside.PNG?raw=1)
### 1F
![1F](https://www.dropbox.com/s/1qrztdywv4vlit2/1f.png?raw=1)
### 2F
![2F](https://www.dropbox.com/s/ablt91smnny837p/2f.PNG?raw=1)
### Basement
![BF](https://www.dropbox.com/s/yxtuqwuzb8ofd6n/bf.PNG?raw=1)
### Weather
![Weather](https://www.dropbox.com/s/y0ywfv9fs6z5m6j/weather.PNG?raw=1)
### City
![Calgary](https://www.dropbox.com/s/ng2ejh96jn8g52k/calgary.PNG?raw=1)
### System
![System](https://www.dropbox.com/s/tmg8tpoowa1brls/system.PNG?raw=1)

## Requirements
- Install [jq 1.5 manually](https://stedolan.github.io/jq/download/). Jessie repos have old versions that have a bug accessing the last item in an array. Needed for withings scripts.
- Curl
- Scripts based on Debian

## Custom Cards
- https://github.com/kalkih/mini-graph-card
- https://github.com/kalkih/simple-weather-card
- https://github.com/kalkih/mini-media-player
- https://github.com/thomasloven/lovelace-card-tools
- https://github.com/thomasloven/lovelace-slider-entity-row
- https://github.com/custom-cards/button-card
- https://github.com/custom-cards/tracker-card
- https://github.com/custom-cards/vertical-stack-in-card
- https://github.com/ciotlosm/custom-lovelace/tree/master/monster-card
- https://github.com/nervetattoo/simple-thermostat