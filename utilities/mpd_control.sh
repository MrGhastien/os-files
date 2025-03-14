#!/bin/sh

mpc_output="$(MPD_HOST="${XDG_RUNTIME_DIR}/mpd/mpd.socket" mpc -f '%artist% - %title% [(%album%)]' "$@" | head -n 1)"



dunstify -a 'music_player' -u low -t 5000 -h string:x-dunst-stack-tag:music_player "Playing" "Current song:
${mpc_output}"
