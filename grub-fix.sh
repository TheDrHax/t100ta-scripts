#!/bin/bash

echo "This script will download, compile and install GRUB into /boot/efi/efi/grub. Tested on Ubuntu 15.04 from Magic Stick v1.5 and Debian."

echo "Press Enter to continue or Ctrl+C to exit..." && read

sudo echo "Rooted succesfully" || exit 1

echo -n "Install required packages? [y/N] " && read answer
if [ "$answer" == "y" ]; then
	sudo apt-get update
	sudo apt-get install -y git bison libopts25 libselinux1-dev autogen m4 autoconf help2man libopts25-dev flex libfont-freetype-perl automake autotools-dev libfreetype6-dev texinfo build-essential
fi

mkdir /tmp/grub-build; cd /tmp/grub-build

git clone git://git.savannah.gnu.org/grub.git || exit 1

cd grub

./autogen.sh || exit 1

./configure --with-platform=efi --target=i386 --program-prefix="" || exit 1

make || exit 1

cd grub-core

sudo ../grub-install -d . --efi-directory /boot/efi/ --target=i386

cd

rm -rf /tmp/grub-build
