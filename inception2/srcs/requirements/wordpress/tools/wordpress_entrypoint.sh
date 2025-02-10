#!/bin/bash

rm -rf ./*

sleep 5

if  [ -f "wp-config.php" ]; then
    echo "WordPress is already installed"
else
    echo "WordPress is not installed"

    echo "Downloading WordPress..."
    wp core download --allow-root

    echo "Creating wp-config.php..."
    wp config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=$MYSQL_HOST

    echo "Installing WordPress..."
    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title=$WORDPRESS_TITLE \
        --admin_user=$WORDPRESS_ADMIN \
        --admin_password=$WORDPRESS_ADMIN_PASSWORD \
        --admin_email=$WORDPRESS_ADMIN_EMAIL \
        --skip-email
    echo "WordPress installed successfully"

    echo "Creating user '${WORDPRESS_USER}'..."
    wp user create --allow-root \
        $WORDPRESS_USER \
        $WORDPRESS_USER_EMAIL \
        --role=author \
        --user_pass=$WORDPRESS_USER_PASSWORD

    echo "Installing theme twentytwentyfive..."
	wp theme install twentytwentyfive --activate --allow-root
fi

#CHECK Used to be
#php-fpm7.4 -F
/usr/sbin/php-fpm7.4 -F
