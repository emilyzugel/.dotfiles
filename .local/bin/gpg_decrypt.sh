#!/usr/bin/env bash

file="$1"
output="${file%.gpg}"

gpg --output "$output" --decrypt "$file"
