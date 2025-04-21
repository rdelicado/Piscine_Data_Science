# Variables
DOCKER_COMPOSE = docker-compose
CONTAINER_DB = database
USER = rdelicad
DB = piscineds

# Colores para output
GREEN = \033[0;32m
RED = \033[0;31m
YELLOW = \033[0;33m
RESET = \033[0m

.PHONY: up down restart status check clean

# Levantar los contenedores
up:
	@echo "$(YELLOW)Levantando contenedores...$(RESET)"
	@$(DOCKER_COMPOSE) up -d
	@echo "$(GREEN)Contenedores levantados correctamente.$(RESET)"
	@echo "PostgreSQL: localhost:5432"
	@echo "pgAdmin: http://localhost:8080"
	@echo "Login pgAdmin: admin@admin.com / mysecretpassword"

# Detener los contenedores
down:
	@echo "$(YELLOW)Deteniendo contenedores...$(RESET)"
	@$(DOCKER_COMPOSE) down
	@echo "$(GREEN)Contenedores detenidos correctamente.$(RESET)"

# Reiniciar los contenedores
restart: down up

# Verificar estado de los contenedores
status:
	@echo "$(YELLOW)Estado de los contenedores:$(RESET)"
	@docker ps -a | grep -E 'database|pgadmin'

# Comprobar conexión a la base de datos
check:
	@echo "$(YELLOW)Verificando conexión a la base de datos...$(RESET)"
	@if docker exec $(CONTAINER_DB) psql -U $(USER) -d $(DB) -c "SELECT 'Conexión exitosa!' AS result;"; then \
		echo "$(GREEN)Conexión exitosa a la base de datos.$(RESET)"; \
	else \
		echo "$(RED)Error al conectar a la base de datos.$(RESET)"; \
		exit 1; \
	fi

# Eliminar contenedores, volúmenes y redes
clean: down
	@echo "$(YELLOW)Eliminando volúmenes y redes...$(RESET)"
	@docker volume rm -f postgres_data 2>/dev/null || true
	@docker network rm -f postnet 2>/dev/null || true
	@rm -r ex01/pie.png 
	@rm -r ex02/chart.png
	@rm -r ex03/plot.png
	@echo "$(GREEN)Limpieza completada.$(RESET)"

fclean: clean
	@echo "$(YELLOW)Eliminando contenedores...$(RESET)"
	@docker ps -qa | xargs -r docker stop
	@docker ps -qa | xargs -r docker rm
	@docker images -qa | xargs -r docker rmi -f
	@docker volume ls -q | xargs -r docker volume rm
	@docker network ls -q | xargs -r docker network rm 2>/dev/null || true
	@echo "$(GREEN)Limpieza completa.$(RESET)"

# Ayuda
help:
	@echo "$(YELLOW)Comandos disponibles:$(RESET)"
	@echo "  make up       - Levantar los contenedores"
	@echo "  make down     - Detener los contenedores"
	@echo "  make restart  - Reiniciar los contenedores"
	@echo "  make status   - Verificar estado de los contenedores"
	@echo "  make check    - Comprobar conexión a la base de datos"
	@echo "  make clean    - Eliminar contenedores, volúmenes y redes"
	@echo "  make help     - Mostrar esta ayuda"