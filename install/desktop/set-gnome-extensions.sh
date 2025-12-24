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

    pipx install gnome-extensions-cli --system-site-packages

    # ------------------------------------
    # Disable Ubuntu defaults that conflict
    # ------------------------------------
    gnome-extensions disable tiling-assistant@ubuntu.com || true
    gnome-extensions disable ubuntu-appindicators@ubuntu.com || true
    gnome-extensions disable ubuntu-dock@ubuntu.com || true
    gnome-extensions disable ding@rastersoft.com || true

    # ------------------------------------
    # User confirmation
    # ------------------------------------
    gum confirm "Install and configure GNOME extensions now?" || exit 0

    # ------------------------------------
    # Install required extensions
    # ------------------------------------
    gext install add-to-desktop@tommimon.github.com
    gext install arcmenu@arcmenu.com
    gext install caffeine@patapon.info
    gext install clipboard-indicator@tudmotu.com
    gext install dash-to-panel@jderose9.github.com
    gext install screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com
    gext install tactile@lundal.io
    gext install tophat@fflewddur.github.io

    # ------------------------------------
    # Compile schemas (needed for gsettings)
    # ------------------------------------
    SCHEMA_DST="/usr/share/glib-2.0/schemas"

    sudo cp ~/.local/share/gnome-shell/extensions/*/schemas/*.gschema.xml "$SCHEMA_DST" 2>/dev/null || true
    sudo glib-compile-schemas "$SCHEMA_DST"

    # ------------------------------------
    # Configure Tactile (tiling)
    # ------------------------------------
    gsettings set org.gnome.shell.extensions.tactile col-0 1
    gsettings set org.gnome.shell.extensions.tactile col-1 2
    gsettings set org.gnome.shell.extensions.tactile col-2 1
    gsettings set org.gnome.shell.extensions.tactile col-3 0
    gsettings set org.gnome.shell.extensions.tactile row-0 1
    gsettings set org.gnome.shell.extensions.tactile row-1 1
    gsettings set org.gnome.shell.extensions.tactile gap-size 32

    # ------------------------------------
    # Configure ArcMenu
    # Enterprise layout by default
    # ------------------------------------
    gsettings set org.gnome.shell.extensions.arcmenu menu-layout 'Enterprise'
    gsettings set org.gnome.shell.extensions.arcmenu menu-button-icon 'start-here-symbolic'
    gsettings set org.gnome.shell.extensions.arcmenu default-menu-view 0

    # ------------------------------------
    # Configure Dash to Panel (minimal)
    # ------------------------------------
    gsettings set org.gnome.shell.extensions.dash-to-panel panel-position 'TOP'
    gsettings set org.gnome.shell.extensions.dash-to-panel panel-size 32
    gsettings set org.gnome.shell.extensions.dash-to-panel show-apps-icon true

    # ------------------------------------
    # Configure TopHat (clean panel)
    # ------------------------------------
    gsettings set org.gnome.shell.extensions.tophat show-icons false
    gsettings set org.gnome.shell.extensions.tophat show-cpu false
    gsettings set org.gnome.shell.extensions.tophat show-disk false
    gsettings set org.gnome.shell.extensions.tophat show-mem false
    gsettings set org.gnome.shell.extensions.tophat show-fs false
    gsettings set org.gnome.shell.extensions.tophat network-usage-unit 'bits'

    # ------------------------------------
    # Enable everything explicitly
    # ------------------------------------
    gnome-extensions enable add-to-desktop@tommimon.github.com
    gnome-extensions enable arcmenu@arcmenu.com
    gnome-extensions enable caffeine@patapon.info
    gnome-extensions enable clipboard-indicator@tudmotu.com
    gnome-extensions enable dash-to-panel@jderose9.github.com
    gnome-extensions enable screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com
    gnome-extensions enable tactile@lundal.io
    gnome-extensions enable tophat@fflewddur.github.io

    echo "✅ GNOME extensions installed and configured successfully"
