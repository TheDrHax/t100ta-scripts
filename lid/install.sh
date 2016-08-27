#!/bin/bash

if [ ! -e "t100ta_lid.service" ]; then
    cd lid
fi

if [ $(whoami) != "root" ]; then
    echo "You need to be root!"
    exit 1
fi

cp t100ta_lid.sh /usr/local/bin

for i in *.service; do
    echo "Installing /etc/systemd/system/$i"
    cp $i /etc/systemd/system/
    systemctl enable $i
    systemctl restart $i
done

systemctl daemon-reload
