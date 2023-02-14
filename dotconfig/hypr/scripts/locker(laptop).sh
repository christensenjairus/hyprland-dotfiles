#!/bin/bash
killall swayidle
# Dim the screen after 60s of idle.
exec swayidle -w timeout 60 'brightnessctl set  35%-' \
                      resume 'brightnessctl set +35%'
# Lock screen after 5 mins
swayidle -w timeout 300 'swaylock' \
	before-sleep 'swaylock' &
# Turn off the display after 5m 10s of idle.
swayidle -w timeout 310 'hyprctl dispatch dpms off eDP-1' \
                      resume 'hyprctl dispatch dpms on eDP-1' &
# Turn off display sooner of locked
swayidle -w timeout 10 'if pgrep -x swaylock; then hyprctl dispatch dpms off eDP-1; fi' &
# Sleep computer
swayidle -w timeout 1000 'systemctl suspend-then-hibernate'