# E-Commerce Sales Analysis using MySQL

## Project Overview
This project analyzes e-commerce sales data using **MySQL** to generate insights that can help businesses understand their customers, sales trends, profitability, and operational costs.

The dataset contains order-level details such as product, sales, discounts, profit, shipping cost, and customer information.  
The goal is to perform **end-to-end SQL operations**: from database creation and data loading to advanced queries with window functions and CTEs.

---

## Steps Performed

### 1. Database & Table Setup
- Created a new database `ecommerce_sales_data`.
- Designed a table `Sales_Dataset` with appropriate data types for order, customer, product, and sales details.
- Loaded raw sales data from a CSV file into MySQL.

### 2. Exploratory Queries
- Checked total records, distinct customers, categories, and regions.
- Verified successful data load.

### 3. Business Analysis Queries
- **Top 3 States by Shipping Cost** – identified regions where logistics cost is highest.
- **Sales & Profit by Category/Sub-Category** – compared product categories and sub-categories.
- **Monthly Sales Trend** – tracked seasonal sales behavior for a given year.
- **Top Customers by Sales** – identified high-value customers.
- **Profit Margin Analysis** – calculated profit % at product level.
- **Average Discounts by Category** – evaluated pricing/discounting strategy.
- **Orders with >20% Discount** – detected potential loss-making discounts.
- **Sales Distribution by Ship Mode** – analyzed impact of delivery type.
- **Yearly Sales Growth** – measured performance across years.

### 4. Advanced SQL Techniques
- **CTEs (Common Table Expressions)** for query reusability.
- **Window Functions** (`RANK`, `ROW_NUMBER`, `PERCENT_RANK`) to analyze customer orders, discount ranking, and sales ranking.
- **Running Totals** to measure cumulative sales over time.
- **Aggregations with GROUP BY** to summarize data at different levels (region, category, customer).

---

## Key Insights (Sample Findings)
- Certain states drive significantly higher **shipping costs**, which may need logistics optimization.
- **Technology products** generate higher sales, but some categories offer deep discounts, reducing profitability.
- Top **5 customers** contribute a major share of sales.
- Some products achieve **profit margins above 50%**, making them key to business strategy.
- Sales growth trends reveal performance changes year-over-year.

---

## Skills Demonstrated
- SQL Database Design (DDL, DML)
- Data Import/Export in MySQL
- Aggregations & Grouping
- Joins, CTEs, and Subqueries
- Window Functions (Ranking, Running Totals, Percent Rank)
- Business-focused Query Writing
