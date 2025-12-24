cat <<EOF >~/.local/share/applications/OSSU.desktop
[Desktop Entry]
Name=OSSU Computer Science
Comment=Free self-taught Computer Science degree using online resources
Exec=xdg-open https://cs.ossu.dev/
Icon=/home/$USER/.local/share/omakub/applications/icons/ossu
Terminal=false
Type=Application
Categories=Education;
StartupNotify=true
EOF
