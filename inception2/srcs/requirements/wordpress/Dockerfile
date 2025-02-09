FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    curl \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    mariadb-client \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && wp cli update

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/wordpress_entrypoint.sh /usr/local/bin/wordpress_entrypoint.sh

EXPOSE 9000

WORKDIR /var/www/html/

ENTRYPOINT [ "/usr/local/bin/wordpress_entrypoint.sh" ]
