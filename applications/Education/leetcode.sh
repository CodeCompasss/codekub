cat <<EOF >~/.local/share/applications/LeetCode.desktop
[Desktop Entry]
Name=LeetCode
Comment=Learn algorithms and prepare for coding interviews
Exec=xdg-open https://leetcode.com/
Icon=/home/$USER/.local/share/omakub/applications/icons/leetcode.png
Terminal=false
Type=Application
Categories=Education;
StartupNotify=true
EOF
