query = """
SELECT event_time, price
FROM customers
WHERE brand = 'Altarian' AND event_type = 'purchase';
"""
df = pd.read_sql_query(query, conexion)
df['event_time'] = pd.to_datetime(df['event_time'])
df['month'] = df['event_time'].dt.to_period('M')
sales_per_month = df.groupby('month')['price'].sum() / 1_000_000

plt.bar(sales_per_month.index.astype(str), sales_per_month.values)
plt.title('Total sales (millones) de Altarian por mes')
plt.xlabel('Mes')
plt.ylabel('Ventas (millones)')
plt.savefig('ventas_altarian.png')
plt.show()

query = """
SELECT event_time, user_id, price
FROM customers
WHERE brand = 'Altarian' AND event_type = 'purchase';
"""
df = pd.read_sql_query(query, conexion)
df['event_time'] = pd.to_datetime(df['event_time'])
df['month'] = df['event_time'].dt.to_period('M')
grouped = df.groupby('month')
avg_spend = grouped['price'].sum() / grouped['user_id'].nunique()

plt.plot(avg_spend.index.astype(str), avg_spend.values, color='pink', marker='o')
plt.title('Average spend/customer en Altarian por mes')
plt.xlabel('Mes')
plt.ylabel('Gasto promedio por customer')
plt.savefig('avg_spend_altarian.png')
plt.show()