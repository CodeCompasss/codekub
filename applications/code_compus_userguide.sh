cat <<EOF >~/.local/share/applications/UserGuide.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=User Guide
Comment=Open the CodeCompass user guide
Exec=xdg-open https://codecompasss.github.io/code_campus_userguide/
Terminal=false
Icon=/home/$USER/.local/share/omakub/applications/icons/codecompass .png
Categories=Education;Documentation;X-CodeCompass;
StartupNotify=true
EOF

