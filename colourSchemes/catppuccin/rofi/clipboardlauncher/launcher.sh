#!/usr/bin/env bash

THEME="$HOME/.dotfiles/colourSchemes/catppuccin/rofi/clipboardlauncher/theme.rasi"

selected=$(
  cliphist list | rofi \
    -dmenu \
    -i \
    -p "Clipboard" \
    -theme "$THEME"
)

[[ -z "$selected" ]] && exit 0

printf '%s' "$selected" | cliphist decode | wl-copy

sleep 0.15

wtype -M ctrl v -m ctrl
