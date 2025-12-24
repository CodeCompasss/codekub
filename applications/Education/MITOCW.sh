cat <<EOF >~/.local/share/applications/MITOCW.desktop
[Desktop Entry]
Name=MIT OpenCourseWare
Comment=Free MIT courses and learning resources
Exec=xdg-open https://ocw.mit.edu/
Icon=/home/$USER/.local/share/omakub/applications/icons/mitocw.png
Terminal=false
Type=Application
Categories=Education;
StartupNotify=true
EOF
