# Piscine_Data_Science

1. **Create the virtual environment:**
   ```bash
   python -m venv venv
   ```

2. **Activate the virtual environment:**
   ```bash
   source venv/Scripts/activate
   ```

3. **(Optional) Install packages:**
   ```bash
   pip install pandas psycopg2 seaborn matplotlib
   ```

4. **Deactivate the virtual environment when finished:**
   ```bash
   deactivate
   ```

> **Note:**  
> If `python` is not in your PATH, try `python3`.  
> The virtual environment is created in the `venv` folder inside your project.

## Required Charts

### ex00

| Variable                        | Chart type     | Visual style            | Suggested title                  |
|----------------------------------|---------------|------------------------|----------------------------------|
| Age distribution (example)       | Pie chart     | Circular sectors        | Age distribution                 |

### ex01

| Variable                        | Chart type             | Visual style                  | Suggested title                          |
|----------------------------------|------------------------|-------------------------------|------------------------------------------|
| Total sales (million A$)         | Line chart             | Sawtooth/square wave          | Total sales per period                   |
| Number of clients                | Bar chart (vertical)   | Discrete bars                 | Number of clients per period             |
| Average spend per client         | Area chart/Filled line | Smooth curves + background color | Average spend per client per period   |