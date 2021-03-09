#!/bin/sh
#place into /etc/X11/xinit/xinitrc.d/
xrandr --output DVI-D-0 --mode 1920x1080 --pos 969x0 --rotate normal --output HDMI-0 --mode 1920x1080 --pos 0x1080 --rotate normal --output DP-0 --primary --mode 1920x1080 --rate 144 --pos 1920x1080 --rotate normal --output DP-1 --off
