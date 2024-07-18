# `Dynamic Wallpaper` Script for Ubuntu linux

This Script will automate the process of creating a Dynamic Wallpaper based on Light/ Dark theme of Ubuntu Linux.

## [Preview of dynamic wallpaper](https://github.com/Sanjay0302/dynamic_wall.sh/assets/90672297/60e4a994-a317-4162-a6f7-27298117cb57)

[Screencast](https://github.com/Sanjay0302/dynamic_wall.sh/assets/90672297/60e4a994-a317-4162-a6f7-27298117cb57)

## Installation

**We have two files in this repo**

1. [dynamic_wallsh.sh](https://github.com/Sanjay0302/dynamic_wall.sh/blob/master/dynamic_wallsh.sh)
2. [simple_final.sh](https://github.com/Sanjay0302/dynamic_wall.sh/blob/master/simple_no_tui.sh)

Both are exactly same but [dynamic_wallsh.sh](https://github.com/Sanjay0302/dynamic_wall.sh/blob/master/dynamic_wallsh.sh) offers TUI based interactive selection menu built using `whiptail`

![image](https://github.com/Sanjay0302/dynamic_wall.sh/assets/90672297/188759c7-47b5-49a2-ab10-347b9c4a03dc)


## Usage

* Download the `whiptail` or `simple` version and perform the below operations
* If a file already has an executable permission, then `execute flag` will be indicated by the letter 'x' in the appropriate position after running the following command.

```bash
ls -l dynamic_wallsh.sh
```
Here is how it looks: **`-rwxr-xr-x`**

Example:

![image](https://github.com/Sanjay0302/dynamic_wall.sh/assets/90672297/30f31c3c-fd65-44b4-adf9-ceb0b559aa01)

## How to make a file Executable

* Open the terminal in the same folder where you downloaded `dynamic_wallsh.sh` and make it executable 
```bash

chmod +x dynamic_wallsh.sh

```

- Then run the script from the terminal or by double clicking the file 

```
./dynamic_wallsh.sh
```

## Script Background Process: 

[Refer](https://linuxconfig.org/how-to-create-gnome-dynamic-wallpapers)

* The script creates a Folder containing 2 images in `gnome background wallpaper` folder.
* Then it creates a `xml file` for these 2 images to switch the wallpaper based on the `light` or `dark` theme.
* The user can see this new dynamic wallpaper in gnome settings > apperance (where user selects wallpaper)

![image](https://github.com/Sanjay0302/dynamic_wall.sh/assets/90672297/47d614a0-e602-4a3d-8418-f28d3a1ccf61)

## Credits

Creating dynamic wallpaper in gnome is explained in this [**site**](https://linuxconfig.org/how-to-create-gnome-dynamic-wallpapers) : 
https://linuxconfig.org/how-to-create-gnome-dynamic-wallpapers

I just created a TUI (terminal-user-interface) to automate the process.

## TODO

- [ ] To add a funtionality to change the wallpaper based on `time` and `date`.
