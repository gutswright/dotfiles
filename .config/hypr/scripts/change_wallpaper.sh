#!/bin/bash
WALLPAPER_DIR="$HOME/dotfiles/.config/hypr/wallpapers"
WALLPAPERS=$(find "$WALLPAPER_DIR" -type f)
IFS=$'\n' read -r -d '' RANDOM_WALLPAPER <<<"$(shuf -n 1 <<<"$WALLPAPERS")"

# Create or update hyprpaper.conf with the randomly selected wallpaper
cat >"$HOME/.config/hypr/hyprpaper.conf" <<EOF
preload = $RANDOM_WALLPAPER

wallpaper = eDP-1,$RANDOM_WALLPAPER
wallpaper = HDMI-A-1,$RANDOM_WALLPAPER
wallpaper = DP-1,$RANDOM_WALLPAPER
EOF

# Start hyprpaper with the new configuration
hyprpaper &

echo "Set wallpaper to: $RANDOM_WALLPAPER"
