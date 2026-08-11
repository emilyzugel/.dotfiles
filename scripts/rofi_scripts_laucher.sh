#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/.dotfiles/.local/bin"

scripts=$(find "$SCRIPTS_DIR" -type f -name "*.sh" -exec basename {} \;)

[[ -z "$scripts" ]] && notify-send "No scripts found in $SCRIPTS_DIR" && exit 1

selected=$(echo "$scripts" | rofi -dmenu -p "Scripts:")

[[ -z "$selected" ]] && exit 0

bash "$SCRIPTS_DIR/$selected"
