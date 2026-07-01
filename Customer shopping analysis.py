import pandas as pd
df = pd.read_csv(r'C:\\Users\\mythi\\Downloads\\Customer shopping Details.csv')
df.head()
df.info()
df.describe(include='all')

df.isnull().sum()
df.columns = df.columns.str.strip().str.lower().str.replace(' ', '_')
df = df.rename(columns={'purchase_amount_(usd)':'purchase_amount'})

df.columns

# create a column age_group
labels = ['Young Adult','Adult',' Middle-aged', 'Senior']
df['age_group'] = pd.qcut(df['age'], q=4,labels = labels)

df[['age','age_group']].head(10)

df[['discount_applied','promo_code']].head(10)


(df['discount_applied'] == df['promo_code']).all()

df = df.drop('promo_code', axis=1)
df.columns
pip install sqlalchemy pymysql
from sqlalchemy import create_engine
engine = create_engine('mysql+pymysql://root:@localhost:3306/Customer_shopping_db')

# Database create
conn = pymysql.connect(host='localhost', user='root', password='Mythili2006')
cursor = conn.cursor()
cursor.execute("CREATE DATABASE IF NOT EXISTS customer_shopping_db")
conn.close()
print("Database created!")







