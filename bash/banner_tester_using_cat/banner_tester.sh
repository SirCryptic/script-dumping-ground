#!/bin/bash

# Developer: SirCryptic
# Info:      Banner Tester Using cat & randomisation w/color (totally random shit 🤷🤷)
colors=(
    "$(tput setaf 0)"
    "$(tput setaf 1)"
    "$(tput setaf 2)"
    "$(tput setaf 3)"
    "$(tput setaf 4)"
    "$(tput setaf 5)"
    "$(tput setaf 6)"
    "$(tput setaf 7)"
    "$(tput sgr0)"
)
banner_files=(
    "banners/banner1.txt"
    "banners/banner2.txt"
    "banners/banner3.txt"
    "banners/banner4.txt"
    "banners/banner5.txt"
    "banners/banner6.txt"
    "banners/banner7.txt"
)
title="Banner Tester"
echo -e '\033]2;'$title'\007'

# Select a random banner file and color
selected_banner=${banner_files[RANDOM % ${#banner_files[@]}]}
random_color=$((RANDOM % 8))
color=${colors[$random_color]}

# Print the banner with the selected color
cat "$selected_banner" | sed "s/.*/${color}&${colors[8]}/"
echo ""