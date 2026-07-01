#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd


# In[13]:


df = pd.read_csv(r'C:\\Users\\mythi\\Downloads\\Customer shopping Details.csv')


# In[3]:


df.head()


# In[4]:


df.info()


# In[6]:


df.describe(include='all')


# In[7]:


df.isnull().sum()


# In[16]:


df.columns = df.columns.str.strip().str.lower().str.replace(' ', '_')
df = df.rename(columns={'purchase_amount_(usd)':'purchase_amount'})


# In[17]:


df.columns


# In[18]:


# create a column age_group
labels = ['Young Adult','Adult',' Middle-aged', 'Senior']
df['age_group'] = pd.qcut(df['age'], q=4,labels = labels)


# In[19]:


df[['age','age_group']].head(10)


# In[20]:


df[['discount_applied','promo_code']].head(10)


# In[22]:


(df['discount_applied'] == df['promo_code']).all()


# In[24]:


df = df.drop('promo_code', axis=1)


# In[25]:


df.columns


# In[26]:


pip install sqlalchemy pymysql


# In[27]:


from sqlalchemy import create_engine

engine = create_engine('mysql+pymysql://root:@localhost:3306/Customer_shopping_db')


# In[29]:


# Database create பண்ணுங்க
conn = pymysql.connect(host='localhost', user='root', password='Mythili2006')
cursor = conn.cursor()
cursor.execute("CREATE DATABASE IF NOT EXISTS customer_shopping_db")
conn.close()
print("Database created!")


# In[ ]:




