#!/bin/sh

# Config #

# screen_control: "true" or "false"
#  control the screen backlight
screen_control="true"

# action: "none" or "suspend" or "hibernate"
#  suspend: activate suspend on lid close
#  hibernate: activate hibernation on lid close (may not work)
action="none"

#--------#

function lid_state {
	cat /proc/acpi/button/lid/LID/state | grep -Eo '[a-z]*$'
}

function dbus-action {
	case "$1" in
		suspend)
			dbus-send --print-reply --system --dest=org.freedesktop.login1 /org/freedesktop/login1 org.freedesktop.login1.Manager.Suspend boolean:true
			;;

		hibernate)
			dbus-send --print-reply --system --dest=org.freedesktop.login1 /org/freedesktop/login1 org.freedesktop.login1.Manager.Hibernate boolean:true
			;;
	esac
}

# Getting initial lid state
if [ `lid_state` == "open" ]; then
	LIDSTATE="OPENED"
else
	LIDSTATE="CLOSED"
fi

while true; do

	if [ `lid_state` == "open" ]; then

		if [ $LIDSTATE = "CLOSED" ]; then
			LIDSTATE="OPENED"

			if [ "$screen_control" == "true" ]; then
				xset dpms force on
			fi
		fi

	else

		if [ $LIDSTATE = "OPENED" ]; then
			LIDSTATE="CLOSED"

			dbus-action $action
		fi

		# Update screen state each time
		if [ "$screen_control" == "true" ]; then
			xset dpms force off
		fi

	fi

    sleep 1

done
