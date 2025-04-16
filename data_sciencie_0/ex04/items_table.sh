#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Creating items table...${NC}"

# Define CSV file path
csv_file="/tmp/subject/item/item.csv"

# Check if file exists
if docker exec database test -f "$csv_file"; then
    echo -e "${GREEN}Found CSV file: $csv_file${NC}"
else
    echo -e "\033[0;31mError: CSV file not found: $csv_file${NC}"
    exit 1
fi

# Check if the table already exists
docker exec database psql -U rdelicad -d piscineds -c "DROP TABLE IF EXISTS items;"
echo -e "${GREEN}Dropped existing items table if it existed${NC}"

# Create the table
docker exec database psql -U rdelicad -d piscineds -c "
CREATE TABLE items (
    product_id INTEGER,
    category_id BIGINT,
    category_code TEXT,
    brand VARCHAR(50)
);"
echo -e "${GREEN}Created items table${NC}"

# Import the CSV file into the table
docker exec database psql -U rdelicad -d piscineds -c "\copy items FROM '$csv_file' DELIMITER ',' CSV HEADER;"

# Count imported rows
count=$(docker exec database psql -U rdelicad -d piscineds -t -c "SELECT COUNT(*) FROM items;" | tr -d ' ')
echo -e "${GREEN}Imported $count rows into items table${NC}"

# Show table structure
echo -e "${YELLOW}Table structure:${NC}"
docker exec database psql -U rdelicad -d piscineds -c "\d items"