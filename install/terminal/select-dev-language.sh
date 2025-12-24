#!/bin/bash
set -e

echo "🚀 Installing Node.js, PHP, Python, Rust, and Java..."

# -------------------------------
# Node.js (LTS via mise)
# -------------------------------
echo "📦 Installing Node.js (LTS)"
mise use --global node@lts

# -------------------------------
# Python (latest via mise)
# -------------------------------
echo "🐍 Installing Python (latest)"
mise use --global python@latest

# -------------------------------
# Java (latest via mise)
# -------------------------------
echo "☕ Installing Java (latest)"
mise use --global java@latest

# -------------------------------
# Rust (via rustup)
# -------------------------------
echo "🦀 Installing Rust"
if ! command -v rustc >/dev/null 2>&1; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
else
  echo "Rust already installed, skipping..."
fi

# -------------------------------
# PHP + Extensions + Composer
# -------------------------------
echo "🐘 Installing PHP and extensions"

sudo apt update -y
sudo apt install -y \
  php \
  php-curl \
  php-apcu \
  php-intl \
  php-mbstring \
  php-opcache \
  php-pgsql \
  php-mysql \
  php-sqlite3 \
  php-redis \
  php-xml \
  php-zip \
  --no-install-recommends

echo "📦 Installing Composer"
if ! command -v composer >/dev/null 2>&1; then
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php composer-setup.php --quiet
  sudo mv composer.phar /usr/local/bin/composer
  rm composer-setup.php
else
  echo "Composer already installed, skipping..."
fi

echo "✅ All languages installed successfully!"
