#!/bin/bash

set -e

ascii_art='   ______           __           __ __ __
  / ____/___  _____/ /____  ____/ // /_//
 / /   / __ \/ ___/ __/ _ \/ __  / // _ \
/ /___/ /_/ (__  ) /_/  __/ /_/ / //  __/
\____/\____/____/\__/\___/\__,_/_/ \___/ 
              C O D E K U B
'


echo -e "$ascii_art"
echo "=> codekub is for fresh Ubuntu 24.04+ installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

echo "Cloning codekub..."
rm -rf ~/.local/share/omakub
git clone https://github.com/CodeCompasss/codekub.git ~/.local/share/omakub >/dev/null
if [[ -n "$OMAKUB_REF" ]]; then
	cd ~/.local/share/omakub
	git fetch origin "$OMAKUB_REF"
	git checkout "$OMAKUB_REF"
	cd -
fi


echo "Installation starting..."
source ~/.local/share/omakub/install.sh
