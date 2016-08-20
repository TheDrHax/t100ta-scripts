#!/bin/bash

# Functions
alias get_display="w | sed -n 's/.* \(:[0-9]\) .*/\1/p'"

function is_opened {
    return $(grep -q "open" /proc/acpi/button/lid/LID/state)
}

# Prepare environment
while [ ! "$DISPLAY" ] && sleep 1; do # Wait for X session
    export DISPLAY=$(w | sed -n 's/.* \(:[0-9]\) .*/\1/p')
done
USER=$(who | grep :0 | awk '{print $1}')
export XAUTHORITY="/home/$USER/.Xauthority"

# -------- #

while sleep 1; do
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
done
