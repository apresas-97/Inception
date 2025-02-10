#!/bin/bash

echo "Setting up MariaDB..."

echo "Initialising database..."
mysqld_safe &
mysql_pid=$!

echo "Waiting for MariaDB to start..."
sleep 20
echo "MariaDB started"

echo "Creating 'root' user..."
mysql -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;"

echo "Creating database..."
mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

echo "Creating '${MYSQL_USER}' user..."
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" 

echo "Flushing privileges..."
mysql -e "FLUSH PRIVILEGES;"

echo "Shutting down MariaDB..."
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

wait $mysql_pid

echo "Starting MariaDB server in safe mode..."
exec mysqld_safe
