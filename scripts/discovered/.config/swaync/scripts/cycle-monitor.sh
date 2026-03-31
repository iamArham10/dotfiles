#!/bin/sh
# Cycle notification output: laptop ↔ external

CONFIG="$HOME/.config/swaync/config.json"
LAPTOP="eDP-1"
EXTERNAL="HDMI-A-1"

current=$(jq -r '.["notification-window-preferred-output"] // ""' "$CONFIG")

case "$current" in
    "$LAPTOP")
        next="$EXTERNAL"
        label="External monitor"
        icon="󰍹"
        ;;
    *)
        next="$LAPTOP"
        label="Laptop"
        icon="󰌢"
        ;;
esac

jq --arg out "$next" '.["notification-window-preferred-output"] = $out' "$CONFIG" > "$CONFIG.tmp"
mv "$CONFIG.tmp" "$CONFIG"

pkill -x swaync
sleep 0.3
swaync &>/dev/null & disown
sleep 0.5
notify-send "$icon  Notifications" "$label"
