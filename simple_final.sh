#!/bin/bash

# Function to create dynamic wallpaper
create_dynamic_wallpaper() {
    read -p "Enter the folder name for the wallpaper (no spaces): " folder_name

    # Check if folder already exists
    if [ -d "$HOME/.local/share/backgrounds/$folder_name" ]; then
        read -p "Folder '$folder_name' already exists. Do you want to (o)verwrite or (r)ename it? [o/r]: " choice
        case $choice in
            o)
                # Overwrite the existing folder
                ;;
            r)
                read -p "Enter a new name for the folder: " new_name
                folder_name="$new_name"
                ;;
            *)
                echo "Invalid choice. Exiting."
                exit 1
                ;;
        esac
    fi

    # Validate folder name
    if [[ ! $folder_name =~ ^[a-zA-Z0-9_\-]+$ ]]; then
        echo "Invalid folder name. Folder name can only contain letters, digits, underscores, and hyphens."
        exit 1
    fi

    read -p "Enter the path to the first image (img1): " img1
    # Remove leading and trailing apostrophes from the image path
    img1=$(sed -e "s/^'//" -e "s/'$//" <<< "$img1")
    
    read -p "Enter the path to the second image (img2): " img2
    # Remove leading and trailing apostrophes from the image path
    img2=$(sed -e "s/^'//" -e "s/'$//" <<< "$img2")

    # Check if the image files exist
    if [ ! -f "$img1" ] || [ ! -f "$img2" ]; then
        echo "One or both of the image files do not exist."
        exit 1
    fi

    # Select wallpaper fit


    options=("zoom" "wallpaper" "centered" "scaled" "spanned")
    echo "Select wallpaper fitting:"
    for i in "${!options[@]}"; do
        echo "$((i+1)). ${options[$i]}"
    done
    echo "Press Enter to skip and use default 'zoom' fitting"
    read -r choice
    
    if [ -z "$choice" ]; then
        fit_option="zoom"
    elif [[ "$choice" =~ ^[0-9]+$ && "$choice" -ge 1 && "$choice" -le "${#options[@]}" ]]; then
        fit_option="${options[$((choice-1))]}"
    else
        echo "Invalid selection. Defaulting to 'zoom'."
        fit_option="zoom"
    fi


    # Copy images to specified directory with renaming
    mkdir -p "$HOME/.local/share/backgrounds/$folder_name" || { echo "Failed to create folder."; exit 1; }
    cp "$img1" "$HOME/.local/share/backgrounds/$folder_name/img-l.jpg" || { echo "Failed to copy image."; exit 1; }
    cp "$img2" "$HOME/.local/share/backgrounds/$folder_name/img-d.jpg" || { echo "Failed to copy image."; exit 1; }

    # Create folder path and save XML script
    gnome_properties_dir="$HOME/.local/share/gnome-background-properties"
    mkdir -p "$gnome_properties_dir" || { echo "Failed to create directory."; exit 1; }
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

    echo "Dynamic wallpaper '$folder_name' created successfully with '$fit_option' fitting."
    echo "You can view XML file @ $gnome_properties_dir/$folder_name.xml"
    echo "You can view images @ $HOME/.local/share/backgrounds/$folder_name" 
}

# Function to delete dynamic wallpaper
delete_dynamic_wallpaper() {
    wallpapers_dir="$HOME/.local/share/backgrounds"
    gnome_properties_dir="$HOME/.local/share/gnome-background-properties"

    # List only subfolders (dynamic wallpaper folders) in the backgrounds directory
    wallpapers=($(find "$wallpapers_dir" -mindepth 1 -maxdepth 1 -type d))

    if [ ${#wallpapers[@]} -eq 0 ]; then
        echo "No dynamic wallpapers found."
        exit 1
    fi

    echo "Available dynamic wallpapers:"
    options=()
    for wallpaper in "${wallpapers[@]}"; do
        folder_name=$(basename "$wallpaper")
        options+=("$folder_name")
    done

    select folder_name in "${options[@]}"; do
        if [ -n "$folder_name" ]; then
            echo "You selected: $folder_name"
            read -p "Are you sure you want to delete this wallpaper? [y/n]: " choice
            if [ "$choice" = "y" ]; then
                # Confirm deletion
                rm -rf "$wallpapers_dir/$folder_name"
                rm -f "$gnome_properties_dir/$folder_name.xml"
                echo "Dynamic wallpaper '$folder_name' deleted."
                # Refresh shell to update wallpaper to default
                exec bash
            else
                echo "Deletion cancelled."
            fi
            break
        else
            echo "Invalid selection. Please try again."
        fi
    done
}

# Function to display paths of dynamic wallpaper folders
display_folder_paths() {
    wallpapers_dir="$HOME/.local/share/backgrounds"
    Xml_dir="$HOME/.local/share/gnome-background-properties"
    echo "Paths of dynamic wallpaper folders:"
    echo "Wallpapers: $wallpapers_dir"
    echo "XML files: $Xml_dir"
}

# Function to display all dynamic wallpapers created so far
display_all_dynamic_wallpapers() {
    wallpapers_dir="$HOME/.local/share/backgrounds"
    echo "Dynamic wallpapers created so far:"
    for folder in "$wallpapers_dir"/*; do
        if [ -d "$folder" ]; then
            echo "$(basename "$folder")"
        fi
    done
}

# Main script
echo "Select an option:"
echo "1. Create Dynamic Wallpaper"
echo "2. Delete Dynamic Wallpaper"
echo "3. Folder Paths of Dynamic Wallpapers"
echo "4. Display All Dynamic Wallpapers Created So Far"
read -p "Enter your choice: " option

case $option in
    "1") create_dynamic_wallpaper ;;
    "2") delete_dynamic_wallpaper ;;
    "3") display_folder_paths ;;
    "4") display_all_dynamic_wallpapers ;;
    *) echo "Invalid option. Please try again." ;;
esac
