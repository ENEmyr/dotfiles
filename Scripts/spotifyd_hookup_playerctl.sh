#!/bin/sh
[[ ! -d "$HOME/.tmp" ]] && mkdir "$HOME/.tmp"
artUrl=$(playerctl -p spotifyd metadata mpris:artUrl)
curl $artUrl -o $HOME/.tmp/spotifyd-tmp-artimg.png 
wait
song=$(playerctl -p spotifyd metadata --format "Title: {{ title }}\nArtist: {{ artist }}\nAlbum: {{ album }}")
notify-send "Spotify" "$song" --icon=$HOME/.tmp/spotifyd-tmp-artimg.png
rm $HOME/.tmp/spotifyd-tmp-artimg.png
