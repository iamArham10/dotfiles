#!/bin/bash
# Freeze the screen
hyprpicker -r -z &
PICKER_PID=$!

# Give it a tiny moment to freeze
sleep 0.1

# Allow user to select a region OR click a specific window to select it
# This uses jq to feed window coordinates into slurp
GEOM=$(hyprctl clients -j | jq -r '.[] | select(.hidden == false and .workspace.id == (hyprctl activeworkspace -j | jq -r .id)) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | slurp)

# Kill the freeze effect
kill $PICKER_PID

# Exit if user pressed escape (cancelled)
if [ -z "$GEOM" ]; then
    exit 1
fi

# Take the screenshot
IMG="/tmp/screenshot-$(date +%s).png"
grim -g "$GEOM" "$IMG"

# Automatically copy it to clipboard!
wl-copy < "$IMG"

# Open it in Satty so you can edit, annotate, or save it permanently
satty -f "$IMG" --early-exit

# Cleanup
rm "$IMG"
