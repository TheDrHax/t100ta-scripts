#!/bin/sh

# modprobe hid_multitouch: resets touchscreen when lid is toggled
# change_cpu_governor: changes governor to powersave when lid is closed
governor_control="true"

# wifi_toggle: toggle wi-fi when lid state is changed
wifi_control="true"
wifi_control_delay="300" # seconds until wi-fi is disabled

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

function wifi_toggle {
    rfkill_id=$(rfkill list | grep "Wireless LAN" | grep -o "^[0-9]")
    marker="/tmp/lid_root_wifi_toggle"
    
    if [ "$1" == "block" ]; then
        (
            touch $marker
            
            for i in $(eval echo {1..$wifi_control_delay}); do
                sleep 1
                [ ! -e $marker ] && exit
            done
            
            rfkill $1 $rfkill_id
        ) &
    else
        [ -e $marker ] && rm $marker
        rfkill $1 $rfkill_id
    fi
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
			[ "$wifi_control" == "true" ] && wifi_toggle unblock
		fi
	else
		if [ $LIDSTATE == "OPENED" ]; then
			LIDSTATE="CLOSED"
			modprobe -r hid_multitouch
			[ "$governor_control" == "true" ] && change_cpu_governor $LIDSTATE
			[ "$wifi_control" == "true" ] && wifi_toggle block
		fi
	fi

    sleep 1
done
