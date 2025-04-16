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
	@echo "$(GREEN)Limpieza completada.$(RESET)"

ex02_setup:
	@echo "$(YELLOW)Creando tabla e importando datos para el ejercicio 02...$(RESET)"
	@docker exec database psql -U $(USER) -d $(DB) -c "DROP TABLE IF EXISTS data_2022_oct;"
	@docker exec -i database psql -U $(USER) -d $(DB) < ex02/table.sql
	@docker exec -i database psql -U $(USER) -d $(DB) -c "\copy data_2022_oct FROM '/tmp/subject/customer/data_2022_oct.csv' DELIMITER ',' CSV HEADER;"
	@echo "$(GREEN)Tabla creada e importada correctamente$(RESET)"
	@docker exec database psql -U $(USER) -d $(DB) -c "SELECT COUNT(*) FROM data_2022_oct;"
	@echo "$(YELLOW)Ejercicio 02 completado.$(RESET)"

# Ayuda
help:
	@echo "$(YELLOW)Comandos disponibles:$(RESET)"
	@echo "  make up       - Levantar los contenedores"
	@echo "  make down     - Detener los contenedores"
	@echo "  make restart  - Reiniciar los contenedores"
	@echo "  make status   - Verificar estado de los contenedores"
	@echo "  make check    - Comprobar conexión a la base de datos"
	@echo "  make clean    - Eliminar contenedores, volúmenes y redes"
	@echo "  make ex02_setup - Crear tabla e importar datos para el ejercicio 02"
	@echo "  make help     - Mostrar esta ayuda"