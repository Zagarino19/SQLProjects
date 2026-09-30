# E-Commerce Sales Analysis SQL Project

Project Title: E-Commerce Sales Analysis
Level: Beginner  
Database: `ecommerce`
Tools: MySQL Workbench
Dataset: https://www.kaggle.com/datasets/carrie1/ecommerce-data
Project Introduction
This project was designed to analyze E-commerce Sales analyst using SQL to practice data analysis skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involved setting up an E-commerce database, performing exploration data analysis (EDA), and answering specific business questions through SQL queries.

## Objectives

1. Set up a retail sales database: Create and generate the e-commerce sales database with the sales data provided.
2. Data Cleaning: Identify and remove any records with missing or null values.
3. Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.
## Project Structure

### 1. Database Setup

Database Creation: The project started by creating a database named `ecommerce’
Table Creation: A table called 'sales_data' was created to store sales data. The table structure includes the following columns: InvoiceNo, StockCode, Description, Quantity, Invoice Date, Unit Price and CustomerID.

**SQL
CREATE DATABASE IF NOT EXISTS ecommerce;

USE ecommerce;
DROP TABLE IF EXISTS sales_data;
use ecommerce;
CREATE TABLE sales_data (
 InvoiceNo   VARCHAR(20),
StockCode   VARCHAR(20),
 Description VARCHAR(200),
 Quantity    INT,
InvoiceDate  datetime,
UnitPrice   FLOAT,
CustomerID  INT,
 Country     VARCHAR(100)
);

-------------------------------
### 2. Data Exploration & Cleaning
 **Null Value Check: Check for any null values in the dataset and delete records with missing data.

DELETE FROM sales_data
WHERE
    InvoiceNo IS NULL
    OR stockCode   IS NULL
    OR  Description IS NULL
    OR Quantity  IS NULL
    OR InvoiceDate IS NULL
    OR UnitPrice IS NULL
    OR CustomerID IS NULL
    OR Country  IS NULL;
-----------------------

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

-- 1. Analyze how monthly order volume changes over time (Dec 2010–Dec 2011). 
-- Count distinct orders, excluding credit notes. (Credit notes can be identified by InvoiceNo Starting with C);

Select year(InvoiceDate) As year,
       month(InvoiceDate) AS month,
       
     count(Distinct(InvoiceNo)) as no_Of_orders
     
       from sales_data

where InvoiceNo not like 'C%'
group by year(InvoiceDate),  month(InvoiceDate)
order by year, month;
-----------------------

-- 2 Compute & return net revenue per month/year (UnitPrice × Quantity)
Select year(InvoiceDate) As year,
       month (InvoiceDate) AS month,
       round(sum (quantity * UnitPrice),2) AS Netrevenue
     from sales_data
where InvoiceNo not like 'C%'
group by year(InvoiceDate),  month(InvoiceDate)
order by year, month;
--------------------------------------








-- 3 Identify the 5 products with highest total quantity sold. Exclude credit notes; ignore blank descriptions. 
-- Group by SKU(stockCode) + Description. (Credit notes can be identified by InvoiceNo Starting with C)

select   StockCode,
		 Description,
       
     sum(Quantity) as total_quantity
     
       from sales_data

where InvoiceNo not like 'C%'
and description is not null
and TRIM(description) <> ' '
group by StockCode,  Description
order by Total_quantity, Description
limit 5;

-- 4 Find the top 5 countries by net revenue. Ignore blank/missing country values
select country,
       round(sum(Quantity * unitprice),2) as net_revenue 
       from  sales_data
       where country is not null and trim(country) <> ' '
       group by country
       order by net_revenue desc , country asc;

-- 5 Identify the 5 customers with highest net spend. Ignore missing/blank CustomerID.
Select
    CustomerID,
    Round(Sum(Quantity * UnitPrice), 2) AS Total_Amount_Spent
From
    sales_data
Where
    CustomerID IS NOT NULL
        And Trim(CustomerID) <> ' '
Group by CustomerID
Order by Total_amount_spent DESC , CustomerID ASC
Limit  5;


## Findings
This project helped to analyze the sales performance of the e-commerce  for the year 2010 as it provided an in-depth customer insight in terms of revenue trends,  top products and best-performing country.

As a recommendation the business should focus on the best performing products, countries, and customers to create an adequate marketing and customer satisfaction strategy to maximize revenue generation and customer satisfaction.





## Conclusion

This project served  as a comprehensive introduction to SQL for my data analysis learning journey,  it covered  database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding the performance of the business in terms of revenue generated, Best performing products and top customers spenders

Skills gained from this project were:
 Aggregations, GROUP BY, Filtering, Revenue calculations, DATE functions





