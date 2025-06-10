#!/bin/bash
# You need to make chmod +x install.sh before running
DEST="/usr/bin/BeaverSploit-Ruby"

echo "Uninstalling BeaverSploit-Ruby from $DEST..."
sudo rm -rf "$DEST"
if [ $? -eq 0 ]; then
  echo "Uninstallation complete."
else
  echo "Error during uninstallation."
fi