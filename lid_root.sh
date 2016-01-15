#!/bin/sh

if cat /proc/acpi/button/lid/LID/state | grep -q "open"; then
	LIDSTATE="OPENED"
else
	LIDSTATE="CLOSED"
fi

while true
do
	if cat /proc/acpi/button/lid/LID/state | grep -q "open"; then
		if [ $LIDSTATE = "CLOSED" ]; then
			LIDSTATE="OPENED"
			modprobe hid_multitouch
		fi
	else
		if [ $LIDSTATE = "OPENED" ]; then
			LIDSTATE="CLOSED"
			modprobe -r hid_multitouch
		fi
	fi

    sleep 1
done
