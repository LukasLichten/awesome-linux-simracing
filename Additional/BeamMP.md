# BeamMP
With version 2.3.2 of the [BeamMP Launcher](https://github.com/BeamMP/BeamMP-Launcher) has native linux compatibility, 
enabling the use of the BeamNG native client, and therefore features like ffb support that do not work in the Proton version.
  
Although for now they do not provide any binaries (and limited build instructions).  

## Installation
There are community packages for the launcher
- AUR: [beammp-launcher-git](https://aur.archlinux.org/packages/beammp-launcher-git)

## Usage
It is of note, that the launcher will currently place all config and resource files into your working directory (likely home),
so it might be wise to setup a launch shortcut that takes car of setting the working directory.

## Manual Installation/Compilation
*todo: make this section more digestable*  
  
You will need `vcpkg` utility and it's build enviroment.  
Install `zlib nlohmann-json openssl cpp-httplib[openssl]` using vcpkg.  
Clone the [BeamMP-Launcher](https://github.com/BeamMP/BeamMP-Launcher) repo (recursively, although the Linux version compiles without evpp by the looks of it),
and cd into it.  
Setup the build system using `cmake -DCMAKE_BUILD_TYPE=Release . -B bin -DCMAKE_TOOLCHAIN_FILE="$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake" -DVCPKG_TARGET_TRIPLET=x64-linux`  
Then build using `cmake --build bin --parallel --config Release`.  
  
You can find the finished binary in `bin/BeamMP-Launcher`.
