cat <<EOF >~/.local/share/applications/KnightLabMystery.desktop
[Desktop Entry]
Name=Knight Lab Mystery
Comment=SQL puzzle game to solve mysteries
Exec=xdg-open https://mystery.knightlab.com/
Icon=/home/$USER/.local/share/omakub/applications/icons/sqlmurder.png
Terminal=false
Type=Application
Categories=Game;SQL;
StartupNotify=true
EOF
