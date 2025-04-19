#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Creating customers table...${NC}"

# Find the CSV files in the container
csv_file=$(docker exec database find /tmp/data/customer -name "*.csv")

# Check if files exist 
if [ -z "$csv_file" ]; then
    echo -e "${RED}Error: CSV file not found!${NC}"
    exit 1
fi

# Create customers table
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

# Import CSV file into the customers table
csv_file=$(docker exec database find /tmp/data/customer -name "*.csv")
for csv_file in $csv_file; do
    echo -e "${GREEN}Importing CSV file: ${csv_file}...${NC}"
    docker exec database psql -U rdelicad -d piscineds -c "\copy customers FROM '$csv_file' DELIMITER ',' CSV HEADER;"
done
