#!/system/bin/sh

while sleep 1; do
	if grep -q "open" /proc/acpi/button/lid/LID/state; then
		if [ ! $LIDSTATE ] || [ $LIDSTATE == "CLOSED" ]; then
			LIDSTATE="OPENED"; echo $LIDSTATE
			modprobe hid_multitouch
			am broadcast -a android.intent.action.LID_EVENT --ei android.intent.extra.LID_STATE 0
		fi
	else
		if [ ! $LIDSTATE ] || [ $LIDSTATE == "OPENED" ]; then
			LIDSTATE="CLOSED"; echo $LIDSTATE
			rmmod hid_multitouch
			am broadcast -a android.intent.action.LID_EVENT --ei android.intent.extra.LID_STATE 1
		fi
	fi
done
