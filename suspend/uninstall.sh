#!/bin/bash

if [ ! -e "t100ta_suspend.service" ]; then
    cd suspend
fi

if [ $(whoami) != "root" ]; then
    echo "You need to be root!"
    exit 1
fi

for i in *.service; do
    echo "Uninstalling /etc/systemd/system/$i"
    systemctl disable $i
    rm /etc/systemd/system/$i
done
