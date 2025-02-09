PROJECT_NAME = inception

YML_FILE = ./srcs/docker-compose.yml

UP = up -d --build
DOWN = down
DOWN_FLAGS = --volumes --rmi all

MKDIR = mkdir -p
RM = rm -rf

USER = apresas
HOME = /home/apresas

all: up

up: volumes
	docker compose -f $(YML_FILE) -p $(PROJECT_NAME) $(UP)

down:
	docker compose -f $(YML_FILE) -p $(PROJECT_NAME) $(DOWN)

volumes:
	sudo $(MKDIR) $(HOME)/data/mysql
	sudo $(MKDIR) $(HOME)/data/wordpress
	sudo chown -R $(USER) $(HOME)/data/
	sudo chmod -R 744 $(HOME)/data/

clean:
	docker compose -f $(YML_FILE) -p $(PROJECT_NAME) $(DOWN) $(DOWN_FLAGS)
	docker system prune -af --volumes
	rm -rf $(HOME)/data/mysql/*
	rm -rf $(HOME)/data/wordpress/*

check_data:
	$(info Checking docker data:)
	docker ps -qa
	docker images -qa
	docker volume ls -q
	docker network ls -q

re: clean all

.PHONY: all up down volumes clean check_data re
