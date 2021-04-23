#!/bin/sh

DELAY=500 # in millisec

send_notify(){
    title=$(playerctl -p firefox metadata xesam:title)
    artist=$(playerctl -p firefox metadata xesam:artist)
    cover_img=$(playerctl -p firefox metadata mpris:artUrl | tail -c +8)
    notify-send "Firefox Player" "Title: $title\nArtist: $artist" --icon=$cover_img
}

watch(){
    all_files=$(ls $HOME/.mozilla/firefox/firefox-mpris)
    while true; do
        curr_files=$(ls $HOME/.mozilla/firefox/firefox-mpris)
        [ ! "$all_files" = "$curr_files" ] && send_notify && all_files=$curr_files
        sleep $(printf %.1f "$(($DELAY))e-3")
    done
}

if [ "$1" = 'send' ]; then
    send_notify
else
    command -v onchange &> /dev/null && onchange -d $DELAY $HOME/.mozilla/firefox/firefox-mpris/ -- sh $HOME/Scripts/firefox_playerctl_hooker.sh send
    command -v onchange &> /dev/null || watch
fi
