A simple script to create dynamic wallpaper based on Light/Dark theme

# [Preview of dynamic wallpaper](https://github.com/Sanjay0302/dynamic_wall.sh/assets/90672297/60e4a994-a317-4162-a6f7-27298117cb57):

<details>
  <summary>Screencast from 2024-04-15 20-02-14.webm</summary>
  
  [Screencast](https://github.com/Sanjay0302/dynamic_wall.sh/assets/90672297/60e4a994-a317-4162-a6f7-27298117cb57)
</details>

---

# How to use  

We have two files in repo

1. [dynamic_wallsh.sh](https://github.com/Sanjay0302/dynamic_wall.sh/blob/master/dynamic_wallsh.sh)
2. [simple_final.sh](https://github.com/Sanjay0302/dynamic_wall.sh/blob/master/simple_no_tui.sh)

Both are exactly same but [dynamic_wallsh.sh](https://github.com/Sanjay0302/dynamic_wall.sh/blob/master/dynamic_wallsh.sh) offers TUI bases interactive selection menu built using `whiptail`

![image](https://github.com/Sanjay0302/dynamic_wall.sh/assets/90672297/188759c7-47b5-49a2-ab10-347b9c4a03dc)

* Dowmload the `whiptail` or `simple` version and perform the below operations

---

# Make the  file executable
If a file is already executable, the permission for execute will be indicated by the letter 'x' in the appropriate position.

Here is how it looks:
**`-rwxr-xr-x`**
* To see that here is the example:
```bash
ls -l dynamic_wallsh.sh
```
Example:

![image](https://github.com/Sanjay0302/dynamic_wall.sh/assets/90672297/30f31c3c-fd65-44b4-adf9-ceb0b559aa01)

---

#### If not a executable by default, follow this: 

* Open the terminal in the same folder where you downloaded `dynamic_wallsh.sh` and make it executable 
```bash

chmod +x dynamic_wallsh.sh

```
---

#### then run the script from the terminal or by double clicking the file 
```
./dynamic_wallsh.sh
```
---

## what this script actually doing: [Refer](https://linuxconfig.org/how-to-create-gnome-dynamic-wallpapers)

* The script creates a Folder containing 2 images in gnome backround wallpaper folder
* Then it creates a xml file for these 2 images to swith the wallpaper based on the light or dark theme
* The script performs copying the 2 images provided by user to the perticular folder inside the gnome and creates xml file for it
* The user can see this new dynamic wallpaper in gnome settings > apperance (where user selects wallpaper)

![image](https://github.com/Sanjay0302/dynamic_wall.sh/assets/90672297/47d614a0-e602-4a3d-8418-f28d3a1ccf61)


---
# Credits

Creating dynamic wallpaper in gnome is explained in this [**site**](https://linuxconfig.org/how-to-create-gnome-dynamic-wallpapers) : 
https://linuxconfig.org/how-to-create-gnome-dynamic-wallpapers

I just created a TUI (terminal-user-interface) to automate the process
