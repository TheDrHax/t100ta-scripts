# t100ta-scripts
Scripts to make T100TAM more usable with Linux

## React to lid open/close

These two scripts are based on base-station.sh script from <a href="https://github.com/jfwells/linux-asus-t100ta">jfwells/linux-asus-t100ta</a>.

### lid_root.sh

This script reloads hid_multitouch module after lid is opened to re-enable the touchscreen. Not sure if this bug affects someone except me, so install it only if your touchscreen is not working after lid is closed.

Script needs to be started with **root**.

To install, place this command to */etc/rc.local* before *exit 0* command
```
bash /path/to/script/lid_root.sh &
```

### lid_user.sh

This script turns off the screen then lid is closed and turns it on after lid is opened. Also it can activate suspend if action is set to suspend.

Script needs to be started **in user's session** to get access to the display.

To install, place this command into user startup settings
```
bash /path/to/script/lid_user.sh
```

In GNOME 3 I have added this script to the app menu with **alacarte** and then added it to startup list in **gnome-tweak-tool**.
