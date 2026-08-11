#!/usr/bin/env bash

THEME="$HOME/.dotfiles/colourSchemes/blackout/rofi/applauncher/theme.rasi"

exec rofi \
  -show drun \
  -theme "$THEME"
