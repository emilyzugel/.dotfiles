#!/usr/bin/env bash

THEME="$HOME/.dotfiles/colourSchemes/solarized/rofi/applauncher/theme.rasi"

exec rofi \
  -show drun \
  -theme "$THEME"
