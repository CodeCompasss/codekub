#!/bin/bash

set -e

ascii_art='   _____          _      _  __     _     
  / ____|        | |    | |/ /    | |    
 | |     ___   __| | ___| \' / ___ | |__  
 | |    / _ \ / _` |/ _ \  < / _ \| \'_ \ 
 | |___| (_) | (_| |  __/ . \ (_) | |_) |
  \_____\___/ \__,_|\___|_|\_\___/|_.__/ 
'


echo -e "$ascii_art"
echo "=> Omakub is for fresh Ubuntu 24.04+ installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

echo "Cloning Omakub..."
rm -rf ~/.local/share/omakub
git clone https://github.com/CodeCompasss/codekub.git ~/.local/share/omakub >/dev/null

if [[ $OMAKUB_REF != "master" ]]; then
    cd ~/.local/share/omakub
    git fetch origin "${OMAKUB_REF:-stable}" && git checkout "${OMAKUB_REF:-stable}"
    cd -
fi

echo "Installation starting..."
source ~/.local/share/omakub/install.sh
