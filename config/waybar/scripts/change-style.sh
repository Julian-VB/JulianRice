#!/bin/bash

# Define paths to your configuration files and wallpapers
CURRENT_THEME_FILE="$HOME/.config/sway/current_theme"
DARK_WALLPAPER="$HOME/.config/sway/wallpapers/dark.jpg"
LIGHT_WALLPAPER="$HOME/.config/sway/wallpapers/light.jpg"
WAYBAR_DARK_CSS="$HOME/.config/waybar/styles/style-dark.css"
WAYBAR_LIGHT_CSS="$HOME/.config/waybar/styles/style-light.css"
WOFI_DARK_CONFIG="$HOME/.config/wofi/styles/dark.css"
WOFI_LIGHT_CONFIG="$HOME/.config/wofi/styles/light.css"
WOFI_CONFIG="$HOME/.config/wofi/style.css"  # Main Wofi config
ALACRITTY_DARK_CONFIG="$HOME/.config/alacritty/colors/colors-dark.toml"
ALACRITTY_LIGHT_CONFIG="$HOME/.config/alacritty/colors/colors-light.toml"
ALACRITTY_CONFIG="$HOME/.config/alacritty/colors.toml"  # Main Alacritty config

# Load the current theme (default to dark if file doesn’t exist)
CURRENT_THEME=$(cat "$CURRENT_THEME_FILE" 2>/dev/null || echo "dark")

# Function to switch to dark theme
set_dark_theme() {
  # Wallpaper
  swaymsg output "*" bg "$DARK_WALLPAPER" fill

  # Waybar theme
  killall -9 waybar
  waybar -c ~/.config/waybar/config.jsonc -s "$WAYBAR_DARK_CSS" &

  # Alacritty theme
  cp "$ALACRITTY_DARK_CONFIG" "$ALACRITTY_CONFIG"

  # GTK theme and cursor
  gsettings set org.gnome.desktop.interface gtk-theme "Gruvbox-Dark"
  gsettings set org.gnome.desktop.interface cursor-theme "Adwaita"

  # Wofi theme
  cp "$WOFI_DARK_CONFIG" "$WOFI_CONFIG"

  # Save the current theme
  echo "dark" > "$CURRENT_THEME_FILE"
}

# Function to switch to light theme
set_light_theme() {
  # Wallpaper
  swaymsg output "*" bg "$LIGHT_WALLPAPER" fill

  # Waybar theme
  killall -9 waybar
  waybar -c ~/.config/waybar/config.jsonc -s "$WAYBAR_LIGHT_CSS" &

  # Alacritty theme
  cp "$ALACRITTY_LIGHT_CONFIG" "$ALACRITTY_CONFIG"

  # GTK theme and cursor
  gsettings set org.gnome.desktop.interface gtk-theme "Gruvbox-Light"
  gsettings set org.gnome.desktop.interface cursor-theme "Adwaita"

  # Wofi theme
  cp "$WOFI_LIGHT_CONFIG" "$WOFI_CONFIG"

  # Save the current theme
  echo "light" > "$CURRENT_THEME_FILE"
}

# Toggle between dark and light themes
if [ "$CURRENT_THEME" == "dark" ]; then
  set_light_theme
else
  set_dark_theme
fi
