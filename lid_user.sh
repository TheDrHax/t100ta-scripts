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
			xset dpms force on
		fi
	else
		if [ $LIDSTATE = "OPENED" ]; then
			LIDSTATE="CLOSED"
			xset dpms force off
		fi
	fi

    sleep 1
done
