# Assetto Corsa on Linux
AC is more tricky then other games, because playing it without ContentManager, CSP and SOL is just not AC, so we have to install those

## Other Guides
Other guides ~~that I plagiarized~~:
- [Steam Guide by f?](https://steamcommunity.com/sharedfiles/filedetails/?id=2828364666)
- [YT-Video by KajzerD](https://www.youtube.com/watch?v=8qy_RQr8LbM)

## Pre-Requesists
You need the following:
- ProtonGE ([AUR](https://aur.archlinux.org/packages/proton-ge-custom-bin), for none Arch users download it [manually](https://github.com/GloriousEggroll/proton-ge-custom?tab=readme-ov-file#installation))
- Protontricks (Any version will work fine, just remember how to launch it)
- Steam with Assetto Corsa installed
- Content Manager ([Download](https://acstuff.club/app/))
- SOL ([Download](https://www.overtake.gg/downloads/sol.24914/) [Alt](https://modsfire.com/UW0f92464a69wYc))
- A Computer with reasonably modern Linux (Toasters included, just make sure they have 2 slots, and are plugged into a wall socket)
  
You can also manually download CSP ([link](https://acstuff.club/patch/), or [patreon](https://www.patreon.com/x4fab), but Content Manager can do this for us, 
so as long as you are not a patreon supporter with access to previews (aka rain), you should just let CM do this.  
In terms of Version, use latest rather then recommended. 
Recommended is regularly massively out of date, and may not work with some mods (like SOL) or servers 
(But I guess Debian users would feel right at home with it).

## Preparations
Download/Install the prerequesists above.  
  
### Getting AC to run
Launch it once with normal Proton (Steam guide says to launch it with Proton 5.10, but I am not 100% sure this is necessary anymore).  
This will likely crash, that is fine.  
  
Either way:
1. Select ProtonGE by right-clicking the Game and selction `Properties...`.  
2. There select the `Compatibility` Tab.  
3. Tick `Force the use of a specific Steam Play compatibility tool`.  
4. Select `ProtonGE` from the dropdown.
5. Launch the Game to complete the switch over

### Content Manager Prep
We need to create a symlink from our steam root's loginusers.vdf into the AC compatdata folder, 
so ContentManager can see it.  
  
The folders may differ, as the steam-root folder maybe different (usually `~/.steam/steam` and `~/.steam/root` symlinks to `~/.local/share/Steam`, 
so either is fine, but flatpak is `~/.var/app/com.valvesoftware.Steam/data/Steam/`),
therefore where loginusers.vdf is located.  
Additionally, if you installed AssettoCorsa in a different Library, then the compat data will be there too.
*We assume for the rest of the guide a regular steam install, with AC in the standard steam library*  
  
We create a symlink like this:
```
ln -s '$HOME/.steam/steam/config/loginusers.vdf' '$HOME/steamapps/compatdata/244210/pfx/drive_c/Program Files (x86)/Steam/config/loginusers.vdf'
```
  
Also, place the `Content Manager.exe` into the `steamapps/common/assettocorsa` folder.

### CSP Prep
First, we need to add an override for `dwrite` library:
1. Open the winecfg via `protontricks -c winecfg 244210`
2. Select the `Libraries` Tab
3. Try finding `dwrite` in the list, otherwise select it in the dropdown and press `Add`
4. Make sure that `dwrite` is set to `native, built-in`, otherwise select it and press `Edit`
5. Once done press apply
  
Second, we need to install fonts:
1. Install corefonts via `protontricks 244210 corefonts`
2. Download the AC fonts:
  - Download them [here](https://files.acstuff.ru/shared/T0Zj/fonts.zip) or [here](https://acstuff.ru/u/blob/ac-fonts.zip)
  - If you launch without them (as shown in KajzerD's video), then it will throw an error and prompt you if you want to download them (aka open your browser, which should work, but may on some windowmanagers/distros not)
3. Extract the zip into your game folder (assuming a normal installation `$HOME/.steam/steam/steamapps/common/assettocorsa/fonts/`). Make sure the font files are inside their `system` folder, as instructed by the `readme.txt`
  
In case protontricks acts up for you (complains about proton missin for example), you can navigate to the pfx folder, and use winetricks instead.
The commands will be slightly different:
```
winetricks winecfg
winetricks corefonts
```

## Launching ContentManager
There are a couple different options for making Steam launch ContentManager instead of AC:
- Renaming `AssettoCorsa.exe` to something else, and then renaming (or creating a symlink to) the `Content Manager.exe`
- Using the proton command (if available) like this `proton waitforexitandrun $HOME/.steam/steam/steamapps/common/assettocorsa/'Content Manager.exe'; echo %command%`
- Using something like [Datalink](https://github.com/LukasLichten/Datalink) to override the game executable
  
It is of special note, that options 2 and 3 can make use of renaming Content Manager to `Content Manager Safe.exe`,
which disables `Hardware Acceleration`.  
Hardware Acceleration causes artifacts (potentially crashes), and can also be disabled via the Settings (Search for Hardware, and you will find it).  
Even if launched in safe mode the checkbox will not automatically be checked, so you can use safe mode for setup and to disable Hardware Acceleration it.  
  
### First Time Setup
When first launching Content Manager you will be asked to fill in the path to the gamefolder, 
set it via the Z drive (Z mounts the root of your filesystem).
You can use the dialog to select the folder.  
  
The path should look something like this (depending obviously on how it is installed):
```
Z:\home\yourusername\.local\share\Steam\steamapps\common\assettocorsa\
```

## CSP, Sol and other Mods
These install the same way as under Windows.  
  
Here are some brief instructions, and some advice for common troubleshooting issues:

### Brief Install Instructions
1. Install CSP, either:
  - Open `Settings` in Content Manager, select the `Custom Shader Patch` Tab, it should open on `About & Update`, select the Version and press install
  - Take the CSP version you downloaded earlier and Drag & Drop it into Content Manager, then select install 
2. Take the SOL zip file, extract the `Sol x.x.x` (x being the version number) folder.
3. Copy the contained `apps`, `content`, `extension` and `system` into the game directory (let it merge into and overwrite any files it asks to)
4. Open Content Manager `Settings`->`Custom Shader Patch`->`Weather FX`, make sure `Active` is ticket and `Sol` is selected as `Weather style`
5. Go to `Settings`->`Assetto Corsa`->`Video`, enable Post processing and select one of the sol filters (or any other compatible filter you may install)
6. Go to `Settings`->`Assetto Corsa`->`Python App Settings`, enable all the Sol related apps
7. Install any further mods (PP filters, Cars, Tracks, etc) by Drag & Drop an selecting then install (as long as the mod does not instruct you otherwise)
  
You may even reuse Content Manager presets and configs from Windows, just copy them into the correct folders.

### Drag & Drop may not work 
Especially under Wayland (due to wine running under x11, therefore xwayland) 
drag & drop does not always work (Hyprland this feature is regularly broken).  
You can from the Hamburger menu (next to the minimize button) select `Install from a file...`, 
this will open a file dialog from which you can then select and install anything.

### Where to place files
Some Mods (Sol) want you to extract manually into the game direcory. 
Under Linux this is still install folder of AC, **NOT** the compatdata folder.  
Example path:
```
~/.local/share/Steam/steamapps/common/assettocorsa/
```
  
Setups, Replays, Content Manager Configs and the like are still stored within compatdata, the path usually looks something like this:
```
~/.local/share/Steam/steamapps/compatdata/244210/pfx/drive_c/users/steamuser/Documents/AssettoCorsa
```
  
## Troubleshooting and Known issues

### Failed Security Check
Some servers (like Shutoko Revival Project's offical servers) use some form of security check 
(likely intended to stop craked copies), but it also bounces us legit Linux users.  
  
Currently there is no known workaround

### Content Manager Blackwindow
Occasionally exiting a session will result in all Content Manager Windows turning black.  
  
There is no known way of fixing this, and you can not successfully close the windows either.  
Using Steam's Stop game Feature does **NOT** close the Content Manager entirely, only it's windows.  
A zombie process will remain running, which will block Steam from launching AC/Content Manager again, till you have manually killed it.

### VR users interacting with Content Manager
AC works with SteamVR as expected (other OpenXR plattforms have not been tested yet).  
  
But interacting with Content Manager while in VR has always been a pain, 
although under Windows you could use Desktop view from the SteamVR Dashboard.  
  
While Desktop View option exists, under Wayland it does not work, 
and under X11 it can only show one monitor and will likely break quickly (aka like Wayland not show anything).  
As we launch Content Manager through Steam we do get access to Theater view (in both x11 and wayland), 
which will show us Content Manager, except with multiple issues:
- Your controllers (and without controllers your head) will act as a cursor, but under Wayland you will be prompted to permit this virtual input device on first hover (and you can only confirm this on your flatscreen monitor)
- Opening any dialog/dropbox/pop-up will cause it to loose capture while that window is open (x11 it will glitch out instead)
  - This means you can't see what you are selecting, but also can't see where to move/click to close the interaction
  - As Content Manager is very heavy on pop-ups, making navigation practically impossible
  - End of session dialogs are also effected, and have to be closed before continuing
  
There are desktop/window overlay solutions, like [wlx-overlay-s](https://github.com/galister/wlx-overlay-s), with X11 and wayland support.
