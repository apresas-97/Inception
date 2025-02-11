FROM debian:bullseye

RUN apt-get update && apt-get install --no-install-recommends -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

COPY conf/default.conf /etc/nginx/nginx.conf

RUN mkdir -p /etc/ssl/private /etc/ssl/certs \
    && openssl req -x509 -sha256 -nodes -days 365 \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/C=ES/ST=Catalunya/L=Barcelona/O=42/OU=42_Barcelona/CN=apresas-.42.fr"

EXPOSE 443

STOPSIGNAL SIGQUIT

CMD [ "nginx", "-g", "daemon off;" ]
