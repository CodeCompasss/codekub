cat <<EOF >~/.local/share/applications/ElevatorSaga.desktop
[Desktop Entry]
Name=Elevator Saga
Comment=Programming game to control elevators
Exec=xdg-open http://play.elevatorsaga.com/
Icon=/home/$USER/.local/share/omakub/applications/icons/elevator.png
Terminal=false
Type=Application
Categories=Game;Web;
StartupNotify=true
EOF
