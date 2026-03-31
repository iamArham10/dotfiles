#!/bin/bash
# Grid workspace navigation for Hyprland
# Layout:
#   Laptop:    1  2  3      External:  7  8  9
#              4  5  6                 10 11 12
# Usage: grid-nav.sh <up|down|left|right> [-m]
#   -m = move focused window along with the switch

DIRECTION="$1"
MOVE="$2"

CURRENT=$(hyprctl activeworkspace -j | jq '.id')

# Lookup table: grid_<direction>[workspace]=target
declare -A grid_up grid_down grid_left grid_right

# Laptop grid (1-6) — up/down wrap between rows
grid_up[1]=4;    grid_up[2]=5;    grid_up[3]=6
grid_up[4]=1;    grid_up[5]=2;    grid_up[6]=3
grid_down[1]=4;  grid_down[2]=5;  grid_down[3]=6
grid_down[4]=1;  grid_down[5]=2;  grid_down[6]=3
grid_left[1]=6;  grid_left[2]=1;  grid_left[3]=2;  grid_left[4]=3;  grid_left[5]=4;  grid_left[6]=5
grid_right[1]=2; grid_right[2]=3; grid_right[3]=4; grid_right[4]=5; grid_right[5]=6; grid_right[6]=1

# External grid (7-12) — up/down wrap between rows
grid_up[7]=10;   grid_up[8]=11;   grid_up[9]=12
grid_up[10]=7;   grid_up[11]=8;   grid_up[12]=9
grid_down[7]=10; grid_down[8]=11; grid_down[9]=12
grid_down[10]=7; grid_down[11]=8; grid_down[12]=9
grid_left[7]=12; grid_left[8]=7;  grid_left[9]=8;  grid_left[10]=9;  grid_left[11]=10; grid_left[12]=11
grid_right[7]=8; grid_right[8]=9; grid_right[9]=10; grid_right[10]=11; grid_right[11]=12; grid_right[12]=7

# Get target based on direction
case "$DIRECTION" in
    up)    TARGET=${grid_up[$CURRENT]} ;;
    down)  TARGET=${grid_down[$CURRENT]} ;;
    left)  TARGET=${grid_left[$CURRENT]} ;;
    right) TARGET=${grid_right[$CURRENT]} ;;
    *)     exit 1 ;;
esac

# Do nothing if no valid target
[ -z "$TARGET" ] && exit 0

# Move window along if -m flag
if [ "$MOVE" = "-m" ]; then
    hyprctl dispatch movetoworkspace "$TARGET"
else
    hyprctl dispatch workspace "$TARGET"
fi
