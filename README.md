# Awesome-Linux-SimRacing
A collection of SimRacing Software, primarily for Linux.  
  
This collection serves to provide information, raise awareness of projects and allow users to find and setup games.  
Contribution through issues and pull requests are welcome.

## FFB Drivers/Kernel-Modules 
Wheels will be usually recognized as HID devices (and usable as a limb game controller), but FFB usuall requires a kernel module.  
- [hid-fanatecff](https://github.com/gotzl/hid-fanatecff) (Fanatec CSL DD, DD Pro, Elite & further)
- [hid-tmff2](https://github.com/Kimplul/hid-tmff2) (Thrustmaster T300, T248, TX and TS-XW)
- [t150_driver](https://github.com/scarburato/t150_driver) (Thrustmaster T150 & TMX)
- [new-lg4ff](https://github.com/berarma/new-lg4ff) (Logitech WingMan, MOMO, DFGT, G25, G27, G29, G923-PS4)
- Linux Kernel 6.3 and up (Logitech G920 and G923-Xbox)
- [universal-pidff](https://github.com/JacKeTUs/universal-pidff) (Moza, Cammus, etc)
- [OpenFFBoard](https://github.com/Ultrawipf/OpenFFBoard)


## Wheel Settings Configuration
For setting Wheel rotation and Force Feedback Strength:
- [oversteer](https://github.com/berarma/oversteer) (Logitech, Thrustmaster, Fanatec)
- [boxflat](https://github.com/Lawstorant/boxflat) (Moza)
- [AccuforceV2Tool](https://github.com/Spacefreak18/accuforcev2tool) (AccuforceV2 recalibration)


Moza and Cammus android apps (should) work (they communicated directly with the wheelbase)

## None Functioning Peripherals
Peripherals (like Pedals, Shifters, Handbrakes, etc.) may not work immedialty.  
First you should check if the device initializes correctly via
```
# dmesg
```
If it initializes correctly, and you can find it's event file in `/dev/input`, but can't access it,
then you have to create a udev rule 
(as input devices are protected from the user by default, except for game controllers,
but systemd sometimes does the funny and doesn't give permissions).  
  
Create a new file in `/etc/udev/rules.d/`, usually with the name template `[2digit-number]-[name].rules`, and add `uaccess` to your device.  
Here is an example rule `71-simpedals.rules` for the Thrustmaster T-LCM pedals through USB:
```
SUBSYSTEMS=="input", ATTRS{id/product}=="b371", ATTRS{id/vendor}=="044f", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
```
  
There can be issues with pedals being detected in games, for this:  
- [protopedal](https://gitlab.com/openirseny/protopedal) (for creating virtual devices with extra buttons and axis)

## SimRacing Tools
Simracing is unique with that most games and players require extra software for displaying extra information, driving other hardware and managing mods.

### Telemetry
Displaying graphs from telemetry files
- [acctelemetry](https://github.com/gotzl/acctelemetry) (Reads MoTeC files, designed for ACC output)

### Dashboards
Rendering Overlays and others
- [simlcd](https://github.com/Spacefreak18/simlcd)
- [gilles](https://github.com/Spacefreak18/gilles)
- [DataRace](https://github.com/LukasLichten/DataRace) (WIP)

### Virtual Engineers
Get yelled at by Jeff
- [RaceEngineer](https://github.com/Spacefreak18/raceengineer)

### Extra Hardware (Bass Shakers, Tachometers, Simlights, other Arduino stuff)
Taking the game telemetry to physical display, provide additional force feedback, etc. (often through Arduino's)
- [monocoque](https://github.com/Spacefreak18/monocoque)

### Helper Software
Software to help manage mods, setups, liveries, etc.
- [acc-setupmanager](https://gitlab.com/LukasLichten/acc-setupmanager) (Simple Multiplatform Setup Manager in fltk)
- [acc_skinmanager](https://github.com/LukasLichten/acc_skinmanager) (Livery utility, mainly for mass importing livieries)
- [acc_csv2bop](https://github.com/LukasLichten/acc_csv2bop) (For handling ACC bop.json files)

### Windows Software
Besides the listed software, some Windows software maybe installed into the prefix, and may then still work.
*ToDo make list*

### Libraries, Headers, and Other Dev utils
For development of further tools
- [protonfinder](https://github.com/LukasLichten/proton-finder) (rust crate for multiplattform abstracting finding user folders)
- [simetry](https://github.com/adnanademovic/simetry) (rust crate implementing structs from a large numbers of sims)
- [simapi](https://github.com/spacefreak18/simapi) (c headers for large number of sims)
  
To access shared memory maps from games it is necessary to deploy some piece of software into the prefix while the game is running.  
There are numerous solutions and issues (*I may make a blog post about it, eventually*).
- [simshmbridge](https://github.com/Spacefreak18/simshmbridge) (AC, ACC, PCars2, AMS2, and needs recompile for each memorymap, and constantly copies data from Windows Shared Memory to shm, so not ideal)
- [wineshm-go](https://github.com/LeonB/wineshm-go) (Passes the unix filehandle through a unix socket to the go programm deploying it, unfortunatly doesn't actually work, the filehandle is dead when reaching go again)
- [shm-bridge](https://github.com/poljar/shm-bridge) (Simple Rust programm that uses WinAPI to back the SharedMemoryPages for ACC into `/dev/shm` and then sleep, allowing us to use regular shm to read)
 - This [fork](https://github.com/LukasLichten/shm-bridge/tree/generalized) allows passing in the name and size of the memory maps, making it universal
Known Issue: Protontricks flatpak version does not work ([error msg](https://gitlab.com/LukasLichten/wine-shakedown#running)), use the version from your packagemanager

## Server Managers
Management software (also as docker containers) for deploying game servers for Racing Games:
- [accservermanager](https://github.com/gotzl/accservermanager) 
- [assetto-server-manager](https://github.com/JustaPenguin/assetto-server-manager) 
