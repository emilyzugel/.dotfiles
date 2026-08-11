#!/usr/bin/env bash

THEME="$HOME/.dotfiles/colourSchemes/catppuccin/rofi/applauncher/theme.rasi"

exec rofi \
  -show drun \
  -theme "$THEME"
