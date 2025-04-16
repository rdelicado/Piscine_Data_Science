#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Creating automatic table...${NC}"

# List CSV files
csv_files=$(docker exec database find /tmp/subject/customer -name "*.csv")

# Procesing each CSV file
for csv_file in $csv_files; do
    filename=$(basename "$csv_file")
    table_name="${filename%.*}"

    echo -e "${GREEN}Creating table ${table_name}...${NC}"

    docker exec database psql -U rdelicad -d piscineds -c "DROP TABLE IF EXISTS ${table_name};"
    docker exec database psql -U rdelicad -d piscineds -c "
    CREATE TABLE ${table_name} (
        event_time TIMESTAMP,
        event_type VARCHAR(50),
        product_id BIGINT,
        price NUMERIC(10, 2),
        user_id INTEGER,
        user_session UUID
    );"

    echo -e "${GREEN}Table ${table_name} created successfully!${NC}"

    # Import CSV file into the table
    docker exec database psql -U rdelicad -d piscineds -c "\copy ${table_name} FROM '${csv_file}' DELIMITER ',' CSV HEADER;"
    
    count=$(docker exec database psql -U rdelicad -d piscineds -t -c "SELECT COUNT(*) FROM ${table_name};" | tr -d ' ')
    echo -e "${GREEN}Table ${table_name} imported successfully with ${count} rows!${NC}"
done

echo -e "${YELLOW}Automatic table creation completed!${NC}"

# List all tables
echo -e "${YELLOW}Listing all tables...${NC}"
docker exec database psql -U rdelicad -d piscineds -c "\dt data_*"