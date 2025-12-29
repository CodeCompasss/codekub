#!/bin/bash

cat <<EOF >~/.local/share/applications/Omakub.desktop
[Desktop Entry]
Version=1.0
Name=codekub
Comment=Omakub Controls
# Use the default terminal and run bash commands to set PATH and OMAKUB_PATH
Exec=x-terminal-emulator -e bash -c 'export OMAKUB_PATH="$HOME/.local/share/omakub"; export PATH="$OMAKUB_PATH/bin:$HOME/.local/bin:$PATH"; "$OMAKUB_PATH/bin/omakub"; exec bash'
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/omakub/applications/icons/Omakub.png
Categories=GTK;
StartupNotify=false

EOF
