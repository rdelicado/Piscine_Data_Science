CREATE TABLE IF NOT EXISTS data_2022_oct (
    event_time TIMESTAMP,   --1. fecha/hora (primera columna)
    event_type VARCHAR(50), --2. texto de longitud limitada
    product_id BIGINT,      --3. número entero grande
    price NUMERIC(10, 2),   --4. Valores monetarios con precision exacta
    user_id INTEGER,         --5. IDs de usuario
    user_session UUID       --6. identificadores unicos universales
);