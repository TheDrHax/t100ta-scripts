#!/bin/bash

if [ $(whoami) != "root" ]; then
    echo "You need to be root!"
    exit 1
fi

if [ -d "/usr/share/alsa/ucm/bytcr-rt5640" ]; then
    echo "Uninstalling /usr/share/alsa/ucm/bytcr-rt5640"
    rm -r /usr/share/alsa/ucm/bytcr-rt5640

    echo "Uninstalling /var/lib/alsa/asound.state"
    rm /var/lib/alsa/asound.state
    alsactl restore

    echo "Configuring Pulseaudio"
    sed -i 's/^#\(load-module module-suspend-on-idle\)/\1/' /etc/pulse/default.pa
fi
