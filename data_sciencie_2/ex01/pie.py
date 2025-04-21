import pandas as pd
import psycopg2
import seaborn as sns
import matplotlib.pyplot as plt

conexion = psycopg2.connect(
    dbname="piscineds",
    user="rdelicad",
    password="mysecretpassword",
    host="localhost",
    port="5432"
)

# Consulta de event_type para saber la accion que realizo cada usuario (purchar, view, cart, etc)
query = "SELECT event_type FROM customers;"
dataframe = pd.read_sql_query(query, conexion)

# Contar la frecuencia de cada evento
event_counts = dataframe['event_type'].value_counts()

# Crear un gráfico de pastel
plt.pie(event_counts, labels=event_counts.index, autopct='%1.1f%%', startangle=140)
plt.title('Distribución de acciones de los usuarios en el sitio')
plt.axis('equal')  # Para que el gráfico sea circular
plt.savefig('grafico_pie.png')  # Guardar el gráfico como imagen
plt.show()


""" # Ahora dataframe contiene todos los datos de la tabla customers y puedes trabajar con pandas normalmente
print(dataframe.head()) """

conexion.close()
