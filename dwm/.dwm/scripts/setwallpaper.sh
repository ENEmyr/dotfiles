#!/usr/bin/env bash
choice=$(sxiv -rto $HOME/Pictures/Wallpapers/)
echo $choice
if [[ ! $choice ]]; then
	echo "Choose an image to set as the wallpaper"; exit 1
else
	echo "setting wallpaper"
	nitrogen --set-scaled $choice --save
fi
