#!/bin/sh

if [ ! $(pgrep "spotifyd" ) ]; then
	notify-send "Spotifyd is Running Now" --icon="$HOME/.config/spotifyd/spotify.png"
    spotifyd
fi
spt
wait
pidof spotifyd && killall spotifyd
