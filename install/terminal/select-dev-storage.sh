#!/bin/bash
set -e

MYSQL_ROOT_PASSWORD="root"

echo "🐬 Installing system MySQL Server..."

# -----------------------------
# Install MySQL Server
# -----------------------------
sudo apt update -y
sudo DEBIAN_FRONTEND=noninteractive apt install -y mysql-server

# -----------------------------
# Start & enable MySQL
# -----------------------------
sudo systemctl enable mysql
sudo systemctl start mysql

# -----------------------------
# Configure root user
# - Enable password login
# - Fix auth plugin
# - Allow TCP + socket
# -----------------------------
echo "🔐 Configuring MySQL root user..."

sudo mysql <<EOF
ALTER USER 'root'@'localhost'
  IDENTIFIED WITH mysql_native_password
  BY '${MYSQL_ROOT_PASSWORD}';

FLUSH PRIVILEGES;
EOF

# -----------------------------
# Ensure TCP access (localhost)
# -----------------------------
MYSQL_CONFIG="/etc/mysql/mysql.conf.d/mysqld.cnf"

sudo sed -i 's/^bind-address.*/bind-address = 127.0.0.1/' $MYSQL_CONFIG
sudo sed -i 's/^#\?port.*/port = 3306/' $MYSQL_CONFIG

# -----------------------------
# Restart MySQL
# -----------------------------
sudo systemctl restart mysql

# -----------------------------
# Install MySQL client
# -----------------------------
sudo apt install -y mysql-client

# -----------------------------
# Test connection
# -----------------------------
echo "🔍 Testing MySQL login..."
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "SELECT VERSION();"

echo ""
echo "✅ MySQL system installation complete!"
echo ""
echo "🔐 Credentials:"
echo "  User: root"
echo "  Pass: root"
echo "  Host: localhost / 127.0.0.1"
echo "  Port: 3306"
echo ""
echo "➡️ Login using:"
echo "  mysql -u root -p"
