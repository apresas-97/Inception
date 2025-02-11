#!/bin/bash

chown -R mysql:mysql /var/lib/mysql
chmod -R 755 /var/lib/mysql

echo "Checking if database exists..."
if [ -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Database found."
else
    echo "Database not found. Initializing mysqld..."
    mysqld_safe &

    while ! mysqladmin ping -hlocalhost --silent; do
        sleep 1
    done

    echo "Creating database and user..."
    mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mysql -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -e "FLUSH PRIVILEGES;"

    echo "Setting root password..."
    mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

    echo "Shutting down mysqld..."
    mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
fi

echo "Starting MariaDB server..."
mysqld_safe
