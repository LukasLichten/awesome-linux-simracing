# BeamMP
With version 2.3.2 of the [BeamMP Launcher](https://github.com/BeamMP/BeamMP-Launcher) has native linux compatibility, 
enabling the use of the BeamNG native client, and therefore features like ffb support that do not work in the Proton version.
  
Although for now they do not provide any binaries.  

## Installation
There are community packages for the launcher
- AUR: [beammp-launcher-git](https://aur.archlinux.org/packages/beammp-launcher-git)

## Usage
It is of note, that the launcher will currently place all config and resource files into your working directory (likely home),
so it might be wise to setup a launch shortcut that takes care of setting the working directory.

## Manual Installation/Compilation
There are now [Linux build instructions](https://github.com/BeamMP/BeamMP-Launcher?tab=readme-ov-file#how-to-build-for-linux) from the Team,
so here is just some extra advice:  
  
Besides standard build tools and `cmake`, you will need `vcpkg` utility and it's build enviroment.  
The build enviroment is under Linux often not shipped with the binaries (like for the Arch `extra/vcpkg`, however `aur/vcpkg-git` does), 
so you need to clone the vcpkg [repo](https://github.com/microsoft/vcpkg) and setting the enviroment variable accordingly:
```
export $VCPKG_ROOT=[your path here]
```
  
After cloning the [BeamMP-Launcher](https://github.com/BeamMP/BeamMP-Launcher) repo (recursviely), 
the offical guide assumes you use home to store your vcpkg root, so you can use this command instead:
```
cmake -DCMAKE_BUILD_TYPE=Release . -B bin -DCMAKE_TOOLCHAIN_FILE="$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake" -DVCPKG_TARGET_TRIPLET=x64-linux
cmake --build bin --parallel --config Release
```
  
You can find the finished binary in `bin/BeamMP-Launcher`.
