FROM debian:bullseye

RUN apt-get update && \
	apt-get install -y \
	mariadb-server

COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld && \
	chown -R mysql:mysql /var/run/mysqld && \
	chmod 777 /var/run/mysqld
# TO-DO: Veriy, why chmod 777? Are ALL permissions for everyone really necessary?

COPY --chmod=755 ./tools/mariadb.sh /usr/local/bin/mariadb.sh

EXPOSE 3306

# TO-DO: Verify this
RUN mysql_install_db

ENTRYPOINT [ "/usr/local/bin/mariadb.sh" ]