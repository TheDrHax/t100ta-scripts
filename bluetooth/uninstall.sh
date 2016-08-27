#!/bin/bash

if [ ! -e "t100ta_btattach.service" ]; then
    cd bluetooth
fi

if [ $(whoami) != "root" ]; then
    echo "You need to be root!"
    exit 1
fi

for i in *.service; do
    echo "Uninstalling /etc/systemd/system/$i"
    systemctl stop $i
    systemctl disable $i
    rm /etc/systemd/system/$i
done
