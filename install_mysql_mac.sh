#!/bin/bash

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install MySQL
echo "Installing MySQL..."
brew install mysql

# Start MySQL service
echo "Starting MySQL service..."
brew services start mysql

# Wait for MySQL to be ready
echo "Waiting for MySQL to be ready..."
sleep 5

# Secure MySQL installation and set root password
echo "Securing MySQL installation..."
mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY 'bhupe@123';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
EOF

echo "MySQL installation and configuration completed!"
echo "Root password has been set to: bhupe@123"
echo "You can now connect to MySQL using: mysql -u root -p" 