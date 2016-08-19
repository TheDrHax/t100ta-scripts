#!/bin/bash

# Prepare environment
export DISPLAY=$(w | sed -n 's/.* \(:[0-9]\) .*/\1/p')
USER=$(who | grep :0 | awk '{print $1}')
export XAUTHORITY="/home/$USER/.Xauthority"

# Functions
function is_opened {
    return $(grep -q "open" /proc/acpi/button/lid/LID/state)
}

# -------- #

while true; do
	if is_opened; then
		if [ ! $LIDSTATE ] || [ $LIDSTATE == "CLOSED" ]; then
			LIDSTATE="OPENED"; echo $LIDSTATE
			modprobe hid_multitouch
			xset dpms force on
		fi
	else
		if [ ! $LIDSTATE ] || [ $LIDSTATE == "OPENED" ]; then
			LIDSTATE="CLOSED"; echo $LIDSTATE
			modprobe -r hid_multitouch
		fi

		xset dpms force off # don't allow backlight to be enabled when lid is closed
	fi

    sleep 1
done
