#!/usr/bin/env bash
## Github : @adi1090x (Aditya Shakya)

### Styles: ###
#
#  .                   2col-img-bl.rasi          2col-lml.rasi
#  ..                  2col-img-coffee.rasi      two-icons.rasi
#  1col-3btn-pp.rasi   2col-img-pp.rasi          mini-1col.rasi
#  1col-cml.rasi       2col-img-solarized.rasi   multi-app-icon.rasi
#  1col-img-bw.rasi    2col-img-violet.rasi      one-line.rasi
#  1col-ml-pp.rasi     2col-img-wh.rasi

dir="$HOME/.dotfiles/rofi/launchers/"
theme='/styles/2col-img-pp'

export ROFI_FILE_BROWSER_CMD="bash -c 'kitty -e nvim \"$1\" >/dev/null 2>&1 &'"

## Run
rofi \
  -show drun \
  -theme ${dir}/${theme}.rasi
