#!/usr/bin/env bash

THEME="$HOME/.dotfiles/colourSchemes/solarized/rofi/powerlauncher/theme.rasi"

# System info
uptime="$(uptime -p | sed -e 's/up //g')"
host=$(hostname)

# Options
shutdown="󰐥"
reboot="󰜉"
lock="󰌾"

rofi_cmd() {
  rofi \
    -dmenu \
    -p "$host" \
    -mesg "Uptime: $uptime" \
    -theme "$THEME"
}

chosen=$(printf "%s\n%s\n%s" \
  "$shutdown" \
  "$reboot" \
  "$lock" | rofi_cmd)

case "$chosen" in

"$shutdown")
  systemctl poweroff
  ;;

"$reboot")
  systemctl reboot
  ;;

"$lock")
  loginctl lock-session
  ;;

esac
