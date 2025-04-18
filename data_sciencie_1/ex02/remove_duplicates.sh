#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Removing duplicates from customers table...${NC}"

# 1. Elimina duplicados exactos
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

# 2. Elimina duplicados con 1 segundo de diferencia
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

echo -e "${GREEN}Duplicates removed!${NC}"