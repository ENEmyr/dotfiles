#!/usr/bin/env bash
if pgrep -x "picom" > /dev/null
then
	killall picom
else
	picom -b --config $HOME/.config/enemy-dwm/picom.conf
fi
