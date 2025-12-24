cat <<EOF >~/.local/share/applications/CheckiO.desktop
[Desktop Entry]
Name=CheckiO
Comment=Solve coding challenges through fun games
Exec=xdg-open https://checkio.org/
Icon=/home/$USER/.local/share/omakub/applications/icons/checkio.png
Terminal=false
Type=Application
Categories=Game;Web;
StartupNotify=true
EOF
