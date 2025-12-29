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

echo "Cloning codekub in omakub-bin branch ..."
rm -rf ~/.local/share/omakub
git clone --branch omakub-bin --single-branch https://github.com/CodeCompasss/codekub.git ~/.local/share/omakub >/dev/null

cd ~/.local/share/omakub
current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "✅ Cloned branch: $current_branch"

if [[ -n "$OMAKUB_REF" ]]; then
    git fetch origin "$OMAKUB_REF"
    git checkout "$OMAKUB_REF"
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    echo "✅ Switched to branch: $current_branch"
fi
cd -


echo "Installation starting..."
source ~/.local/share/omakub/install.sh