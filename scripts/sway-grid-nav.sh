#!/bin/bash
# Linear workspace navigation for Hyprland
# Laptop:   1  2  3  4  5  6
# External: 7  8  9 10 11 12
# Usage: grid-nav.sh <left|right> [-m]
#   -m = move focused window along with the switch

DIRECTION="$1"
MOVE="$2"

CURRENT=$(hyprctl activeworkspace -j | jq '.id')

if [ "$CURRENT" -ge 1 ] && [ "$CURRENT" -le 6 ]; then
    MIN=1; MAX=6
elif [ "$CURRENT" -ge 7 ] && [ "$CURRENT" -le 12 ]; then
    MIN=7; MAX=12
else
    exit 1
fi

case "$DIRECTION" in
    left)
        TARGET=$((CURRENT - 1))
        [ "$TARGET" -lt "$MIN" ] && TARGET=$MAX
        ;;
    right)
        TARGET=$((CURRENT + 1))
        [ "$TARGET" -gt "$MAX" ] && TARGET=$MIN
        ;;
    *) exit 1 ;;
esac

if [ "$MOVE" = "-m" ]; then
    hyprctl dispatch movetoworkspace "$TARGET"
else
    hyprctl dispatch workspace "$TARGET"
fi
