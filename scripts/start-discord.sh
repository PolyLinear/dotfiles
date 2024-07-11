#!/bin/bash

terminate=false

time="${1:-20:00}"
limit=$(date -d "$time" +%s) 2>/dev/null

if [ $terminate = true ]; then
	notify-send -u normal "Could not open discord" "focus mode is on!"
	exit 1
fi

#shellcheck disable=SC2181
if [ $? -ne 0 ]; then
	notify-send -u normal "Could not send time limit" "The provided time is invalid"
	exit 1
fi

if pgrep -f webcord >/dev/null || [ "$(date +%s)" -ge "$limit" ]; then
	webcord --enable-features=UseOzonePlatform --ozone-platform=wayland &
else
	notify-send -u normal "Could not open discord" "The current time is $(date +%H:%M), but discord can only open after ${time}"

fi

exit 0
