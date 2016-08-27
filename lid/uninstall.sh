#!/bin/bash

if [ ! -e "t100ta_lid.service" ]; then
    cd lid
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

rm /usr/local/bin/t100ta_lid.sh
