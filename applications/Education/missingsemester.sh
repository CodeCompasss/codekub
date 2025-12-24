cat <<EOF >~/.local/share/applications/MissingSemester.desktop
[Desktop Entry]
Name=The Missing Semester (MIT)
Comment=MIT course on tools and skills for computer science
Exec=xdg-open https://missing.csail.mit.edu/
Icon=/home/$USER/.local/share/omakub/applications/icons/missingsemester.png
Terminal=false
Type=Application
Categories=Education;
StartupNotify=true
EOF
