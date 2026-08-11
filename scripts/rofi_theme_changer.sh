#!/usr/bin/env bash

THEME_DIR="$HOME/.dotfiles/colourSchemes"
CONFIG_DIR="$HOME/.config"

# Get themes dynamically
THEME=$(find "$THEME_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort | rofi -dmenu -i -p "Theme:")

# Exit if nothing selected
[[ -z "$THEME" ]] && exit 0

SOURCE="$THEME_DIR/$THEME"

# Backup current symlinks (optional)
BACKUP="$HOME/.config/theme-backup"
mkdir -p "$BACKUP"

# Replace all theme directories
for item in "$SOURCE"/*; do
  name=$(basename "$item")

  # directory themes (kitty, rofi, waybar, lsd, etc.)
  if [[ -d "$item" ]]; then
    rm -rf "$CONFIG_DIR/$name"
    ln -s "$item" "$CONFIG_DIR/$name"
  fi

  # file themes (starship.toml)
  if [[ -f "$item" ]]; then
    rm -f "$CONFIG_DIR/$name"
    ln -s "$item" "$CONFIG_DIR/$name"
  fi
done

# Reload apps

# Waybar
pkill waybar
waybar &

# Hyprland configs are normally sourced, but reload if needed
hyprctl reload

notify-send "Theme switched" "󰏘 $THEME"
