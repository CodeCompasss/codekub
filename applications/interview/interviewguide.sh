cat <<EOF >~/.local/share/applications/InterviewGuide.desktop
[Desktop Entry]
Name=Interview Guide
Comment=Technical knowledge for software engineering interviews
Exec=xdg-open https://interviewguide.dev/technical-knowledge
Icon=/home/$USER/.local/share/omakub/applications/icons/interviewguide.png
Terminal=false
Type=Application
Categories=X-Interview;
StartupNotify=true
EOF
