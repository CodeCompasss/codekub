#!/usr/bin/env bash
set -euo pipefail

echo "▶ Checking installed desktop applications"
echo "----------------------------------------"

INSTALLED=()
MISSING=()

# -------------------------
# Helpers
# -------------------------
check_bin() {
  local name="$1"
  shift
  for bin in "$@"; do
    if command -v "$bin" >/dev/null 2>&1; then
      printf "  %-25s ✅ (%s)\n" "$name" "$bin"
      INSTALLED+=("$name")
      return 0
    fi
  done
  printf "  %-25s ❌ MISSING\n" "$name"
  MISSING+=("$name")
  return 1
}

check_flatpak() {
  local name="$1"
  local appid="$2"
  if command -v flatpak >/dev/null 2>&1 && flatpak list --app | grep -q "$appid"; then
    printf "  %-25s ✅ (flatpak)\n" "$name"
    INSTALLED+=("$name (flatpak)")
  else
    printf "  %-25s ❌ MISSING (flatpak)\n" "$name"
    MISSING+=("$name (flatpak)")
  fi
}

# -------------------------
# Terminal & utilities
# -------------------------
check_bin "Alacritty" alacritty
check_bin "Ghostty" ghostty
check_bin "wl-clipboard" wl-copy wl-paste
check_bin "Flameshot" flameshot

# -------------------------
# Browsers & communication
# -------------------------
check_bin "Google Chrome" google-chrome google-chrome-stable chrome
check_bin "Slack" slack
check_bin "Postman" postman

# -------------------------
# Editors & IDEs
# -------------------------
check_bin "VS Code" code code-insiders
check_bin "Typora" typora
check_bin "Obsidian" obsidian
check_bin "Spyder" spyder spyder3
check_bin "Xournal++" xournalpp

# -------------------------
# Media & graphics
# -------------------------
check_bin "VLC" vlc
check_bin "Pinta" pinta
check_bin "OBS Studio" obs

# -------------------------
# Office & reading
# -------------------------
check_bin "LibreOffice" libreoffice
check_bin "Readest" readest
check_bin "Lifera" liferea
check_bin "LocalSend" localsend

# -------------------------
# System / GNOME tools
# -------------------------
check_bin "GNOME Tweaks" gnome-tweaks
check_bin "GNOME Sushi" gnome-sushi
check_bin "Ulauncher" ulauncher

# -------------------------
# DOS / emulation
# -------------------------
check_bin "DOSBox" dosbox

# -------------------------
# x86 tooling
# -------------------------
check_bin "NASM (x86 assembler)" nasm

# -------------------------
# Flatpak apps
# -------------------------
check_flatpak "VLC" org.videolan.VLC
check_flatpak "Obsidian" md.obsidian.Obsidian
check_flatpak "LibreOffice" org.libreoffice.LibreOffice

# -------------------------
# Summary
# -------------------------
echo
echo "----------------------------------------"
echo "📊 SUMMARY"
echo "----------------------------------------"
echo "✅ Installed : ${#INSTALLED[@]}"
echo "❌ Missing   : ${#MISSING[@]}"

if (( ${#MISSING[@]} > 0 )); then
  echo
  echo "❌ MISSING APPLICATIONS:"
  for app in "${MISSING[@]}"; do
    echo "   • $app"
  done
else
  echo
  echo "🎉 All applications are installed!"
fi

echo
echo "✅ Desktop app check complete"
