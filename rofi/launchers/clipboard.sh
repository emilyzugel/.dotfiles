#!/usr/bin/env bash

dir="$HOME/.dotfiles/rofi/launchers/"
theme="/styles/mini-1col"

selected=$(cliphist list | rofi \
  -dmenu \
  -p "Clipboard" \
  -theme ${dir}/${theme}.rasi)

[ -z "$selected" ] && exit

echo "$selected" | cliphist decode | wl-copy

sleep 0.2

wtype -M ctrl v -m ctrl
