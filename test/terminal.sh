#!/usr/bin/env bash
set -euo pipefail

echo "▶ Checking terminal & dev environment"
echo "-------------------------------------"

INSTALLED=()
MISSING=()

# -------------------------
# Helper
# -------------------------
check() {
  local name="$1"
  local bin="$2"

  if command -v "$bin" >/dev/null 2>&1; then
    printf "  %-30s ✅ (%s)\n" "$name" "$bin"
    INSTALLED+=("$name")
  else
    printf "  %-30s ❌ MISSING\n" "$name"
    MISSING+=("$name")
  fi
}

# -------------------------
# Terminal utilities
# -------------------------
check "btop" btop
check "fastfetch" fastfetch
check "fzf" fzf
check "ripgrep" rg
check "bat" bat
check "eza" eza
check "zoxide" zoxide
check "fd" fd
check "plocate" plocate

# -------------------------
# Git & CLI tools
# -------------------------
check "git" git
check "GitHub CLI" gh
check "lazygit" lazygit
check "lazydocker" lazydocker
check "zellij" zellij

# -------------------------
# Editors
# -------------------------
check "Neovim" nvim

# -------------------------
# Containers & infra
# -------------------------
check "Docker" docker
check "Docker Compose" docker-compose

# -------------------------
# Compilers / build tools
# -------------------------
check "GCC (build-essential)" gcc
check "Make" make
check "Clang" clang
check "pkg-config" pkg-config
check "autoconf" autoconf
check "bison" bison
check "flex" flex

# -------------------------
# Dev languages
# -------------------------
check "Node.js" node
check "npm" npm
check "Python" python3
check "pip" pip3
check "Java" java
check "Rust" rustc
check "Cargo" cargo
check "PHP" php
check "Composer" composer

# -------------------------
# Databases / clients
# -------------------------
check "Redis CLI" redis-cli
check "SQLite3" sqlite3
check "PostgreSQL client" psql
check "MySQL client" mysql

# -------------------------
# Misc
# -------------------------
check "Apache utils (htpasswd)" htpasswd
check "SSH" ssh
check "mise" mise

# -------------------------
# Summary
# -------------------------
echo
echo "-------------------------------------"
echo "📊 SUMMARY"
echo "-------------------------------------"
echo "✅ Installed : ${#INSTALLED[@]}"
echo "❌ Missing   : ${#MISSING[@]}"

if (( ${#MISSING[@]} > 0 )); then
  echo
  echo "❌ MISSING TOOLS:"
  for tool in "${MISSING[@]}"; do
    echo "   • $tool"
  done
else
  echo
  echo "🎉 Everything is installed!"
fi

echo
echo "✅ Terminal environment check complete"
