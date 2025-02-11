#!/bin/bash


if  [ -f ./wp-config.php ]; then
    echo "WordPress is already installed"
else
    echo "WordPress is not installed"
    sleep 5;

    wp core download --allow-root

    echo "Generating wp-config.php..."
    wp config create --allow-root \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=$MYSQL_HOSTNAME \

    echo "Installing WordPress..."
    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="$WORDPRESS_TITLE" \
        --admin_user=$WORDPRESS_ADMIN \
        --admin_password=$WORDPRESS_ADMIN_PASSWORD \
        --admin_email=$WORDPRESS_ADMIN_EMAIL \
        --skip-email

    echo "Creating user '${WORDPRESS_USER}'..."
    wp user create --allow-root \
        $WORDPRESS_USER \
        $WORDPRESS_USER_EMAIL \
        --role=author \
        --user_pass=$WORDPRESS_USER_PASSWORD

    # echo "Installing theme twentytwentyfive..."
	# wp theme install twentytwentyfive --activate --allow-root
fi

/usr/sbin/php-fpm7.4 -F
