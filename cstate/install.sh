#!/bin/bash

if [ ! -e "t100ta_cstate.service" ]; then
    cd cstate
fi

if [ $(whoami) != "root" ]; then
    echo "You need to be root!"
    exit 1
fi

echo "Installing /usr/local/bin/c6off+c7on.sh"
cp c6off+c7on.sh /usr/local/bin

echo "Installing /usr/local/bin/cstateInfo.sh"
cp cstateInfo.sh /usr/local/bin

for i in *.service; do
    echo "Installing /etc/systemd/system/$i"
    cp $i /etc/systemd/system/
    systemctl enable $i
    systemctl start $i
done

systemctl daemon-reload
