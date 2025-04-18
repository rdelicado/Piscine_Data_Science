#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Creating items table and importing data...${NC}"

# 1. Crear tabla items e importar datos
docker exec database psql -U rdelicad -d piscineds -c "
DROP TABLE IF EXISTS items;
CREATE TABLE items (
    product_id BIGINT,
    category_id BIGINT,
    category_code VARCHAR(255),
    brand VARCHAR(255)
);
"
docker exec database psql -U rdelicad -d piscineds -c "\COPY items FROM '/tmp/data/subject/item/item.csv' DELIMITER ',' CSV HEADER;"

echo -e "${GREEN}Items table created and data imported successfully!${NC}"

# 2. Crear tabla items_unique con un solo registro por product_id
docker exec database psql -U rdelicad -d piscineds -c "
DROP TABLE IF EXISTS items_unique;
CREATE TABLE items_unique AS
SELECT DISTINCT ON (product_id)
    product_id, category_id, category_code, brand
FROM items;
"

echo -e "${YELLOW}Fusing customers and items tables into customers...${NC}"

# 3. Crear tabla fusionada usando items_unique
docker exec database psql -U rdelicad -d piscineds -c "
DROP TABLE IF EXISTS customers_fused;
CREATE TABLE customers_fused AS
SELECT
    c.event_time,
    c.event_type,
    c.product_id,
    c.price,
    c.user_id,
    c.user_session,
    i.category_id,
    i.category_code,
    i.brand
FROM customers c
LEFT JOIN items_unique i ON c.product_id = i.product_id;
"

echo -e "${GREEN}Fusion completed!${NC}"

# 4. Reemplazar tabla original y limpiar
docker exec database psql -U rdelicad -d piscineds -c "
DROP TABLE customers;
ALTER TABLE customers_fused RENAME TO customers;
DROP TABLE items;
DROP TABLE items_unique;
"

# 5. (Opcional) Crear índice al final
docker exec database psql -U rdelicad -d piscineds -c "CREATE INDEX idx_customers_product_id ON customers(product_id);"

echo -e "${GREEN}Final customers table ready!${NC}"