#!/bin/bash
set -e

ascii_art='
   ______          __            ______                               
  / ____/___  ____/ /___  _____/ ____/___  ____ ___  ____  ____ ______
 / /   / __ \/ __  / __ \/ ___/ /   / __ \/ __ `__ \/ __ \/ __ `/ ___/
/ /___/ /_/ / /_/ / /_/ / /  / /___/ /_/ / / / / / / /_/ / /_/ (__  ) 
\____/\____/\__,_/\____/_/   \____/\____/_/ /_/ /_/ .___/\__,_/____/  
                                                   /_/                
                     c o d e   k u b
'

echo -e "$ascii_art"
echo "=> Codekub is for fresh Ubuntu 24.04+ installations only!"
echo -e "\nBegin installation (or abort with Ctrl+C)..."

# -------------------------------------------------
# Minimal requirements
# -------------------------------------------------
sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

# -------------------------------------------------
# Clone Codekub
# -------------------------------------------------
echo "Cloning Codekub (dev branch)..."
rm -rf ~/.local/share/omakub
git clone https://github.com/CodeCompasss/codekub.git ~/.local/share/omakub >/dev/null

cd ~/.local/share/omakub

# Ensure dev branch exists
if ! git show-ref --verify --quiet refs/remotes/origin/dev; then
  echo "❌ ERROR: dev branch not found in repository"
  exit 1
fi

# Switch to dev
git fetch origin dev >/dev/null
git checkout dev >/dev/null

current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "✅ Codekub branch: $current_branch"
cd -

# -------------------------------------------------
# Start installation
# -------------------------------------------------
echo "=================================="
echo "🚀 Starting Codekub installation"
echo "🌿 Branch: $current_branch"
echo "=================================="

source ~/.local/share/omakub/install.sh
