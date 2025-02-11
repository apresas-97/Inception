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

restart: down up

volumes:
	sudo $(MKDIR) $(HOME)/data/mysql
	sudo $(MKDIR) $(HOME)/data/wordpress
	sudo chown -R $(USER) $(HOME)/data/
	sudo chmod -R 755 $(HOME)/data/

clean:
	docker compose -f $(YML_FILE) -p $(PROJECT_NAME) $(DOWN) $(DOWN_FLAGS)
	docker system prune -af --volumes

fclean: clean
	@echo "WARNING: This will permanently delete all data from the volumes"
	@read -p "Are you sure you want to delete all data? (y/N): " confirm && [ "$$confirm" = "y" ]
	rm -rf $(HOME)/data/mysql/*
	rm -rf $(HOME)/data/wordpress/*

check_data:
	$(info Checking docker data:)
	docker ps -qa
	docker images -qa
	docker volume ls -q
	docker network ls -q

re: clean all

.PHONY: all up down restart volumes clean fclean check_data re
