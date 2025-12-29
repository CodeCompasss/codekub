#!/bin/bash
set -e

# ------------------------------------
# Dependencies
# ------------------------------------
sudo apt update -y
sudo apt install -y \
  gnome-shell-extension-manager \
  gir1.2-gtop-2.0 \
  gir1.2-clutter-1.0

sleep 2

# Install gnome-extensions-cli only if missing
if ! command -v gext >/dev/null 2>&1; then
  pipx install gnome-extensions-cli --system-site-packages
fi

sleep 2

# ------------------------------------
# Disable Ubuntu defaults that conflict
# ------------------------------------
gnome-extensions disable tiling-assistant@ubuntu.com || true
gnome-extensions disable ubuntu-appindicators@ubuntu.com || true
gnome-extensions disable ubuntu-dock@ubuntu.com || true

sleep 2

# ------------------------------------
# Install required extensions
# ------------------------------------
gext install add-to-desktop@tommimon.github.com || true
sleep 2
gext install arcmenu@arcmenu.com || true
sleep 2
gext install caffeine@patapon.info || true
sleep 2
gext install clipboard-indicator@tudmotu.com || true
sleep 2
gext install dash-to-panel@jderose9.github.com || true
sleep 2
gext install screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com || true
sleep 2
gext install tactile@lundal.io || true
sleep 2
gext install Vitals@CoreCoding.com || true
sleep 2

# ------------------------------------
# Compile schemas (needed for gsettings)
# ------------------------------------
SCHEMA_DST="/usr/share/glib-2.0/schemas"

sudo cp ~/.local/share/gnome-shell/extensions/*/schemas/*.gschema.xml \
  "$SCHEMA_DST" 2>/dev/null || true
sudo glib-compile-schemas "$SCHEMA_DST"

sleep 2

# ------------------------------------
# Configure Tactile (tiling)
# ------------------------------------
gsettings set org.gnome.shell.extensions.tactile col-0 1 || true
gsettings set org.gnome.shell.extensions.tactile col-1 2 || true
gsettings set org.gnome.shell.extensions.tactile col-2 1 || true
gsettings set org.gnome.shell.extensions.tactile col-3 0 || true
gsettings set org.gnome.shell.extensions.tactile row-0 1 || true
gsettings set org.gnome.shell.extensions.tactile row-1 1 || true
gsettings set org.gnome.shell.extensions.tactile gap-size 32 || true

sleep 1

# ------------------------------------
# Configure ArcMenu (Enterprise layout)
# ------------------------------------
gsettings set org.gnome.shell.extensions.arcmenu menu-layout 'Enterprise' || true
gsettings set org.gnome.shell.extensions.arcmenu menu-button-icon 'start-here-symbolic' || true
gsettings set org.gnome.shell.extensions.arcmenu default-menu-view 0 || true

sleep 1

# ------------------------------------
# Configure Dash to Panel (TOP)
# ------------------------------------
gsettings set org.gnome.shell.extensions.dash-to-panel panel-position 'BOTTOM' || true
gsettings set org.gnome.shell.extensions.dash-to-panel panel-size 32 || true
gsettings set org.gnome.shell.extensions.dash-to-panel show-apps-icon false || true
gsettings set org.gnome.shell.extensions.dash-to-panel show-activities-button false || true
gsettings set org.gnome.shell.extensions.dash-to-panel show-apps-button false || true

sleep 2

# ------------------------------------
# Enable everything explicitly
# ------------------------------------
gnome-extensions enable add-to-desktop@tommimon.github.com || true
sleep 1
gnome-extensions enable arcmenu@arcmenu.com || true
sleep 1
gnome-extensions enable caffeine@patapon.info || true
sleep 1
gnome-extensions enable clipboard-indicator@tudmotu.com || true
sleep 1
gnome-extensions enable dash-to-panel@jderose9.github.com || true
sleep 1
gnome-extensions enable screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com || true
sleep 1
gnome-extensions enable tactile@lundal.io || true
sleep 1
gnome-extensions enable Vitals@CoreCoding.com || true

sleep 2

echo "✅ GNOME extensions installed and configured (fully automated)"
