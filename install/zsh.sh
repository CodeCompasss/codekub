#!/usr/bin/env bash
set -euo pipefail

echo "▶ Setting up Zsh + Oh My Zsh + Powerlevel10k + Antigen"

# -------------------------
# Paths
# -------------------------
OMAKUB_CONFIGS="$HOME/.local/share/omakub/configs"
ZSH_DIR="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$ZSH_DIR/custom"
ANTIGEN="$HOME/.local/bin/antigen.zsh"

# -------------------------
# Error trap
# -------------------------
error_trap() { echo "✗ Script failed at line $1 with exit code $2"; }
trap 'error_trap $LINENO $?' ERR

# -------------------------
# Install Zsh
# -------------------------
echo "▶ Checking for Zsh..."
if ! command -v zsh >/dev/null 2>&1; then
    echo "⚠ Zsh not found. Installing..."
    if [[ "$(uname)" == "Linux" ]]; then
        if command -v apt >/dev/null 2>&1; then
            sudo apt update && sudo apt install -y zsh git curl
        elif command -v dnf >/dev/null 2>&1; then
            sudo dnf install -y zsh git curl
        elif command -v pacman >/dev/null 2>&1; then
            sudo pacman -Sy --noconfirm zsh git curl
        else
            echo "✗ Unsupported Linux package manager."; exit 1
        fi
    elif [[ "$(uname)" == "Darwin" ]]; then
        command -v brew >/dev/null 2>&1 || { echo "✗ Install Homebrew first"; exit 1; }
        brew install zsh git curl
    else
        echo "✗ Unsupported OS."; exit 1
    fi
    echo "✓ Zsh installed"
else
    echo "✓ Zsh already installed"
fi

# -------------------------
# Install Oh My Zsh
# -------------------------
[ -d "$ZSH_DIR" ] || {
    echo "▶ Installing Oh My Zsh..."
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# -------------------------
# Install Powerlevel10k
# -------------------------
[ -d "$ZSH_CUSTOM/themes/powerlevel10k" ] || {
    echo "▶ Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
}

# -------------------------
# Install Antigen
# -------------------------
[ -f "$ANTIGEN" ] || {
    echo "▶ Installing Antigen..."
    mkdir -p "$(dirname "$ANTIGEN")"
    curl -L git.io/antigen > "$ANTIGEN"
    chmod +x "$ANTIGEN"
}

# -------------------------
# Backup old configs
# -------------------------
for file in .zshrc .p10k.zsh .zshenv; do
    [ -f "$HOME/$file" ] && mv "$HOME/$file" "$HOME/$file.bak"
done

# -------------------------
# Copy Omakub configs
# -------------------------
echo "▶ Applying Omakub Zsh configs..."
cp "$OMAKUB_CONFIGS/zsh/zshrc" "$HOME/.zshrc"
cp "$OMAKUB_CONFIGS/zsh/p10k.zsh" "$HOME/.p10k.zsh"
[ -f "$OMAKUB_CONFIGS/zsh/zshenv" ] && cp "$OMAKUB_CONFIGS/zsh/zshenv" "$HOME/.zshenv"
chmod 644 "$HOME/.zshrc" "$HOME/.p10k.zsh"

# -------------------------
# Add Antigen plugin loading if missing
# -------------------------
if ! grep -q "antigen.zsh" "$HOME/.zshrc"; then
    cat << 'EOF' >> "$HOME/.zshrc"

# -------------------------
# Antigen plugin manager
# -------------------------
source $HOME/.local/bin/antigen.zsh
antigen init
antigen use oh-my-zsh
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle romkatv/powerlevel10k
antigen bundle lukechilds/zsh-nvm
antigen apply
EOF
fi

# -------------------------
# Disable Powerlevel10k wizard
# -------------------------
grep -q POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD "$HOME/.zshrc" || \
echo "export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true" >> "$HOME/.zshrc"

# -------------------------
# Detect Zsh path
# -------------------------
ZSH_PATH="$(command -v zsh || true)"
CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7 || echo "$SHELL")"

# -------------------------
# Attempt to set Zsh as default shell (best-effort)
# -------------------------
if [[ -n "$ZSH_PATH" && "$CURRENT_SHELL" != "$ZSH_PATH" ]]; then
  echo "▶ Attempting to set Zsh as default shell..."

  if [[ -t 0 ]]; then
    if chsh -s "$ZSH_PATH"; then
      echo "✓ Default shell changed to Zsh"
    else
      echo "⚠ Could not change shell automatically."
      echo "👉 Run manually: chsh -s $ZSH_PATH"
    fi
  else
    echo "⚠ Non-interactive session detected."
    echo "👉 Run manually: chsh -s $ZSH_PATH"
  fi
fi

# -------------------------
# Final instructions (NO exec, NO forcing)
# -------------------------
echo
echo "✅ Zsh setup complete!"
echo "👉 To start using Zsh now, run: zsh"
echo "👉 To make Zsh default on login, log out & back in"
echo

