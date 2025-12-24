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

# Install gnome-extensions-cli only if missing
if ! command -v gext >/dev/null 2>&1; then
  pipx install gnome-extensions-cli --system-site-packages
fi

# ------------------------------------
# Disable Ubuntu defaults that conflict
# ------------------------------------
gnome-extensions disable tiling-assistant@ubuntu.com || true
gnome-extensions disable ubuntu-appindicators@ubuntu.com || true
gnome-extensions disable ubuntu-dock@ubuntu.com || true

# ------------------------------------
# Install required extensions
# ------------------------------------
gext install add-to-desktop@tommimon.github.com || true
gext install arcmenu@arcmenu.com || true
gext install caffeine@patapon.info || true
gext install clipboard-indicator@tudmotu.com || true
gext install dash-to-panel@jderose9.github.com || true
gext install screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com || true
gext install tactile@lundal.io || true
gext install tophat@fflewddur.github.io || true

# ------------------------------------
# Compile schemas (needed for gsettings)
# ------------------------------------
SCHEMA_DST="/usr/share/glib-2.0/schemas"

sudo cp ~/.local/share/gnome-shell/extensions/*/schemas/*.gschema.xml \
  "$SCHEMA_DST" 2>/dev/null || true
sudo glib-compile-schemas "$SCHEMA_DST"

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

# ------------------------------------
# Configure ArcMenu (Enterprise layout)
# ------------------------------------
gsettings set org.gnome.shell.extensions.arcmenu menu-layout 'Enterprise' || true
gsettings set org.gnome.shell.extensions.arcmenu menu-button-icon 'start-here-symbolic' || true
gsettings set org.gnome.shell.extensions.arcmenu default-menu-view 0 || true

# ------------------------------------
# Configure Dash to Panel (TOP)
# ------------------------------------
gsettings set org.gnome.shell.extensions.dash-to-panel panel-position 'TOP' || true
gsettings set org.gnome.shell.extensions.dash-to-panel panel-size 32 || true
gsettings set org.gnome.shell.extensions.dash-to-panel show-apps-icon true || true

# ------------------------------------
# Configure TopHat (clean panel)
# ------------------------------------
gsettings set org.gnome.shell.extensions.tophat show-icons true || true
gsettings set org.gnome.shell.extensions.tophat show-cpu true || true
gsettings set org.gnome.shell.extensions.tophat show-disk true || true
gsettings set org.gnome.shell.extensions.tophat show-mem true || true
gsettings set org.gnome.shell.extensions.tophat show-fs true || true

# gsettings set org.gnome.shell.extensions.tophat network-usage-unit 'bits' || true

# ------------------------------------
# Enable everything explicitly
# ------------------------------------
gnome-extensions enable add-to-desktop@tommimon.github.com || true
gnome-extensions enable arcmenu@arcmenu.com || true
gnome-extensions enable caffeine@patapon.info || true
gnome-extensions enable clipboard-indicator@tudmotu.com || true
gnome-extensions enable dash-to-panel@jderose9.github.com || true
gnome-extensions enable screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com || true
gnome-extensions enable tactile@lundal.io || true
gnome-extensions enable tophat@fflewddur.github.io || true

echo "✅ GNOME extensions installed and configured (fully automated)"
