cat <<EOF >~/.local/share/applications/freeCodeCamp.desktop
[Desktop Entry]
Name=freeCodeCamp
Comment=Interactive coding lessons and projects
Exec=xdg-open https://www.freecodecamp.org/
Icon=/home/$USER/.local/share/omakub/applications/icons/freecodecamp
Terminal=false
Type=Application
Categories=Education;
StartupNotify=true
EOF
