#!/bin/bash

if [ ! -e "t100ta_cstate.service" ]; then
    cd cstate
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

echo "Uninstalling /usr/local/bin/c6off+c7on.sh"
rm /usr/local/bin/c6off+c7on.sh

echo "Uninstalling /usr/local/bin/cstateInfo.sh"
rm /usr/local/bin/cstateInfo.sh
