#!/usr/bin/env bash

THEME="$(dirname "$0")/theme.rasi"

exec rofi \
  -show drun \
  -theme "$THEME"
