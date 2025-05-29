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

## Protopedal configs/scripts
The old `community-configs-for-protopedal` by [Lawstorant](https://github.com/Lawstorant) are archived [here](/Additional/community-configs-for-protopedal/README.md)

An example script (courtesy of [ccalhoun1999](https://github.com/ccalhoun1999)):
```
#!/usr/bin/env bash

sudo protopedal \
  --name "Protopedal V1" \
  --vendor "0eb7" \
  --product "1840" \
  --axis WHEEL --source 1:X \
  --axis GAS --source 0:RZ \
  --axis BRAKE --source 0:RY \
  --axis THROTTLE --source 0:RX \
  --axis RUDDER --source 2:RUDDER \
  --button Happy1 --source 3:TRIGGER \
  --button Happy2 --source 3:THUMB \
  --button Happy3 --source 3:TOP2 \
  --button Happy4 --source 3:BASE3 \
  --button Happy5 --source 3:0x12E \
  --button Happy6 --source 3:THUMB2 \
  --button Happy7 --source 3:BASE4 \
  --button Happy8 --source 3:BASE6 \
  --button Happy9 --source 3:0x12D \
  --button Happy10 --source 3:0x12C \
  --button Happy11 --source 3:BASE \
  --button Happy12 --source 3:BASE2 \
  --button Happy13 --source 3:TOP \
  --button Happy14 --source 3:PINKIE \
  --button Happy15 --source 3:BASE5 \
  --button Happy16 --source 4:TRIGGER \
  --button Happy17 --source 4:THUMB \
  --button Happy18 --source 4:THUMB2 \
  --button Happy19 --source 4:TOP \
  --button Happy20 --source 4:TOP2 \
  --button Happy21 --source 4:PINKIE \
  --button Happy22 --source 4:BASE2 \
  --ffb-device 1 \
  --no-auto-axes \
  --no-auto-buttons \
  --grab \
  /dev/input/by-id/usb-SIMAGIC_Alpha_Pedal_Neo_57888D9C080A314D080AFF04-0101000B-0001000B-event-joystick \
  /dev/input/by-id/usb-Smarty_Co._VRS_DirectForce_Pro_Wheel_Base_000745094-event-if00 \
  /dev/input/by-id/usb-Gudsen_HBP_Handbrake_1F002B000757465034363020-if02-event-joystick \
  /dev/input/by-id/usb-Teensyduino_Keyboard_Mouse_Joystick_8733770-if03-event-joystick \
  /dev/input/by-id/usb-DragonRise_inc._Generic_USB_Joystick-event-joystick
```

## Testing tools
- [Hardwaretester's Gamepad-Tester Website](https://hardwaretester.com/gamepad) (A website, mileage may vary)
- [evtest](https://gitlab.freedesktop.org/libevdev/evtest) (Likely shipped in the repos of your favorite distro)
- [jstest/joyutils/joystick](https://packages.debian.org/sid/joystick) (Same as evtest, but for the old joystick event files standard, still useful for debugging)
