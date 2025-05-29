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
- Linux Kernel 6.15 and up (also 6.12.24+, 6.13.12+, 6.14.3+) comes with [universal-pidff](https://github.com/JacKeTUs/universal-pidff) (Moza, Cammus, etc)
- [OpenFFBoard](https://github.com/Ultrawipf/OpenFFBoard)

For further information of support for particular wheels, see [linux-steering-wheels](https://github.com/JacKeTUs/linux-steering-wheels).

## Wheel Settings Configuration
For setting Wheel rotation and Force Feedback Strength:
- [oversteer](https://github.com/berarma/oversteer) (Logitech, Thrustmaster, Fanatec)
- [boxflat](https://github.com/Lawstorant/boxflat) (Moza)
- [AccuforceV2Tool](https://github.com/Spacefreak18/accuforcev2tool) (AccuforceV2 recalibration)


Moza and Cammus android apps (should) work (they communicated directly with the wheelbase)

## Virtual Devices
Creating virtual devices to merge/alter real devices (to work around compatibility issues etc):
- [protopedal](https://gitlab.com/openirseny/protopedal)
  
Check out [Peripherals Help](/Additional/Peripherals-Help.md) for other help with Peripherals

## Launchers
Game and mod launchers:
- [BeamMP](https://github.com/BeamMP/BeamMP-Launcher) ([AUR](https://aur.archlinux.org/packages/beammp-launcher-git))
  
Content Manager can be used with AssettoCorsa, see [here](/Additional/AssettoCorsa-Guide.md)

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
- [acc-setupmanager](https://gitlab.com/LukasLichten/acc-setupmanager) (Simple Multiplatform Setup Manager) [AUR](https://aur.archlinux.org/packages/acc-setupmanager-git)
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
- [Datalink](https://github.com/LukasLichten/Datalink): Wrapps around the proton launch command similar to Mangohud (so can be automatically launched with the game), utilizes a config file left in the prefix to define the memory maps, uses a fork of [shm-bridge](https://github.com/poljar/shm-bridge) to back them to `/dev/shm`, also notifies about game launch/shutdown on the session-dbus ([AUR](https://aur.archlinux.org/packages/datalink-git))
- [shm-bridge](https://github.com/poljar/shm-bridge): Simple Rust programm that uses WinAPI to back the SharedMemoryPages for ACC into `/dev/shm` and then sleep, allowing us to use regular shm to read
  - This [fork](https://github.com/LukasLichten/shm-bridge/tree/generalized) allows passing in the name and size of the memory maps as parameters, making it universal
- [wine-linux-shm-adapter](https://github.com/Spacefreak18/wine-linux-shm-adapter): Rf2 and AC, but needs to be compiled for each memorymap individually (and deployed as such), and works by copying data constantly from the SharedMemoryMap into the shm file
- [simshmbridge](https://github.com/Spacefreak18/simshmbridge): Like [wine-linux-shm-adapter](https://github.com/Spacefreak18/wine-linux-shm-adapter) (both from Spacefreak18), but for AC & ACC, or PCars2 & AMS2 (both have to be compiled seperatly), can be deployed with the game or seperate, and copy `/dev/shm` maps back into a SharedMemoryMap for a seperate wine prefix.
- [wineshm-go](https://github.com/LeonB/wineshm-go): Passes the unix filehandle through a unix socket to the go programm deploying it, unfortunatly doesn't actually work, the filehandle is dead when reaching go again

Most solutions need to be launched via protontricks after the game has started.  
Known Issues with that:
- Game has to be launched first, as otherwise the game will get stuck in Launching...
- Steam state can get stuck on Running if the bridge is running when the game has already closed (steam force stop will also not work)
- Protontricks flatpak version does not work ([error msg](https://gitlab.com/LukasLichten/wine-shakedown#running)), use the version from your packagemanager

## Server Managers
Management software (also as docker containers) for deploying game servers for Racing Games:
- [accservermanager](https://github.com/gotzl/accservermanager) 
- [assetto-server-manager](https://github.com/JustaPenguin/assetto-server-manager) 

## Additional Help
[Guides & Troubleshooting](/Additional/Readme.md)  

## Licensing
This repo is licensed under `Creative Commons Attribution Share Alike 4.0`.  
Except for the Archive of the `community-configs-for-protopedal` found in `Additional/community-configs-for-protopedal`,
these are licensed under `GPL-3.0`.  
  
Projects linked in this Repository under various licenses, including propritary.

## Contributions
Please create a Pull Request or Issue if you find software that is not mentioned here (or, find one of my many spelling misstakes...),
these contributions would be much appreciated.
