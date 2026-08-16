#!/bin/bash
if [ -f /tmp/hypr_gaps_off ]; then
    hyprctl keyword general:gaps_in 2
    hyprctl keyword general:gaps_out 4
    hyprctl keyword general:border_size 2
    rm /tmp/hypr_gaps_off
else
    hyprctl keyword general:gaps_in 0
    hyprctl keyword general:gaps_out 0
    hyprctl keyword general:border_size 0
    touch /tmp/hypr_gaps_off
fi
