#!/usr/bin/env bash

set -euo pipefail

THEME_DIR="$HOME/.dotfiles/colourSchemes"

WAYBAR_STYLE="$HOME/.dotfiles/waybar/style.css"
KITTY_THEME="$HOME/.config/kitty"
STARSHIP_CONFIG="$HOME/.config/starship.toml"
HYPRLOOK_CONGIG="$HOME/.config/hypr/hyprlook.conf"
NVIM_THEME="$HOME/.config/nvim/lua/plugins/colorscheme.lua"
ROFI_DIR="$HOME/.dotfiles/rofi"

# Escolhe o tema
THEME=$(
  find "$THEME_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" |
    sort |
    rofi -dmenu -theme "./themechanger_rofi/theme.rasi" -i -p "Color scheme:"
)

[[ -z "$THEME" ]] && exit 0

# Wallpaper de cada tema
case "$THEME" in
blackout)
  WALLPAPER="$HOME/walls/metal_bands.jpg"
  NVIM_COLORSCHEME="habamax"
  ;;
catppuccin)
  WALLPAPER="$HOME/walls/pixelart-landscape-1.jpg"
  NVIM_COLORSCHEME="catppuccin"
  ;;
*)
  notify-send "Theme error" "No wallpaper configured for '$THEME'"
  exit 1
  ;;
esac

NEW_WAYBAR="$THEME_DIR/$THEME/waybar/style.css"
NEW_KITTY="$THEME_DIR/$THEME/kitty"
NEW_STARSHIP="$THEME_DIR/$THEME/starship.toml"
NEW_HYPRLOOK="$THEME_DIR/$THEME/hypr/hyprlook.conf"

# Verifica se todos os arquivos existem
[[ -f "$NEW_WAYBAR" ]] || {
  notify-send "Theme error" "$THEME has no Waybar style.css"
  exit 1
}

[[ -d "$NEW_KITTY" ]] || {
  notify-send "Theme error" "$THEME has no Kitty theme"
  exit 1
}

[[ -f "$NEW_STARSHIP" ]] || {
  notify-send "Theme error" "$THEME has no Starship theme"
  exit 1
}

[[ -f "$WALLPAPER" ]] || {
  notify-send "Theme error" "Wallpaper not found: $WALLPAPER"
  exit 1
}

[[ -f "$NEW_HYPRLOOK" ]] || {
  notify-send "Theme error" "Hyprlook not found: $WALLPAPER"
  exit 1
}

# Aplica o wallpaper
swww img "$WALLPAPER" \
  --transition-type center \
  --transition-step 10 \
  --transition-fps 60

# Atualiza os symlinks
ln -sfn "$NEW_WAYBAR" "$WAYBAR_STYLE"
ln -sfn "$NEW_KITTY" "$KITTY_THEME"
ln -sfn "$NEW_STARSHIP" "$STARSHIP_CONFIG"
ln -sfn "$NEW_HYPRLOOK" "$HYPRLOOK_CONGIG"

# Atualiza launchers do Rofi
ln -sfn \
  "$THEME_DIR/$THEME/rofi/wallpaperchanger/launcher.sh" \
  "$ROFI_DIR/wallpaperlauncher.symlink"

ln -sfn \
  "$THEME_DIR/$THEME/rofi/powerlauncher/launcher.sh" \
  "$ROFI_DIR/powerlauncher.symlink"

ln -sfn \
  "$THEME_DIR/$THEME/rofi/applauncher/launcher.sh" \
  "$ROFI_DIR/applauncher.symlink"

ln -sfn \
  "$THEME_DIR/$THEME/rofi/clipboardlauncher/launcher.sh" \
  "$ROFI_DIR/clipboardlauncher.symlink"

# Atualiza tema do Neovim LazyVim
if [[ -f "$NVIM_THEME" ]]; then
  sed -i "s/colorscheme = \".*\"/colorscheme = \"$NVIM_COLORSCHEME\"/" "$NVIM_THEME"
fi

# Reinicia Waybar
pkill waybar 2>/dev/null || true
waybar >/dev/null 2>&1 &

# Recarrega Kitty
pkill -SIGUSR1 kitty 2>/dev/null || true

notify-send "Theme changed" "$THEME"
