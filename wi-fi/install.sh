#!/bin/bash

if [ $(whoami) != "root" ]; then
    echo "You need to be root!"
    exit 1
fi

if [ ! -e "/lib/firmware/brcm/brcmfmac43241b4-sdio.txt" ]; then
    echo "Installing /lib/firmware/brcm/brcmfmac43241b4-sdio.txt"
    ln -s /sys/firmware/efi/efivars/nvram-* /lib/firmware/brcm/brcmfmac43241b4-sdio.txt
    modprobe -r brcmfmac
    modprobe brcmfmac
fi
