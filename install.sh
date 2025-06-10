#!/bin/bash
# You need to make chmod +x install.sh before running
SRC="$(dirname "$0")"
DEST="/usr/bin/BeaverSploit-Ruby"

echo "Installing BeaverSploit-Ruby to $DEST..."
sudo cp -r "$SRC" "$DEST"
if [ $? -eq 0 ]; then
  echo "Installation complete."
else
  echo "Error during installation."
fi