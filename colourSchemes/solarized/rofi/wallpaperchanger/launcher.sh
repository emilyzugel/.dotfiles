#!/usr/bin/env bash

WALLDIR="$HOME/walls"
CACHE="$HOME/.config/rofi/wallpaper-launcher/cache"
THEME="$HOME/.dotfiles/colourSchemes/solarized/rofi/wallpaperchanger/theme.rasi"

mkdir -p "$CACHE"

# gera thumbs somente se não existir
find "$WALLDIR" -type f \( \
  -iname "*.jpg" -o \
  -iname "*.png" -o \
  -iname "*.jpeg" -o \
  -iname "*.webp" \
  \) | while read -r img; do

  thumb="$CACHE/$(basename "$img")"

  [[ -f "$thumb" ]] ||
    magick "$img" -thumbnail 300x300^ \
      -gravity center \
      -extent 300x300 \
      "$thumb"

done

choice=$(
  find "$WALLDIR" -type f | while read -r img; do

    thumb="$CACHE/$(basename "$img")"

    printf "%s\0icon\x1f%s\n" \
      "$(basename "$img")" \
      "$thumb"

  done | rofi \
    -dmenu \
    -show-icons \
    -no-show-match \
    -no-sort \
    -theme "$THEME" \
    -theme-str 'inputbar { enabled: false; }'
)

[[ -z "$choice" ]] && exit

swww img "$WALLDIR/$choice" \
  --transition-type grow \
  --transition-duration 1
