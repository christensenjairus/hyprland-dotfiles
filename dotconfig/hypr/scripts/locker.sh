#!/bin/bash
killall swayidle
# Dim the screen after 5m of idle.
#exec swayidle -w timeout 300 'brightnessctl set  15%-' \
#                      resume 'brightnessctl set +15%'
# Lock screen after 5 mins
swayidle -w timeout 300 'swaylock' \
	before-sleep 'swaylock' &
# Turn off the display after 5m 10s of idle.
swayidle -w timeout 310 'hyprctl dispatch dpms off DP-1 && hyprctl dispatch dpms off DP-2' \
                      resume 'hyprctl dispatch dpms on DP-1 && hyprctl dispatch dpms on DP-2' &
# Turn off display sooner of locked
swayidle -w timeout 10 'if pgrep -x swaylock; then hyprctl dispatch dpms off DP-1 && hyprctl dispatch dpms off DP-2; fi' &
