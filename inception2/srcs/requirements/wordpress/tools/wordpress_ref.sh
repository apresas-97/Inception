#!/bin/bash

sleep 5;
# Check if WordPress is already installed
if [ -f ./wp-config.php ];
then
	echo "WordPress already exists"
else
	# Download WordPress
	wp core download --allow-root

	# Try to create wp-config.php
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --allow-root

	# Install WordPress
	wp core install --url=$DOMAIN_NAME --title="$WORDPRESS_TITLE" --admin_user=$WORDPRESS_ADMIN --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --skip-email --allow-root

	# Create a user
	wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=author --user_pass=$WORDPRESS_USER_PASSWORD --allow-root

	# Install and activate a theme
	wp theme install twentytwentyfour --activate --allow-root
fi

/usr/sbin/php-fpm7.4 -F;
