#!/bin/bash
CLASS=$(hyprctl activewindow -j | jq -r ".class")
if ![ CLASS=="slack" -o CLASS=="teams-for-linux" -o CLASS=="discord" -o CLASS=="Bitwarden" -o CLASS=="com.obsproject.Studio" ]; then
    xdotool windowunmap $(xdotool getactivewindow)
else
    hyprctl dispatch killactive ""
fi
