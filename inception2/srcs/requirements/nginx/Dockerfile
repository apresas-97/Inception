FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

#CHECK spnzed's version
COPY conf/default.conf /etc/nginx/nginx.conf

#CHECK spnzed's version
RUN mkdir -p /etc/ssl/private /etc/ssl/certs \
    && openssl req -x509 -sha256 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/C=ES/ST=Catalunya/L=Barcelona/O=42/OU=42_Barcelona/CN=apresas.42.fr"

#CHECK spnzed's version
#RUN mkdir -p /run/nginx
#RUN chmod -R 755 /var/www/html
#RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

STOPSIGNAL SIGQUIT

CMD [ "nginx", "-g", "daemon off;" ]
