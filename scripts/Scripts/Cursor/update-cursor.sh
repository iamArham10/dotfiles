#!/bin/bash

# Stop if anything fails
set -e

# Directory where Cursor is stored
APP_DIR="$HOME/Applications/Cursor"
APP_PATH="$APP_DIR/Cursor.AppImage"
TMP_PATH="$APP_DIR/Cursor-latest.AppImage"

# Check if download link is given
if [ -z "$1" ]; then
    echo "Usage: $0 <download_link>"
    exit 1
fi

DOWNLOAD_LINK="$1"

echo "Downloading latest Cursor from:"
echo "$DOWNLOAD_LINK"
echo

# Download new AppImage
wget -O "$TMP_PATH" "$DOWNLOAD_LINK"

# Make it executable
chmod +x "$TMP_PATH"

# Delete old file if it exists
if [ -f "$APP_PATH" ]; then
    rm -f "$APP_PATH"
fi

# Move new file in place
mv "$TMP_PATH" "$APP_PATH"

echo "Cursor updated successfully."
