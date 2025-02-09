#!/bin/bash

mkdir -p /run/php

if ! [ -d "/var/www/html" ]; then
    wp core download --path=/var/www/html --allow-root
fi

cd /var/www/html

if  [ -f "wp-config.php" ]; then
    if wp config has DB_PASSWORD --allow-root; then
        rm -rf wp-config.php
    fi
fi
if ! [ -f "wp-config.php" ]; then
    wp core download --allow-root --path=/var/www/html
    wp config create --allow-root --path=/var/www/html \
        --dbname=$DB_NAME \
        --dbuser=$DB_USER \
        --dbpass=$DB_USER_PASSWORD \
        --dbhost=$DB_HOST
    wp core install --allow-root --path=/var/www/html \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --skip-email
    wp user create --allow-root --path=/var/www/html \
        $WP_USER \
        $WP_USER_EMAIL \
        --role=author \
        --user_pass=$WP_USER_PASSWORD
	wp theme install twentytwentyfive --activate --allow-root
fi

php-fpm7.4 -F
