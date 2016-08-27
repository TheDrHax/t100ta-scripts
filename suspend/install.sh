#!/bin/bash

if [ ! -e "t100ta_suspend.service" ]; then
    cd suspend
fi

if [ $(whoami) != "root" ]; then
    echo "You need to be root!"
    exit 1
fi

for i in *.service; do
    echo "Installing /etc/systemd/system/$i"
    cp $i /etc/systemd/system/
    systemctl enable $i
done

systemctl daemon-reload
