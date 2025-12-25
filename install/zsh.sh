#!/usr/bin/env bash
set -e

echo "▶ Starting Zsh + Oh My Zsh + Powerlevel10k setup (Omakub style)"

# -------------------------
# Paths
# -------------------------
OMAKUB_CONFIGS="$HOME/.local/share/omakub/configs"
ZSH_DIR="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$ZSH_DIR/custom"

# -------------------------
# Install Zsh if missing
# -------------------------
if ! command -v zsh >/dev/null 2>&1; then
  echo "▶ Installing Zsh"
  if [[ "$(uname)" == "Linux" ]]; then
    if command -v apt >/dev/null 2>&1; then
      sudo apt update && sudo apt install -y zsh git curl
    elif command -v dnf >/dev/null 2>&1; then
      sudo dnf install -y zsh git curl
    elif command -v pacman >/dev/null 2>&1; then
      sudo pacman -Sy --noconfirm zsh git curl
    else
      echo "✗ Unsupported Linux package manager. Install Zsh manually."
      exit 1
    fi
  elif [[ "$(uname)" == "Darwin" ]]; then
    if command -v brew >/dev/null 2>&1; then
      brew install zsh git curl
    else
      echo "✗ Homebrew not found. Install it first."
      exit 1
    fi
  else
    echo "✗ Unsupported OS. Install Zsh manually."
    exit 1
  fi
else
  echo "✓ Zsh already installed"
fi

# -------------------------
# Install Oh My Zsh
# -------------------------
if [ ! -d "$ZSH_DIR" ]; then
  echo "▶ Installing Oh My Zsh"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "✓ Oh My Zsh already installed"
fi

# -------------------------
# Install Powerlevel10k
# -------------------------
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "▶ Installing Powerlevel10k"
  git clone --depth=1 \
    https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM/themes/powerlevel10k"
else
  echo "✓ Powerlevel10k already installed"
fi

# -------------------------
# Install plugins
# -------------------------
plugins=( zsh-autosuggestions zsh-syntax-highlighting )

for plugin in "${plugins[@]}"; do
  if [ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]; then
    git clone --depth=1 \
      "https://github.com/zsh-users/$plugin.git" \
      "$ZSH_CUSTOM/plugins/$plugin"
  fi
done

# -------------------------
# Backup old configs
# -------------------------
[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
[ -f "$HOME/.p10k.zsh" ] && mv "$HOME/.p10k.zsh" "$HOME/.p10k.zsh.bak"
[ -f "$HOME/.zshenv" ] && mv "$HOME/.zshenv" "$HOME/.zshenv.bak"

# -------------------------
# Copy Omakub configs
# -------------------------
echo "▶ Copying Omakub Zsh configs"
cp "$OMAKUB_CONFIGS/zsh/zshrc" "$HOME/.zshrc"
cp "$OMAKUB_CONFIGS/zsh/p10k.zsh" "$HOME/.p10k.zsh"
[ -f "$OMAKUB_CONFIGS/zsh/zshenv" ] && cp "$OMAKUB_CONFIGS/zsh/zshenv" "$HOME/.zshenv"

chmod 644 "$HOME/.zshrc" "$HOME/.p10k.zsh"

# Prevent Powerlevel10k wizard
grep -q POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD "$HOME/.zshrc" || \
echo "export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true" >> "$HOME/.zshrc"

# -------------------------
# Optionally set Zsh as default shell
# -------------------------
if [ "$SHELL" != "$(which zsh)" ]; then
  echo "▶ Setting Zsh as default shell"
  chsh -s "$(which zsh)" || echo "⚠ Could not change shell automatically. Do it manually."
fi

# -------------------------
# Done
# -------------------------
echo "✅ Zsh + Oh My Zsh + Powerlevel10k setup complete"
echo "➡ Start a new terminal or run: exec zsh"
