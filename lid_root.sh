#!/bin/sh

# modprobe hid_multitouch: resets touchscreen when lid is toggled
# change_cpu_governor: changes governor to powersave when lid is closed
governor_control="true"

#--------#

function change_cpu_governor {
    if [ "$1" == "OPENED" ]; then
        governor=$old_governor
    else
        old_governor=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
        governor="powersave"
    fi
              
    echo "Changing CPU governor to $governor"

    for CPU in /sys/devices/system/cpu/cpu[0-9]*; do
        echo "$governor" > $CPU/cpufreq/scaling_governor
    done
}

#--------#

if grep -q "open" /proc/acpi/button/lid/LID/state; then
	LIDSTATE="OPENED"
else
	LIDSTATE="CLOSED"
fi

while true; do

	if grep -q "open" /proc/acpi/button/lid/LID/state; then
		if [ $LIDSTATE == "CLOSED" ]; then
			LIDSTATE="OPENED"
			modprobe hid_multitouch
			[ "$governor_control" == "true" ] && change_cpu_governor $LIDSTATE
		fi
	else
		if [ $LIDSTATE == "OPENED" ]; then
			LIDSTATE="CLOSED"
			modprobe -r hid_multitouch
			[ "$governor_control" == "true" ] && change_cpu_governor $LIDSTATE
		fi
	fi

    sleep 1
done
