#!/bin/bash

discord="webcord --enable-features=UseOzonePlatform --ozone-platform=wayland"
time="${1:=20:00}"
limit=$(date -d "$time" +%s) 2>/dev/null

if [ $? -ne 0 ]; then
	notify-send -u normal "Could not send time Limit" "The Provided time is invalid"
	exit 1
fi

if pgrep -f webcord >/dev/null || [ "$(date +%s)" -ge "$limit" ]; then
	eval "$discord"

else
	notify-send -u normal "Could not open discord" "The current time is $(date +%H:%M), but discord can only open after ${time}"

fi

exit 0
