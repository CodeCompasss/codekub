cat <<EOF >~/.local/share/applications/SQLNoir.desktop
[Desktop Entry]
Name=SQL Noir
Comment=Learn SQL by solving detective cases
Exec=xdg-open https://www.sqlnoir.com/
Icon=/home/$USER/.local/share/omakub/applications/icons/sqlnori.png
Terminal=false
Type=Application
Categories=Game;SQL;
StartupNotify=true
EOF
