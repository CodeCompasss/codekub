cat <<EOF >~/.local/share/applications/DevSetup.desktop
[Desktop Entry]
Version=1.0
Type=Application
Name=DevSetup
Comment=Simple way to install your programming apps
Exec=xdg-open https://codecompasss.github.io/DevSetup/
Icon=/home/$USER/.local/share/omakub/applications/icons/codecompass .png
Categories=X-CodeCompass;
Terminal=false
EOF
