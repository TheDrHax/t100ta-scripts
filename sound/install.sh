#!/bin/bash

if [ ! -d "bytcr-rt5640" ]; then
    cd sound
fi

if [ $(whoami) != "root" ]; then
    echo "You need to be root!"
    exit 1
fi

if [ ! -e "/usr/share/alsa/ucm/bytcr-rt5640" ]; then
    echo "Installing /usr/share/alsa/ucm/bytcr-rt5640"
    mkdir -p /usr/share/alsa/ucm
    cp -r bytcr-rt5640 /usr/share/alsa/ucm/bytcr-rt5640

    echo "Installing /var/lib/alsa/asound.state"
    alsactl --file kernel4.5.xand4.4.x.asound.state restore

    echo "Configuring Pulseaudio"
    sed -i 's/^\(load-module module-suspend-on-idle\)/#\1/' /etc/pulse/default.pa
fi
