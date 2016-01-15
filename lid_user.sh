#!/bin/sh

# Config #

# action: "backlight" or "suspend"
#  backlight: turn screen on and off
#  suspend: activate suspend on lid close
action="backlight"

#--------#

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
			[ "$action" == "backlight" ] && xset dpms force on
		fi
	else
		[ "$action" == "backlight" ] && xset dpms force off
		if [ $LIDSTATE = "OPENED" ]; then
			LIDSTATE="CLOSED"

			[ "$action" == "suspend" ] && dbus-send \
				--system \
				--dest=org.freedesktop.login1 \
				/org/freedesktop/login1 \
				org.freedesktop.login1.Manager.Suspend \
				boolean:true
		fi
	fi

    sleep 1
done
