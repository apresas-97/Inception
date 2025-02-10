#!/bin/bash

mysqld_safe

echo "Creating database and user..."
echo "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};" > db_setup.sql
echo "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> db_setup.sql
echo "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';" >> db_setup.sql
echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> db_setup.sql
echo "FLUSH PRIVILEGES;" >> db_setup.sql

mysqld < db_setup.sql


kill $(cat /var/run/mysqld/mysqld.pid)

# echo "Setting root password..."
# mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

# echo "Shutting down mysqld..."
# mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

# echo "Starting MariaDB server in safe mode..."
exec mysqld_safe
