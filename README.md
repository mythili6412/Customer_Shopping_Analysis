# Customer Shopping Behavior Analysis

End-to-end data analysis project exploring customer shopping patterns using **Python, MySQL, and Power BI** — from raw data cleaning to an interactive business dashboard.

## 📌 Project Overview

This project analyzes a retail customer dataset (1,000 customers) to uncover purchasing behavior, customer segmentation, and revenue patterns. The goal was to simulate a real-world analytics workflow: clean data in Python, store and query it in a relational database, then visualize insights in an interactive dashboard for business stakeholders.

## 🛠️ Tools & Tech Stack

| Stage | Tool |
|---|---|
| Data Cleaning & Wrangling | Python (Pandas, Jupyter Notebook) |
| Database & Querying | MySQL, SQL |
| Visualization & Dashboard | Power BI |

## 🔍 Problem Statements Explored

- What is the revenue contribution of each customer age group?
- Do subscribed customers spend more than non-subscribers?
- Are repeat buyers more likely to subscribe?
- Which products have the highest average review ratings?
- Which products are most frequently purchased with discounts?
- How can customers be segmented into New, Returning, and Loyal tiers based on purchase history?

## 💡 Key Insights

- Female customers contributed the highest total revenue compared to other gender groups.
- Surprisingly, non-repeat buyers showed a higher subscription rate (39.06%) compared to repeat buyers with 5+ previous purchases (30.39%) — suggesting subscription status may be driven more by upfront commitment than by purchase history.
- Customer purchase frequency varied widely, with "Rarely" being the most common purchase frequency category among customers.
- Discount usage and review ratings varied meaningfully across product categories, highlighting opportunities for targeted promotional strategies.

  **Repositary Contents**
  
 ├── README.md                          # Project overview (this file)
├── Customer shopping analysis.ipynb    # Python data cleaning notebook
├── sql_queries.sql                     # All SQL queries used for analysis
├── Customer_shopping_analysis.pbit     # Power BI dashboard screenshot
└── Customer_Shopping_Details.csv      # Raw dataset

## Process

### 1. Data Cleaning (Python/Pandas)
- Loaded raw CSV data into a Pandas DataFrame
- Standardized column names (lowercase, removed spaces)
- Handled missing/inconsistent values in categorical fields
- Created a derived `purchase_frequency_days` feature by mapping purchase frequency categories (e.g., "Weekly" → 7 days)
- Created an `age_group` feature using quantile-based binning (`pd.qcut`)

### 2. Database Design (MySQL)
- Loaded the cleaned DataFrame into a MySQL database using SQLAlchemy
- Wrote SQL queries to answer business questions, including:
  - Aggregations with `GROUP BY`
  - Subqueries (e.g., customers spending above the average purchase amount)
  - Window functions (`RANK() OVER PARTITION BY`) to find top products per category
  - `CASE WHEN` logic for customer segmentation

### 3. Dashboard (Power BI)
- Connected Power BI directly to the MySQL database
- Built DAX measures (Total Customers, Average Purchase Amount, Average Review Rating)
- Designed an interactive dashboard with KPI cards and visual breakdowns by gender, age group, and subscription status


 ### 📈 What I Learned


- End-to-end pipeline experience: moving data from raw CSV → cleaned DataFrame → relational database → BI dashboard
- Writing SQL queries involving subqueries, window functions, and conditional aggregation
- Connecting and modeling data in Power BI using DAX
- Debugging real-world data issues (column name mismatches, authentication errors, type inconsistencies)

