#!/bin/bash

if [ ! -e "t100ta_btattach.service" ]; then
    cd bluetooth
fi

if [ $(whoami) != "root" ]; then
    echo "You need to be root!"
    exit 1
fi

for i in *.service; do
    echo "Installing /etc/systemd/system/$i"
    cp $i /etc/systemd/system/
    systemctl enable $i
    systemctl restart $i
done

systemctl daemon-reload
