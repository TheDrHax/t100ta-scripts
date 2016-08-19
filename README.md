# t100ta-scripts
Scripts to make T100TAM more usable with Linux

## Fix GRUB freeze while booting without dock

This script will:
* install packages required for building GRUB from sources (optional)
* download latest GRUB sources from git://git.savannah.gnu.org/grub.git
* compile GRUB from these sources
* install it to /boot/efi/efi/grub (adds **grub** entry to EFI menu)

If you can boot your tablet without dock, you probably don't need this script.

This method was tested many times on T100TAM and it works for me on Debian and Ubuntu.

## t100ta_lid

This script will monitor the lid state to workaround two problems:
* Touchscreen doesn't work after closing the lid (need to reload the **hid_multitouch** module)
* Backlight is not forced to be disabled when lid is closed

How to install (as root, for systemd):
* cp lid/t100ta_lid.service /etc/systemd/system/
* cp lid/t100ta_lid.sh /usr/local/bin/
* systemctl enable t100ta_lid.service
* systemctl start t100ta_lid.service

If you don't have systemd, you can just start t100ta_lid.sh as root.

## t100ta_suspend (systemd only)

This script will load/unload kernel modules and restart specific daemons before and after suspend. This will prevent problems with networking, touchscreen and dock before and after suspend.

Kernel modules being loaded/unloaded:
* brcmfmac (wi-fi)
* battery
* hid_multitouch
* usbhid

Daemons being restarted on wake:
* network-manager
* wpa_supplicant

How to install (as root):
* cp suspend/t100ta_{suspend,resume}.service /etc/systemd/system/
* systemctl enable t100ta_suspend.service
* systemctl enable t100ta_wake.service

## bluetooth (systemd only)

This systemd service will execute `btattach` to enable bluetooth on each boot.
It is an alternative for previous dirty workaround with /etc/rc.local.

How to install (as root):
* cp bluetooth/t100ta_btattach.service /etc/systemd/system/
* systemctl enable t100ta_btattach.service
