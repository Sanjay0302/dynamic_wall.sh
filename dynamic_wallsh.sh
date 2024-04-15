#!/bin/bash

# Function to create dynamic wallpaper
create_dynamic_wallpaper() {
    folder_name=$(whiptail --inputbox "Enter the folder name for the wallpaper (no spaces):" 8 60 --title "Create Dynamic Wallpaper" 3>&1 1>&2 2>&3) || return

    # Check if folder already exists
    if [ -d "$HOME/.local/share/backgrounds/$folder_name" ]; then
        choice=$(whiptail --title "Folder Exists" --menu "Folder '$folder_name' already exists. Do you want to overwrite or rename it?" 15 60 2 \
            "o" "Overwrite the existing folder" \
            "r" "Rename the existing folder" \
            "e" "Exit" \
            3>&1 1>&2 2>&3) || return
        case $choice in
            o)
                # Overwrite the existing folder
                ;;
            r)
                new_name=$(whiptail --inputbox "Enter a new name for the folder:" 8 60 --title "Rename Folder" 3>&1 1>&2 2>&3) || return
                folder_name="$new_name"
                ;;
            e)
                return
                ;;
            *)
                whiptail --msgbox "Invalid choice. Exiting." 8 60
                return
                ;;
        esac
    fi

    # Validate folder name
    if [[ ! $folder_name =~ ^[a-zA-Z0-9_\-]+$ ]]; then
        whiptail --msgbox "Invalid folder name. Folder name can only contain letters, digits, underscores, and hyphens." 8 60
        return
    fi

    img1=$(whiptail --inputbox "Enter the path to the first image (img1) or Drag and Drop image:" 8 60 --title "Image Path" 3>&1 1>&2 2>&3) || return
    img1=$(sed -e "s/^'//" -e "s/'$//" <<< "$img1")

    img2=$(whiptail --inputbox "Enter the path to the second image (img2) or Drag and Drop image:" 8 60 --title "Image Path" 3>&1 1>&2 2>&3) || return
    img2=$(sed -e "s/^'//" -e "s/'$//" <<< "$img2")

    # Check if the image files exist
    if [ ! -f "$img1" ] || [ ! -f "$img2" ]; then
        whiptail --msgbox "One or both of the image files do not exist." 8 60
        return
    fi

    # Select wallpaper fit
    fit_option=$(whiptail --title "Wallpaper Fitting" --menu "Select wallpaper fitting:" 15 60 5 \
        "zoom" "Zoom" \
        "wallpaper" "Wallpaper" \
        "centered" "Centered" \
        "scaled" "Scaled" \
        "spanned" "Spanned" \
        3>&1 1>&2 2>&3) || return

    # Copy images to specified directory with renaming
    mkdir -p "$HOME/.local/share/backgrounds/$folder_name" || { whiptail --msgbox "Failed to create folder." 8 60; return; }
    cp "$img1" "$HOME/.local/share/backgrounds/$folder_name/img-l.jpg" || { whiptail --msgbox "Failed to copy image." 8 60; return; }
    cp "$img2" "$HOME/.local/share/backgrounds/$folder_name/img-d.jpg" || { whiptail --msgbox "Failed to copy image." 8 60; return; }

    # Create folder path and save XML script
    gnome_properties_dir="$HOME/.local/share/gnome-background-properties"
    mkdir -p "$gnome_properties_dir" || { whiptail --msgbox "Failed to create directory." 8 60; return; }
    cat <<EOF > "$gnome_properties_dir/$folder_name.xml"
<?xml version="1.0"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
  <wallpaper deleted="false">
    <name>$folder_name</name>
    <filename> $HOME/.local/share/backgrounds/$folder_name/img-l.jpg</filename>
    <filename-dark> $HOME/.local/share/backgrounds/$folder_name/img-d.jpg</filename-dark>
    <options>$fit_option</options>
  </wallpaper>
</wallpapers>
EOF
message="Dynamic wallpaper '$folder_name' created successfully with '$fit_option' fitting.\n\n
You can view XML file @ $gnome_properties_dir/$folder_name.xml\n\n
You can view images @ $HOME/.local/share/backgrounds/$folder_name"
whiptail --msgbox "$message" 15 100
}

# Function to delete dynamic wallpaper
delete_dynamic_wallpaper() {
    wallpapers_dir="$HOME/.local/share/backgrounds"
    gnome_properties_dir="$HOME/.local/share/gnome-background-properties"

    # List only subfolders (dynamic wallpaper folders) in the backgrounds directory
    wallpapers=($(find "$wallpapers_dir" -mindepth 1 -maxdepth 1 -type d))

    if [ ${#wallpapers[@]} -eq 0 ]; then
        whiptail --msgbox "No dynamic wallpapers found." 8 60
        return
    fi

    options=()
    for wallpaper in "${wallpapers[@]}"; do
        options+=("$(basename "$wallpaper")" "")
    done

    folder_name=$(whiptail --title "Delete Dynamic Wallpaper" --menu "Select dynamic wallpaper to delete:" 20 60 10 "${options[@]}" 3>&1 1>&2 2>&3) || return

    choice=$(whiptail --title "Delete Dynamic Wallpaper" --menu "Select an option:" 20 60 3 \
        "Yes" "Delete '$folder_name'" \
        "No" "Cancel deletion" \
        3>&1 1>&2 2>&3)
    case $choice in
        Yes)
            rm -rf "$wallpapers_dir/$folder_name"
            rm -f "$gnome_properties_dir/$folder_name.xml"
            whiptail --msgbox "Dynamic wallpaper '$folder_name' deleted." 8 60
            ;;
        No)
            whiptail --msgbox "Deletion cancelled." 8 60
            ;;
        Exit)
            return
            ;;
        *)
            whiptail --msgbox "Invalid option" 8 60
            ;;
    esac
}

# Function to display folder paths of dynamic wallpaper folders
display_folder_paths() {

wallpapers_dir="$HOME/.local/share/backgrounds"
Xml_dir="$HOME/.local/share/gnome-background-properties"

message="Paths of dynamic wallpaper folders:\n\n
XML files: $Xml_dir\n
Wallpapers: $wallpapers_dir\n\n"
whiptail --msgbox "$message" 15 100
}

# Function to display all dynamic wallpapers created so far
display_all_dynamic_wallpapers() {
    wallpapers_dir="$HOME/.local/share/backgrounds"
    whiptail --title "Dynamic Wallpapers" --msgbox "Dynamic wallpapers created so far:\n\n$(ls -1 "$wallpapers_dir")" 15 60
}

# Main script
while true; do
    option=$(whiptail --title "Select Option" --menu "Choose an option:" 15 60 5 \
        "1" "Create Dynamic Wallpaper" \
        "2" "Delete Dynamic Wallpaper" \
        "3" "Folder Paths of Dynamic Wallpapers" \
        "4" "Display All Dynamic Wallpapers Created So Far" \
        "5" "Exit" \
        3>&1 1>&2 2>&3)
    case $option in
        1) create_dynamic_wallpaper ;;
        2) delete_dynamic_wallpaper ;;
        3) display_folder_paths ;;
        4) display_all_dynamic_wallpapers ;;
        5) exit ;;
        *) echo "Invalid option" ;;
    esac
done
