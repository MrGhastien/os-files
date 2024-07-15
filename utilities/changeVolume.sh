#!/bin/bash

msgTag="volume-indic"

if [[ "$1" -eq "mute" ]]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
else
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "$@"
fi

mixerOutput="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | tail -1)"
volume="$(echo ${mixerOutput} | awk '{print $2}')"
volume="$(echo "${volume}*100" | bc)"
volume="${volume%.*}"
status="$(echo ${mixerOutput} | awk '{print $3}')"
 
if [[ -z "$status" ]]; then 
   dunstify -a "changeVolume" -u low -t 1500 -h string:x-dunst-stack-tag:$msgTag \
           -h int:value:"$volume" "Volume : ${volume}%"
else
    dunstify -a "changeVolume" -u low -t 1500 -h string:x-dunst-stack-tag:$msgTag \
             -h int:value:"$volume" "Volume : ${volume}% (Muted)"
fi
