import pandas as pd
import psycopg2
import matplotlib.pyplot as plt

conexion = psycopg2.connect(
    dbname="piscineds",
    user="rdelicad",
    password="mysecretpassword",
    host="localhost",
    port="5432"
)

# Cambiar la consulta para seleccionar solo los eventos 'cart' desde la tabla correcta
query = "SELECT event_time, user_id FROM customers WHERE event_type = 'cart';"
df = pd.read_sql_query(query, conexion)
df['event_time'] = pd.to_datetime(df['event_time'])

# Agrupar por día y contar usuarios únicos que hicieron 'cart'
daily_carts = df.groupby(df['event_time'].dt.date)['user_id'].nunique()

plt.figure(figsize=(8, 6))
plt.plot(daily_carts.index, daily_carts.values)
plt.xlabel('')  # Sin etiqueta abajo

# Cambiar los ticks del eje x a meses abreviados
months = ['Oct', 'Nov', 'Dec', 'Jan']
month_numbers = [10, 11, 12, 1]
# Obtener los primeros días de cada mes presente en los datos
month_starts = []
for m in month_numbers:
    dates = [d for d in daily_carts.index if d.month == m]
    if dates:
        month_starts.append(min(dates))
plt.xticks(month_starts, months)

plt.ylabel('Number of customers')
plt.tight_layout()
plt.show()

conexion.close()