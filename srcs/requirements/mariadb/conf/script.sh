#!/bin/bash

if [ ! -f "/run/mysqld/mysqld.pid" ];
then
    sed -i 's/= 127.0.0.1/= 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
    sed -i 's/basedir/port\t\t\t\t\t= 3306\nbasedir/' /etc/mysql/mariadb.conf.d/50-server.cnf
    if [ ! -d "/var/lib/mysql/${MARIADB_DATABASE}" ];
    then
        mysql -e "CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};"
        mysql -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_USER_PASSWORD}';"
        mysql -e "GRANT APP PRIVILEGES ON *.* TO '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_USER_PASSWORD}';"
        mysql -e "GRANT APP PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
        mysql -e "FLUSH PRIVILEGES;"
        mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"
        mysqladmin -u root -p$MARIADB_ROOT_PASSWORD shutdown
    fi
fi

exec "mysqld_safe";
