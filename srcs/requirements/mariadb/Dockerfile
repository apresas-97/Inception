FROM debian:bullseye

RUN apt-get update && apt-get install --no-install-recommends -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY --chmod=755 tools/mariadb_setup.sh /var/www/mariadb_setup.sh

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod -R 777 /var/run/mysqld
RUN mkdir -p /var/lib/mysql \
	&& chown -R mysql:mysql /var/lib/mysql \
	&& chmod -R 755 /var/lib/mysql

EXPOSE 3306

ENTRYPOINT [ "/var/www/mariadb_setup.sh" ]
