cat <<EOF >~/.local/share/applications/Exercism.desktop
[Desktop Entry]
Name=Exercism
Comment=Practice programming exercises with mentorship
Exec=xdg-open https://exercism.org/
Icon=/home/$USER/.local/share/omakub/applications/icons/excerism.png
Terminal=false
Type=Application
Categories=Education;
StartupNotify=true
EOF
