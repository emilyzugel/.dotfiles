#!/usr/bin/env bash
## Github : @adi1090x (Aditya Shakya)

#   Styles: 1col-3btn-purple,
#           2-col-purple,
#           multi-tab-black,
#           multi-tab-green
#
#Type:

dir="$HOME/.config/rofi/launchers/styles/"
theme='2col-purple'

## Run
rofi \
  -show drun \
  -theme ${dir}/${theme}.rasi
