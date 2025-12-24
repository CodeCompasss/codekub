cat <<EOF >~/.local/share/applications/Exercism.desktop
[Desktop Entry]
Name=Exercism
Comment=Practice programming exercises with mentorship
Exec=xdg-open https://exercism.org/
Icon=exercism
Terminal=false
Type=Application
Categories=Education;
StartupNotify=true
EOF
