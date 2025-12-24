cat <<EOF >~/.local/share/applications/OdinProject.desktop
[Desktop Entry]
Name=The Odin Project
Comment=Full-stack web development curriculum
Exec=xdg-open https://www.theodinproject.com/
Icon=/home/$USER/.local/share/omakub/applications/icons/odin.jpg
Terminal=false
Type=Application
Categories=Education;
StartupNotify=true
EOF
