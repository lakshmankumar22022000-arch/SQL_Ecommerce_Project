-- 1.Create a Database named "ecommerce_sales_data"
CREATE DATABASE ecommerce_sales_data;
DROP DATABASE ecommerce_sales_data;
SHOW DATABASES;
USE ecommerce_sales_data;
SHOW TABLES;
DROP TABLE Sales_Dataset;

-- 2. Create a table inside the database named "ecommerce_sales_data"
CREATE TABLE Sales_Dataset (
    order_id VARCHAR(15) NOT NULL,
    order_date DATE NOT NULL,
    ship_date DATE NOT NULL,
    ship_mode VARCHAR(14) NOT NULL,
    customer_name VARCHAR(22) NOT NULL,
    segment VARCHAR(11) NOT NULL,
    state VARCHAR(36) NOT NULL,
    country VARCHAR(32) NOT NULL,
    market VARCHAR(6) NOT NULL,
    region VARCHAR(14) NOT NULL,
    product_id VARCHAR(16) NOT NULL,
    category VARCHAR(15) NOT NULL,
    sub_category VARCHAR(11) NOT NULL,
    product_name VARCHAR(127) NOT NULL,
    sales DECIMAL(38, 0) NOT NULL,
    quantity DECIMAL(38, 0) NOT NULL,
    discount DECIMAL(38, 3) NOT NULL,
    profit DECIMAL(38, 5) NOT NULL,
    shipping_cost DECIMAL(38, 2) NOT NULL,
    order_priority VARCHAR(8) NOT NULL,
    year DECIMAL(38, 0) NOT NULL
);

-- 3.Load the data available in Sales_Dataset.csv file to the Sales_Dataset table
-- Famous error : MySQL is running at secure-file-private error if we paste like this 'C:/Users/R.LAKSHMAN KUMAR/OneDrive/Desktop/Project Portfolio/Sales_Data.csv'
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales_Dataset.csv' -- Windows C/Program Data/MySQL/MySQL 8.0/Uploads
INTO TABLE Sales_Dataset
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'secure_file_priv';
SELECT * FROM Sales_Dataset;

-- Identify the Top 3 states with the highest shipping cost
-- stats VS highest_sum_shipping_cost
SELECT state, SUM(shipping_cost) AS sum_shipping_cost
FROM Sales_Dataset
GROUP BY state
ORDER BY sum_shipping_cost DESC
LIMIT 3;

-- Common Table Expressions - Complexity of any given query + Reusuability of the query
WITH states as(
	SELECT state, SUM(shipping_cost) AS sum_shipping_cost
	FROM Sales_Dataset
	GROUP BY state
	ORDER BY sum_shipping_cost DESC
	LIMIT 3
)SELECT * FROM states;

-- Usually, Whenever you feel a lot of subqueries or joins are there in your SQL Queries , Go for CTE

-- Total Sales and Profit by category and sub_category
SELECT category, sub_category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM Sales_Dataset
GROUP BY category, sub_category
ORDER BY total_sales DESC;

-- Monthly sales trend for a given year
SELECT MONTH(order_date) AS month, SUM(sales) AS monthly_sales
FROM Sales_Dataset
WHERE year = 2011
GROUP BY month
ORDER BY month;

-- Customers with highest total sales
SELECT customer_name, SUM(sales) AS total_sales
FROM Sales_Dataset
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 5;

-- Profit margin calculation and sorting
SELECT product_name, sales, profit, (profit / sales) * 100 AS profit_margin_percentage
FROM Sales_Dataset
WHERE sales > 0
ORDER BY profit_margin_percentage DESC
LIMIT 10;

-- Average discount offered by category
SELECT category, AVG(discount) AS avg_discount
FROM Sales_Dataset
GROUP BY category
ORDER BY avg_discount DESC;

-- Number of orders and average shipping cost by region
SELECT region, COUNT(order_id) AS order_count, AVG(shipping_cost) AS avg_shipping_cost
FROM Sales_Dataset
GROUP BY region
ORDER BY order_count DESC;

-- Orders with discount greater than 20%
SELECT order_id, customer_name, discount, sales
FROM Sales_Dataset
WHERE discount > 0.2
ORDER BY discount DESC;

-- Sales distribution by ship_mode
SELECT ship_mode, SUM(sales) AS total_sales
FROM Sales_Dataset
GROUP BY ship_mode
ORDER BY total_sales DESC;

-- Yearly sales growth rate (comparing 2023 and 2024 assuming data for both years)
WITH sales_by_year AS (
SELECT year, SUM(sales) AS total_sales
FROM Sales_Dataset
GROUP BY year
)
SELECT s1.year, s1.total_sales,
(s1.total_sales - COALESCE(s2.total_sales, 0)) / COALESCE(s2.total_sales, 1) * 100 AS sales_growth_percentage
FROM sales_by_year s1
LEFT JOIN sales_by_year s2 ON s1.year = s2.year + 1
ORDER BY s1.year;

-- Ranking products by sales within each category
SELECT category, product_name, sales,
RANK() OVER (
	PARTITION BY category 
	ORDER BY sales DESC
    ) AS sales_rank
FROM Sales_Dataset;

-- Running total of sales month-wise
SELECT order_date, sales,SUM(sales) 
OVER (ORDER BY order_date 
	  ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	 ) AS running_total_sales
FROM Sales_Dataset
WHERE year = 2011
ORDER BY order_date;

-- Average profit by region computed over each row for comparison
SELECT region, profit,AVG(profit) 
OVER (PARTITION BY region) AS avg_profit_region
FROM Sales_Dataset;

-- Row number for orders within each customer
SELECT customer_name, order_id, order_date,
ROW_NUMBER() OVER (
	PARTITION BY customer_name 
	ORDER BY order_date
    ) AS order_sequence
FROM Sales_Dataset;

-- Percent rank of discounts offered across all orders
SELECT order_id, discount,
    PERCENT_RANK() OVER (
        ORDER BY discount
    ) AS discount_percent_rank
FROM Sales_Dataset;