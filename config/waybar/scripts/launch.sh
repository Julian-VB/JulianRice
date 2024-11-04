#!/usr/bin/env bash

killall -9 waybar
waybar -c ~/.config/swaybar/config.jsonc -s ~/.config/swaybar/style.css &
