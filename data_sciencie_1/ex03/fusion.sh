#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Adding columns to customers...${NC}"

docker exec database psql -U rdelicad -d piscineds -c "
ALTER TABLE customers
ADD COLUMN IF NOT EXISTS category_id BIGINT,
ADD COLUMN IF NOT EXISTS category_code VARCHAR(255),
ADD COLUMN IF NOT EXISTS brand VARCHAR(255);
"

echo -e "${YELLOW}Importing items.csv into a temporary table...${NC}"

docker exec database psql -U rdelicad -d piscineds -c "
DROP TABLE IF EXISTS temp_items;
CREATE TABLE temp_items (
    product_id BIGINT,
    category_id BIGINT,
    category_code VARCHAR(255),
    brand VARCHAR(255)
);
"

docker exec database psql -U rdelicad -d piscineds -c "\COPY temp_items FROM '/tmp/data/item/item.csv' DELIMITER ',' CSV HEADER;"

echo -e "${YELLOW}Updating customers with items data...${NC}"

docker exec database psql -U rdelicad -d piscineds -c "
UPDATE customers c
SET
    category_id = t.category_id,
    category_code = t.category_code,
    brand = t.brand
FROM temp_items t
WHERE c.product_id = t.product_id;
"

docker exec database psql -U rdelicad -d piscineds -c "DROP TABLE temp_items;"

echo -e "${GREEN}Fusion completed!${NC}"