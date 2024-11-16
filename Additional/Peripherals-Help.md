# Peripherals Help
Help with setting up peripherals, specifically trouble shooting

## Basic Trouble Shotting
Peripherals (like Pedals, Shifters, Handbrakes, etc.) may not work immedialty.  
First you should check if the device initializes correctly via
```
# dmesg
```

### It initalizes correctly, but does not show up
Then check `/dev/input`, you will likely find a device file (use `/dev/input/by-id/`, as this should contain the named device).  
  
If this is the case, the likely the permissions are set wrong.  
Input devices are restricted to root per default (safety reason), except for Game Controllers,
those get through ACL (Advanced Control List) permission set to allow the user to read.
And, as you can guess, sometimes Systemd does the funny and does not assign these to game controllers.  
  
To fix this you have to create a udev rule:  
Create a new file in `/etc/udev/rules.d/`, usually with the name template `[2digit-number]-[name].rules`, and add `uaccess` to your device.  
Here is an example rule `71-simpedals.rules` for the Thrustmaster T-LCM pedals through USB:
```
SUBSYSTEMS=="input", ATTRS{id/product}=="b371", ATTRS{id/vendor}=="044f", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
```

## Protopedal configs
- [Lawstorant's community configs for protopedal](https://github.com/Lawstorant/community-configs-for-protopedal)

## Testing tools
- [Hardwaretester's Gamepad-Tester Website](https://hardwaretester.com/gamepad) (A website, mileage may vary)
- [evtest](https://gitlab.freedesktop.org/libevdev/evtest) (Likely shipped in the repos of your favorite distro)
- [jstest/joyutils/joystick](https://packages.debian.org/sid/joystick) (Same as evtest, but for the old joystick event files standard, still useful for debugging)
