#!/bin/bash

if [ $(whoami) != "root" ]; then
    echo "You need to be root!"
    exit 1
fi

if [ -L "/lib/firmware/brcm/brcmfmac43241b4-sdio.txt" ]; then
    echo "Uninstalling /lib/firmware/brcm/brcmfmac43241b4-sdio.txt"
    rm "/lib/firmware/brcm/brcmfmac43241b4-sdio.txt"
fi
