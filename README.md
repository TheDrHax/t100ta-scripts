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

## t100ta_lid (systemd recommended)

This script will monitor the lid state to workaround two problems:
* Touchscreen doesn't work after closing the lid (need to reload the **hid_multitouch** module)
* Backlight is not forced to be disabled when lid is closed

If you don't have systemd, you can just start t100ta_lid.sh as root.

## t100ta_suspend (systemd only)

This script will load/unload kernel modules and restart specific daemons before and after suspend. This will prevent problems with networking, touchscreen and dock before and after suspend.

Kernel modules being loaded/unloaded:
* hid_multitouch
* usbhid

Daemons being restarted on wake:
* network-manager
* wpa_supplicant

## bluetooth (systemd only)

This systemd service will execute `btattach` to enable bluetooth on each boot.
It is an alternative for previous dirty workaround with /etc/rc.local.
