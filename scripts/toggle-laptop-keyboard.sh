#!/bin/bash
# Toggle laptop keyboard on/off
# Usage: toggle-laptop-keyboard [on|off]

INHIBITED_FILE="/sys/devices/platform/i8042/serio0/input/input4/inhibited"

notify() {
    # Send desktop notification if notify-send is available
    if command -v notify-send &> /dev/null; then
        notify-send -i input-keyboard "Laptop Keyboard" "$1"
    fi
}

if [[ ! -f "$INHIBITED_FILE" ]]; then
    notify "Error: Device not found"
    exit 1
fi

current_state=$(cat "$INHIBITED_FILE")

if [[ "$1" == "on" ]]; then
    echo 0 | sudo tee "$INHIBITED_FILE" > /dev/null
    notify "ENABLED"
elif [[ "$1" == "off" ]]; then
    echo 1 | sudo tee "$INHIBITED_FILE" > /dev/null
    notify "DISABLED"
else
    # Toggle
    if [[ "$current_state" == "0" ]]; then
        echo 1 | sudo tee "$INHIBITED_FILE" > /dev/null
        notify "DISABLED"
    else
        echo 0 | sudo tee "$INHIBITED_FILE" > /dev/null
        notify "ENABLED"
    fi
fi
