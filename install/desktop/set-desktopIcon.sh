#!/bin/bash

# Apps you want on the Desktop
apps=(
  "Alacritty.desktop"
  "Neovim.desktop"
  "pinta_pinta.desktop"
  "Activity.desktop"
  "Docker.desktop"
  "Omakub.desktop"
  "org.gnome.Nautilus.desktop"
  "UserGuide.desktop"
  "CodeCompass.desktop"
  "CSEStarterGuide.desktop"
  "DevSetup.desktop"
  "Repeto.desktop"
)

# Where .desktop files live
desktop_dirs=(
  "/var/lib/flatpak/exports/share/applications"
  "/usr/share/applications"
  "/usr/local/share/applications"
  "$HOME/.local/share/applications"
)

DESKTOP="$HOME/Desktop"
mkdir -p "$DESKTOP"

for app in "${apps[@]}"; do
  for dir in "${desktop_dirs[@]}"; do
    if [ -f "$dir/$app" ]; then
      echo "Adding $app to Desktop"
      cp "$dir/$app" "$DESKTOP/"
      chmod +x "$DESKTOP/$app"
      break
    fi
  done
done

echo "Done. If icons don't appear, enable Desktop Icons in GNOME."
