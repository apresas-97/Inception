FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-client \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/mariadb_setup.sh /mariadb_setup.sh
RUN chmod 777 /mariadb_setup.sh

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod -R 777 /var/run/mysqld
#RUN mkdir -p /var/lib/mysqld && chown -R mysql:mysql /var/lib/mysqld && chmod -R 777 /var/lib/mysqld

EXPOSE 3306

ENTRYPOINT [ "/mariadb_setup.sh" ]
