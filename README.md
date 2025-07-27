# 📊 Piscine Data Science

[![Language](https://img.shields.io/badge/Language-Python-blue.svg)](https://www.python.org/)
[![Database](https://img.shields.io/badge/Database-PostgreSQL-blue.svg)](https://www.postgresql.org/)
[![Analysis](https://img.shields.io/badge/Analysis-Pandas-purple.svg)](https://pandas.pydata.org/)
[![Visualization](https://img.shields.io/badge/Visualization-Matplotlib-orange.svg)](https://matplotlib.org/)
[![Container](https://img.shields.io/badge/Container-Docker-blue.svg)](https://www.docker.com/)
[![42 School](https://img.shields.io/badge/42-School_Project-purple.svg)](https://42.fr/)

## 📋 Descripción

**Piscine Data Science** es un programa intensivo de formación en ciencia de datos que cubre los fundamentos esenciales del análisis de datos, desde la gestión de bases de datos hasta la visualización avanzada. Este proyecto representa un recorrido completo por las tecnologías y metodologías fundamentales utilizadas en el mundo de la ciencia de datos moderna.

El programa está estructurado en tres módulos progresivos que abarcan SQL y bases de datos relacionales, procesamiento de datos con Python y Pandas, y visualización de datos con Matplotlib. Cada módulo incluye ejercicios prácticos y proyectos que simulan escenarios reales de análisis de datos empresariales.

### Objetivos del Programa

- **Database Management**: Dominio de SQL y gestión de bases de datos PostgreSQL
- **Data Processing**: Procesamiento y análisis de datos con Python y Pandas
- **Data Visualization**: Creación de visualizaciones efectivas con Matplotlib
- **Statistical Analysis**: Análisis estadístico y interpretación de resultados
- **Business Intelligence**: Aplicación práctica en contextos empresariales
- **ETL Processes**: Extracción, transformación y carga de datos

## 🏗️ Arquitectura del Sistema

```
                    ┌─────────────────────────────────────┐
                    │        Data Science Stack           │
                    │         (Docker Compose)            │
                    └─────────────────┬───────────────────┘
                                      │
            ┌─────────────────────────┼─────────────────────────┐
            │                         │                         │
    ┌───────▼────────┐    ┌──────────▼──────────┐    ┌───────▼────────┐
    │   PostgreSQL   │    │      Python         │    │   pgAdmin4     │
    │   Database     │    │   Data Analysis     │    │  Web Interface │
    │   Port 5432    │    │  (Pandas/Matplotlib)│    │   Port 8080    │
    └─────────────────┘    └─────────────────────┘    └────────────────┘
            │                         │                         │
    ┌───────▼────────┐    ┌──────────▼──────────┐    ┌───────▼────────┐
    │   SQL Tables   │    │    Data Processing  │    │   Database     │
    │   & Schemas    │    │     & Analysis      │    │   Management   │
    │   (Customer    │    │   (Statistics &     │    │   (Visual      │
    │    Events)     │    │   Visualization)    │    │    Admin)      │
    └────────────────┘    └─────────────────────┘    └────────────────┘

                    ┌─────────────────────────────────────┐
                    │         Data Pipeline              │
                    ├─────────────────┬───────────────────┤
                    │   Data Source   │   Data Analysis   │
                    │   (CSV Files)   │   (Python/Pandas) │
                    │   Import/ETL    │  Visualization    │
                    └─────────────────┴───────────────────┘
```

## 🚀 Módulos del Programa

### 📊 Data Science Module 0: Database Fundamentals
- **Tecnologías**: PostgreSQL, SQL, Docker
- **Enfoque**: Fundamentos de bases de datos relacionales
- **Competencias**:
  - Diseño de esquemas de bases de datos
  - Consultas SQL avanzadas
  - Gestión de tipos de datos
  - Importación y exportación de datos
  - Optimización de queries
  - Administración de bases de datos

### 🔧 Data Science Module 1: Data Engineering
- **Tecnologías**: Shell Scripting, PostgreSQL, CSV Processing
- **Enfoque**: Ingeniería de datos y automatización
- **Competencias**:
  - Automatización con shell scripts
  - Procesos ETL (Extract, Transform, Load)
  - Gestión de archivos CSV
  - Integración de sistemas
  - Monitoreo de procesos de datos
  - Administración de infraestructura

### 📈 Data Science Module 2: Data Analysis & Visualization
- **Tecnologías**: Python, Pandas, Matplotlib, NumPy
- **Enfoque**: Análisis de datos y visualización
- **Competencias**:
  - Análisis exploratorio de datos (EDA)
  - Limpieza y transformación de datos
  - Análisis estadístico descriptivo
  - Visualización de datos efectiva
  - Interpretación de resultados
  - Comunicación de insights

## 🛠️ Instalación y Configuración

### Requisitos Previos

```bash
# Docker y Docker Compose
docker --version
docker-compose --version

# Python 3.8+ (para análisis local)
python3 --version

# Git para control de versiones
git --version
```

### Configuración del Entorno

```bash
# Clonar el repositorio
git clone https://github.com/rdelicado/Piscine_Data_Science.git
cd Piscine_Data_Science

# Configurar estructura de datos
mkdir -p ~/rdelicad/data/subject
mkdir -p ~/rdelicad/data/customer

# Copiar archivos de datos (si están disponibles)
cp data_files/* ~/rdelicad/data/subject/
```

### Despliegue de la Infraestructura

**Module 0 - Database Setup**:
```bash
# Navegar al módulo 0
cd data_sciencie_0

# Levantar la infraestructura PostgreSQL
make up

# Verificar servicios
docker-compose ps

# Acceder a la base de datos
make exec

# Crear tablas iniciales
psql -U rdelicad -d piscineds -f ex02/table.sql
```

**Module 1 - Data Engineering**:
```bash
# Navegar al módulo 1
cd ../data_sciencie_1

# Levantar servicios
make up

# Ejecutar scripts de carga de datos
chmod +x ex01/customers_table.sh
./ex01/customers_table.sh

# Verificar importación de datos
make exec
```

**Module 2 - Data Analysis**:
```bash
# Navegar al módulo 2
cd ../data_sciencie_2

# Instalar dependencias Python
pip install pandas matplotlib psycopg2-binary numpy seaborn

# Ejecutar análisis de ejemplo
python ex00/pie.py

# Visualizar resultados
open ex00/pie.png
```

## 🚀 Uso del Sistema

### Gestión de Base de Datos

**Conexión y Comandos Básicos**:
```sql
-- Conectar a la base de datos
\c piscineds

-- Listar tablas
\dt

-- Describir estructura de tabla
\d customers

-- Verificar datos importados
SELECT COUNT(*) FROM customers;
SELECT * FROM customers LIMIT 10;
```

**Análisis SQL Avanzado**:
```sql
-- Análisis de eventos por tipo
SELECT 
    event_type,
    COUNT(*) as total_events,
    AVG(price) as average_price,
    SUM(price) as total_revenue
FROM customers 
WHERE event_type = 'purchase'
GROUP BY event_type
ORDER BY total_events DESC;

-- Análisis temporal de actividad
SELECT 
    DATE(event_time) as event_date,
    COUNT(*) as daily_events,
    COUNT(DISTINCT user_id) as unique_users
FROM customers
GROUP BY DATE(event_time)
ORDER BY event_date;

-- Top productos por revenue
SELECT 
    product_id,
    COUNT(*) as purchase_count,
    SUM(price) as total_revenue,
    AVG(price) as avg_price
FROM customers
WHERE event_type = 'purchase'
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 10;
```

### Análisis de Datos con Python

**Conexión y Carga de Datos**:
```python
import pandas as pd
import psycopg2
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

# Configurar conexión
def connect_db():
    return psycopg2.connect(
        dbname="piscineds",
        user="rdelicad",
        password="mysecretpassword",
        host="localhost",
        port="5432"
    )

# Cargar datos desde PostgreSQL
def load_data(query):
    conn = connect_db()
    df = pd.read_sql_query(query, conn)
    conn.close()
    return df

# Ejemplo de carga
df = load_data("SELECT * FROM customers LIMIT 1000")
print(df.head())
print(df.info())
```

**Análisis Exploratorio de Datos (EDA)**:
```python
# Estadísticas descriptivas
print("=== ESTADÍSTICAS DESCRIPTIVAS ===")
print(df.describe())

# Distribución de tipos de eventos
print("\n=== DISTRIBUCIÓN DE EVENTOS ===")
event_dist = df['event_type'].value_counts()
print(event_dist)

# Análisis temporal
df['event_time'] = pd.to_datetime(df['event_time'])
df['hour'] = df['event_time'].dt.hour
df['day_of_week'] = df['event_time'].dt.day_name()

# Actividad por hora del día
hourly_activity = df.groupby('hour').size()
print("\n=== ACTIVIDAD POR HORA ===")
print(hourly_activity)

# Análisis de precios
purchase_data = df[df['event_type'] == 'purchase']
if not purchase_data.empty:
    print("\n=== ANÁLISIS DE PRECIOS ===")
    print(f"Precio promedio: ${purchase_data['price'].mean():.2f}")
    print(f"Precio mediano: ${purchase_data['price'].median():.2f}")
    print(f"Precio máximo: ${purchase_data['price'].max():.2f}")
    print(f"Precio mínimo: ${purchase_data['price'].min():.2f}")
```

### Visualización de Datos

**Gráficos Básicos**:
```python
# Configurar estilo
plt.style.use('seaborn-v0_8')
fig, axes = plt.subplots(2, 2, figsize=(15, 12))

# 1. Distribución de tipos de eventos (Pie Chart)
event_counts = df['event_type'].value_counts()
axes[0,0].pie(event_counts.values, labels=event_counts.index, autopct='%1.1f%%')
axes[0,0].set_title('Distribución de Tipos de Eventos')

# 2. Actividad por hora del día (Bar Chart)
hourly_activity.plot(kind='bar', ax=axes[0,1])
axes[0,1].set_title('Actividad por Hora del Día')
axes[0,1].set_xlabel('Hora')
axes[0,1].set_ylabel('Número de Eventos')

# 3. Distribución de precios (Histogram)
if not purchase_data.empty:
    axes[1,0].hist(purchase_data['price'], bins=30, alpha=0.7)
    axes[1,0].set_title('Distribución de Precios')
    axes[1,0].set_xlabel('Precio')
    axes[1,0].set_ylabel('Frecuencia')

# 4. Actividad por día de la semana (Bar Chart)
daily_activity = df['day_of_week'].value_counts()
daily_activity.plot(kind='bar', ax=axes[1,1])
axes[1,1].set_title('Actividad por Día de la Semana')
axes[1,1].tick_params(axis='x', rotation=45)

plt.tight_layout()
plt.savefig('comprehensive_analysis.png', dpi=300, bbox_inches='tight')
plt.show()
```

## 📁 Estructura del Proyecto

```
Piscine_Data_Science/
├── README.md                             # Documentación principal
├── .gitignore                           # Archivos ignorados por Git
├── data_sciencie_0/                     # Módulo 0: Database Fundamentals
│   ├── Makefile                         # Automatización de comandos
│   ├── docker-compose.yml               # Configuración PostgreSQL + pgAdmin
│   ├── ex02/                            # Ejercicio: Diseño de tablas
│   │   └── table.sql                    # Script de creación de tablas
│   ├── ex03/                            # Ejercicio: Tipos de datos
│   │   └── advanced_types.sql           # Tipos de datos avanzados
│   └── ex04/                            # Ejercicio: Constraints
│       └── constraints.sql              # Restricciones y validaciones
├── data_sciencie_1/                     # Módulo 1: Data Engineering
│   ├── Makefile                         # Automatización de procesos
│   ├── docker-compose.yml               # Configuración extendida
│   ├── ex01/                            # Ejercicio: Import de datos
│   │   └── customers_table.sh           # Script de importación CSV
│   ├── ex02/                            # Ejercicio: ETL processes
│   │   ├── data_transform.sh            # Transformación de datos
│   │   └── validation.sql               # Validación de datos
│   └── ex03/                            # Ejercicio: Monitoring
│       ├── monitor.sh                   # Script de monitoreo
│       └── health_check.sql             # Verificación de salud
└── data_sciencie_2/                     # Módulo 2: Data Analysis
    ├── Makefile                         # Automatización de análisis
    ├── docker-compose.yml               # Configuración con Jupyter
    ├── data_02.pdf                      # Documentación del módulo
    ├── init_customers.sh                # Script de inicialización
    ├── ex00/                            # Ejercicio: Visualización básica
    │   ├── pie.py                       # Gráfico de torta
    │   └── pie.png                      # Resultado visual
    └── ex01/                            # Ejercicio: Análisis temporal
        ├── temporal_analysis.py         # Análisis de series temporales
        ├── trends.py                    # Análisis de tendencias
        └── seasonality.py               # Análisis de estacionalidad
```

## 🔧 Comandos Útiles del Makefile

```makefile
# Comandos principales para cada módulo

# Module 0
make up          # Levantar PostgreSQL + pgAdmin
make down        # Detener servicios
make exec        # Acceder al contenedor de base de datos
make logs        # Ver logs de PostgreSQL
make clean       # Limpiar volúmenes y datos

# Module 1
make import      # Importar datos CSV
make validate    # Validar integridad de datos
make monitor     # Monitorear procesos ETL
make backup      # Backup de base de datos
make restore     # Restaurar desde backup

# Module 2
make analyze     # Ejecutar análisis completo
make visualize   # Generar todas las visualizaciones
make report      # Generar reporte HTML
make jupyter     # Levantar Jupyter Notebook
make test        # Ejecutar tests de análisis
```

## 📊 Casos de Uso y Análisis

### Análisis de E-commerce

**Customer Journey Analysis**:
```python
def analyze_customer_journey():
    """
    Analiza el viaje del cliente desde la primera vista hasta la compra
    """
    # Secuencia de eventos por usuario
    user_journey = df.groupby('user_id')['event_type'].apply(list).reset_index()
    user_journey['journey_length'] = user_journey['event_type'].apply(len)
    
    # Conversión view -> purchase
    conversion_users = df[df['event_type'].isin(['view', 'purchase'])].groupby('user_id')['event_type'].apply(list)
    conversions = conversion_users[conversion_users.apply(lambda x: 'view' in x and 'purchase' in x)]
    
    print(f"Usuarios con conversión: {len(conversions)}")
    print(f"Tasa de conversión: {len(conversions)/len(conversion_users)*100:.2f}%")
    
    return user_journey

# Análisis de abandono de carrito
def cart_abandonment_analysis():
    """
    Analiza el abandono de carrito de compras
    """
    cart_users = df[df['event_type'] == 'cart']['user_id'].unique()
    purchase_users = df[df['event_type'] == 'purchase']['user_id'].unique()
    
    abandoned_carts = set(cart_users) - set(purchase_users)
    
    print(f"Usuarios que añadieron al carrito: {len(cart_users)}")
    print(f"Usuarios que compraron: {len(purchase_users)}")
    print(f"Carritos abandonados: {len(abandoned_carts)}")
    print(f"Tasa de abandono: {len(abandoned_carts)/len(cart_users)*100:.2f}%")
    
    return abandoned_carts
```

### Métricas y KPIs

```python
def calculate_business_kpis():
    """
    Calcula KPIs esenciales del negocio
    """
    kpis = {}
    
    # 1. Conversion Rate
    total_users = df['user_id'].nunique()
    purchasing_users = df[df['event_type'] == 'purchase']['user_id'].nunique()
    kpis['conversion_rate'] = (purchasing_users / total_users) * 100 if total_users > 0 else 0
    
    # 2. Average Order Value
    purchase_data = df[df['event_type'] == 'purchase']
    kpis['avg_order_value'] = purchase_data['price'].mean() if not purchase_data.empty else 0
    
    # 3. Revenue per User
    kpis['total_customers'] = purchasing_users
    kpis['total_revenue'] = purchase_data['price'].sum() if not purchase_data.empty else 0
    kpis['revenue_per_user'] = kpis['total_revenue'] / total_users if total_users > 0 else 0
    
    return kpis

def print_kpi_report():
    """
    Imprime un reporte formateado de KPIs
    """
    kpis = calculate_business_kpis()
    
    print("=" * 50)
    print("           BUSINESS KPIs REPORT")
    print("=" * 50)
    print(f"Conversion Rate:          {kpis['conversion_rate']:.2f}%")
    print(f"Average Order Value:      ${kpis['avg_order_value']:.2f}")
    print(f"Total Customers:          {kpis['total_customers']:,}")
    print(f"Total Revenue:            ${kpis['total_revenue']:,.2f}")
    print(f"Revenue per User:         ${kpis['revenue_per_user']:.2f}")
    print("=" * 50)
```

## 🧪 Testing y Validación

### Validación de Datos

```sql
-- Tests de integridad de datos
-- 1. Verificar que no hay valores nulos críticos
SELECT 
    COUNT(*) as total_rows,
    COUNT(user_id) as non_null_users,
    COUNT(event_time) as non_null_times,
    COUNT(event_type) as non_null_events
FROM customers;

-- 2. Verificar rangos de precios válidos
SELECT 
    MIN(price) as min_price,
    MAX(price) as max_price,
    AVG(price) as avg_price,
    COUNT(*) FILTER (WHERE price <= 0) as invalid_prices
FROM customers 
WHERE event_type = 'purchase';

-- 3. Verificar tipos de eventos válidos
SELECT DISTINCT event_type FROM customers;

-- 4. Verificar distribución temporal
SELECT 
    MIN(event_time) as earliest_event,
    MAX(event_time) as latest_event,
    COUNT(DISTINCT DATE(event_time)) as unique_days
FROM customers;
```

## 🚨 Resolución de Problemas

### Problemas Comunes de Base de Datos

```bash
# Error de conexión PostgreSQL
docker-compose logs db

# Reiniciar servicios
docker-compose down
docker-compose up -d

# Verificar estado de contenedores
docker ps

# Limpiar volúmenes corruptos
docker-compose down -v
docker volume prune
```

### Problemas de Importación de Datos

```sql
-- Verificar encoding de archivos CSV
SHOW server_encoding;

-- Importar con encoding específico
COPY customers FROM '/path/to/file.csv' 
WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
```

## 👨‍💻 Autores

**Desarrollador Principal:**
- **Rubén Delicado** - [@rdelicado](https://github.com/rdelicado)
  - 📧 rdelicad@student.42malaga.com
  - 🏫 42 Málaga
  - 📊 Especialista en Data Science y Analytics

**Áreas de Especialización:**
- **Database Engineering**: PostgreSQL, SQL avanzado, optimización de queries
- **Data Analysis**: Python, Pandas, análisis estadístico
- **Data Visualization**: Matplotlib, Seaborn, dashboards interactivos
- **ETL Processes**: Automatización de procesos de datos con Shell scripting
- **Business Intelligence**: KPIs, métricas de negocio, análisis de comportamiento

## 📜 Licencia

Este proyecto es parte del currículo de 42 School y está disponible para fines educativos. Demuestra competencias avanzadas en ciencia de datos, análisis de datos y ingeniería de datos utilizando tecnologías industriales estándar.

## 🔗 Recursos y Referencias

### Data Science y Analytics
- [Pandas Documentation](https://pandas.pydata.org/docs/)
- [Matplotlib Documentation](https://matplotlib.org/stable/)
- [Seaborn Tutorial](https://seaborn.pydata.org/tutorial.html)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

### SQL y Bases de Datos
- [PostgreSQL Tutorial](https://www.postgresqltutorial.com/)
- [SQL Best Practices](https://www.sqlstyle.guide/)
- [Database Design Principles](https://www.ibm.com/topics/database-design)
- [pgAdmin4 Documentation](https://www.pgadmin.org/docs/)

### Análisis de Datos
- [Data Analysis with Python](https://www.coursera.org/learn/data-analysis-with-python)
- [Exploratory Data Analysis](https://towardsdatascience.com/exploratory-data-analysis-8fc1cb20fd15)
- [Statistical Analysis Methods](https://www.statology.org/)
- [Business Intelligence Fundamentals](https://www.tableau.com/learn/articles/business-intelligence)

## 🚀 Extensiones Futuras

### Características Planeadas
- [ ] **Advanced Machine Learning**: Modelos predictivos con scikit-learn
- [ ] **Real-time Analytics**: Stream processing con Apache Kafka
- [ ] **Advanced Visualization**: Dashboards interactivos con Tableau/PowerBI
- [ ] **Big Data Integration**: Procesamiento con Apache Spark
- [ ] **Cloud Deployment**: Migración a AWS/GCP/Azure
- [ ] **API Development**: APIs REST para acceso a datos

### Mejoras Técnicas
- [ ] **Data Pipeline Automation**: Airflow para orquestación
- [ ] **Data Quality Monitoring**: Frameworks de validación automática
- [ ] **Performance Optimization**: Indexación y optimización de queries
- [ ] **Security Enhancement**: Encriptación y control de acceso
- [ ] **Backup & Recovery**: Estrategias de respaldo automático
- [ ] **Monitoring & Alerting**: Sistemas de monitoreo proactivo

---

<div align="center">

*"En la ciencia de datos, la capacidad de extraer insights significativos de datos complejos es lo que transforma información en conocimiento accionable para la toma de decisiones empresariales."*

**Piscine Data Science** demuestra que el dominio integral de tecnologías de datos, desde bases de datos relacionales hasta análisis estadístico avanzado, forma la base sólida para una carrera exitosa en ciencia de datos y analytics.

</div>