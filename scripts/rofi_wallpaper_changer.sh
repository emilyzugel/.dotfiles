#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/walls/"

# List files with rofi
PIC=$(find "$WALLPAPER_DIR" -type f | rofi -dmenu -i -p "Wallpaper:")

# If an image is choosen, applies with swww
if [[ -n "$PIC" ]]; then
  swww img "$PIC" --transition-type fade --transition-step 10
fi
