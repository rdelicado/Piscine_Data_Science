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

# Query event_type to know the action performed by each user (purchase, view, cart, etc)
query = "SELECT event_type FROM customers;"
dataframe = pd.read_sql_query(query, conexion)

# Count the frequency of each event
event_counts = dataframe['event_type'].value_counts()

# Create a pie chart
plt.pie(event_counts, labels=event_counts.index, autopct='%1.1f%%', startangle=180)
plt.axis('equal')  # To make the chart circular
plt.savefig('pie.png')  # Save the chart as an image
plt.show()

conexion.close()
