FROM debian:bullseye

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    mariadb-client \
    php7.3-fpm \
    php7.3-mysqli \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/php \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && wp cli update

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY --chmod=755 ./tools/script.sh /usr/local/bin/wordpress_setup.sh

ESPOSE 9000

ENTRYPOINT [ "/usr/local/bin/wordpress_setup.sh" ]
