import pandas as pd
import psycopg2
import matplotlib.pyplot as plt

def plot_daily_purchase(conexion):
    query = "SELECT event_time, user_id FROM customers WHERE event_type = 'purchase';"
    df = pd.read_sql_query(query, conexion)
    df['event_time'] = pd.to_datetime(df['event_time'])
    daily_purchase = df.groupby(df['event_time'].dt.date)['user_id'].nunique()

    months = ['Oct', 'Nov', 'Dec', 'Jan', 'Feb']
    month_numbers = [10, 11, 12, 1, 2]
    month_starts = []
    for m in month_numbers:
        dates = [d for d in daily_purchase.index if d.month == m]
        if dates:
            month_starts.append(min(dates))

    plt.figure()
    plt.plot(daily_purchase.index, daily_purchase.values)
    plt.xticks(month_starts, months)
    plt.ylabel('Number of customers')
    plt.tight_layout()
    plt.savefig('daily_purchase.png', dpi=300)
    plt.show()

def plot_altarian_sales(conexion):
    query = "SELECT event_time, price FROM customers WHERE event_type = 'purchase';"
    df = pd.read_sql_query(query, conexion)
    df['event_time'] = pd.to_datetime(df['event_time'])
    df['month'] = df['event_time'].dt.to_period('M')
    sales_per_month = df.groupby('month')['price'].sum() / 1_000_000

    # Obtener los meses presentes en los datos y sus siglas
    months = ['Oct', 'Nov', 'Dec', 'Jan', 'Feb']
    month_numbers = [10, 11, 12, 1, 2]
    month_labels = []
    for m in month_numbers:
        for d in sales_per_month.index.to_timestamp():
            if d.month == m:
                month_labels.append(d.strftime('%b'))
                break

    plt.figure()
    plt.bar(month_labels, sales_per_month.values)
    plt.xlabel('Month')
    plt.ylabel('Total sales in million of ₳')
    plt.ylim(0.0, 1.8)
    plt.tight_layout()
    plt.savefig('ventas_altarian.png')
    plt.show()

def plot_total_sales(conexion):
    query = "SELECT event_time, price, user_id FROM customers WHERE event_type = 'purchase';"
    df = pd.read_sql_query(query, conexion)
    df['event_time'] = pd.to_datetime(df['event_time'])
    df['month'] = df['event_time'].dt.to_period('M')
    
    # Total ventas por mes
    total_sales = df.groupby('month')['price'].sum()
    # Clientes únicos por mes
    unique_customers = df.groupby('month')['user_id'].nunique()
    # Gasto medio por cliente por mes
    avg_spend = total_sales / unique_customers

    month_labels = [d.strftime('%b') for d in avg_spend.index.to_timestamp()]

    plt.figure()
    plt.fill_between(month_labels, avg_spend.values, color='skyblue', alpha=0.5)
    plt.plot(month_labels, avg_spend.values, marker='o', color='blue')
    plt.xlabel('Month')
    plt.ylabel('average spend/customers in ₳')
    plt.ylim(0, 60)
    plt.yticks(range(0, 65, 5))
    plt.tight_layout()
    plt.savefig('average_spend_per_customer.png')
    plt.show()

if __name__ == "__main__":
    conexion = psycopg2.connect(
        dbname="piscineds",
        user="rdelicad",
        password="mysecretpassword",
        host="localhost",
        port="5432"
    )
    plot_daily_purchase(conexion)
    plot_altarian_sales(conexion)
    plot_total_sales(conexion)
    conexion.close()