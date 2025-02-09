#!/bin/bash

if [ ! -d "/var/lib/mysql/${DB_NAME}" ];
then
    echo "Database not found. Initializing mysqld..."
    service mariadb start

    echo "Creating database and user..."
    mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
    mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';"
    mysql -e "GRANT ALL ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
    mysql -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"

    echo "Setting root password..."
    mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"

    echo "Shutting down mysqld..."
    mysqladmin -u root -p$DB_ROOT_PASSWORD shutdown
fi

echo "Starting MariaDB server in safe mode..."
exec mysqld_safe
