#!/bin/sh

SwitchMonitor() {
	PrimaryID=$(bspc query -M -m HDMI-0)
	SecondaryID=$(bspc query -M -m DVI-D-0)
	MonitorID=$(bspc query -M -m focused)
	if [ "$MonitorID" = "$PrimaryID" ]; then
		bspc monitor -f "$SecondaryID"
	else
		bspc monitor -f "$PrimaryID"
	fi
}

SwitchMonitor
