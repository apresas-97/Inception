#!/bin/bash

if [ ! -d $WORDPRESS_PATH ];
then
    wp core download --path=$WORDPRESS_PATH --allow-root
fi

cd $WORDPRESS_PATH;

if  ! ( [ -f "wp-config.php" ] && wp config has DB_PASSWORD --allow-root );
then
    cp wp-config-sample.php wp-config.php

# TO-DO: Make sense of all of these ENV variables
    wp config set --allow-root DB_HOST $DB_HOST --path="."
    wp config set --allow-root DB_NAME $DB_DATABASE --path="." 
    wp config set --allow-root DB_USER $DB_USER --path="."
    wp config set --allow-root DB_PASSWORD "${DB_USER_PASSWORD}" --path="." --quiet
    wp config set --allow-root table_prefix $DB_TABLE_PREFIX --path="."
    wp config set --allow-root WP_DEBUG false --path="." --raw
    wp config set --allow-root WP_DEBUG_LOG false --path="." --raw

    # TO-DO: Understand this
    wp config shuffle-salts --allow-root

    # TO-DO: Understand this
    # TO-DO: Make sense of all of these ENV variables
    wp core install --allow-root \
        --path="." \
        --url=$DOMAIN_NAME \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL
    wp plugin update --path="." --allow-root --all

    # Create user
    wp user create --path=$WP_PATH --allow-root \
        $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD \
        --role=author --porcelain
fi

# TO-DO: Understand this (Creates PID file(???))
php-fpm7.4 -F
