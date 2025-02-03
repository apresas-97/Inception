FROM debian:bullseye

RUN apt-get update && apt-get install -y --no-install-recommends \
	mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

COPY --chmod=755 ./tools/script.sh /usr/local/bin/script.sh

EXPOSE 3306

ENTRYPOINT [ "/usr/local/bin/script.sh" ]
