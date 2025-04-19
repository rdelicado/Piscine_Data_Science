#!/bin/bash

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Step 1: Creating and importing customers table...${NC}"

docker exec database psql -U rdelicad -d piscineds -c "
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    event_time TIMESTAMP,
    event_type VARCHAR(50),
    product_id BIGINT,
    price NUMERIC(10, 2),
    user_id INTEGER,
    user_session UUID
);"

for csv_file in /sgoinfre/students/$USER/customer/*.csv; do
    echo -e "${GREEN}Importing CSV file: ${csv_file}...${NC}"
    docker exec -i database psql -U rdelicad -d piscineds -c "\copy customers FROM STDIN DELIMITER ',' CSV HEADER;" < "$csv_file"
done

echo -e "${YELLOW}Step 2: Removing duplicates...${NC}"

docker exec database psql -U rdelicad -d piscineds -c "
DELETE FROM customers a
USING customers b
WHERE
    a.ctid > b.ctid
    AND a.event_time = b.event_time
    AND a.event_type = b.event_type
    AND a.product_id = b.product_id
    AND a.price = b.price
    AND a.user_id = b.user_id
    AND a.user_session = b.user_session;
"

docker exec database psql -U rdelicad -d piscineds -c "
DROP TABLE IF EXISTS customers_dedup;
CREATE TABLE customers_dedup AS
SELECT event_time, event_type, product_id, price, user_id, user_session
FROM (
    SELECT *,
        lag(event_time) OVER (PARTITION BY event_type, product_id, price, user_id, user_session ORDER BY event_time) AS prev_time
    FROM customers
) sub
WHERE prev_time IS NULL
   OR EXTRACT(EPOCH FROM (event_time - prev_time)) <> 1;
"

docker exec database psql -U rdelicad -d piscineds -c "DROP TABLE customers; ALTER TABLE customers_dedup RENAME TO customers;"

echo -e "${YELLOW}Step 3: Fusing with items...${NC}"

docker exec database psql -U rdelicad -d piscineds -c "
ALTER TABLE customers
ADD COLUMN IF NOT EXISTS category_id BIGINT,
ADD COLUMN IF NOT EXISTS category_code VARCHAR(255),
ADD COLUMN IF NOT EXISTS brand VARCHAR(255);
"

docker exec database psql -U rdelicad -d piscineds -c "
DROP TABLE IF EXISTS temp_items;
CREATE TABLE temp_items (
    product_id BIGINT,
    category_id BIGINT,
    category_code VARCHAR(255),
    brand VARCHAR(255)
);
"

docker exec -i database psql -U rdelicad -d piscineds -c "\COPY temp_items FROM STDIN DELIMITER ',' CSV HEADER;" < /sgoinfre/students/$USER/item/item.csv

docker exec database psql -U rdelicad -d piscineds -c "
UPDATE customers c
SET
    category_id = COALESCE(t.category_id, c.category_id),
    category_code = COALESCE(t.category_code, c.category_code),
    brand = COALESCE(t.brand, c.brand)
FROM temp_items t
WHERE c.product_id = t.product_id;
"

docker exec database psql -U rdelicad -d piscineds -c "DROP TABLE temp_items;"

echo -e "${GREEN}All steps completed! The customers table is ready for analysis.${NC}"