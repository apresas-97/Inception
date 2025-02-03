FROM debian:bullseye

RUN apt-get update && apt-get install -y --no-install-recommends \
	nginx \
	openssl \
	&& rm -rf /var/lib/apt/lists/*
# the last remove is to get rid of cached package lists that got
# downloaded when using apt-get update TO-DO: Confirm this

# Create a folder to store the SSL certificate
RUN mkdir -p /etc/nginx/ssl && mkdir -p /run/nginx
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=ES/ST=Catalunya/L=Barcelona/O=42/CN=${USER}.42.fr/UID=${USER}"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# TO-DO: Verify this
# RUN chmod 755 /var/www/html
# RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

# TO-DO: Verify this ()
COPY ./tools/script.sh /var/ww/nginx_start.sh

RUN chmod +x /var/www/nginx_start.sh
# TO-DO: Verify this
ENTRYPOINT [ "/var/www/nginx_start.sh" ]

CMD ["nginx", "-g", "daemon off;"]
# the -g flag is to set configuration directives
# "daemon off;" makes nginx run on the foreground, as opposed to the
# background, making it easier to debug
