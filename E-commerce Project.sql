-- SQL E-commerce data--
CREATE DATABASE IF NOT EXISTS ecommerce;

USE ecommerce;



DROP TABLE IF EXISTS sales_data;
use ecommerce;
CREATE TABLE sales_data (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(200),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice FLOAT,
    CustomerID INT,
    Country VARCHAR(100)
);

-- Data Cleaning--
DELETE FROM sales_data 
WHERE
    InvoiceNo IS NULL OR stockCode IS NULL
    OR Description IS NULL
    OR Quantity IS NULL
    OR InvoiceDate IS NULL
    OR UnitPrice IS NULL
    OR CustomerID IS NULL
    OR Country IS NULL;

-- Data Analysis--
-- 1. Analyze how monthly order volume changes over time (Dec 2010–Dec 2011). 
-- Count distinct orders, excluding credit notes. (Credit notes can be identified by InvoiceNo Starting with C);
SELECT 
    YEAR(InvoiceDate) AS year,
    MONTH(InvoiceDate) AS month,
    COUNT(DISTINCT (InvoiceNo)) AS no_Of_orders
FROM
    sales_data
WHERE
    InvoiceNo NOT LIKE 'C%'
GROUP BY YEAR(InvoiceDate) , MONTH(InvoiceDate)
ORDER BY year , month;

-- 2 Compute & return net revenue per month/year (UnitPrice × Quantity)
SELECT 
    YEAR(InvoiceDate) AS year,
    MONTH(InvoiceDate) AS month,
    ROUND(SUM(quantity * UnitPrice), 2) AS Netrevenue
FROM
    sales_data
WHERE
    InvoiceNo NOT LIKE 'C%'
GROUP BY YEAR(InvoiceDate) , MONTH(InvoiceDate)
ORDER BY year , month;

-- 3 Identify the 5 products with highest total quantity sold. Exclude credit notes; ignore blank descriptions. 
-- Group by SKU(stockCode) + Description. (Credit notes can be identified by InvoiceNo Starting with C)
select   
		StockCode,
		 Description,
         
       sum(Quantity) as total_quantity
        from sales_data
        where StockCode is not null 
        and trim(Description) <> ' '
       group by  StockCode,Description
     order by total_quantity desc, StockCode asc
     limit 5 ;
  



-- 4 Find the top 5 countries by net revenue. Ignore blank/missing country values
SELECT 
    country, ROUND(SUM(Quantity * unitprice), 2) AS net_revenue
FROM
    sales_data
WHERE
    country IS NOT NULL
        AND TRIM(country) <> ' '
GROUP BY country
ORDER BY net_revenue DESC , country ASC;
 
       -- 5 Identify the 5 customers with highest net spend. Ignore missing/blank CustomerID.
SELECT 
    CustomerID,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Total_Amount_Spent
FROM
    sales_data
WHERE
    CustomerID IS NOT NULL
        AND TRIM(CustomerID) <> ' '
GROUP BY CustomerID
ORDER BY Total_amount_spent DESC , CustomerID ASC
LIMIT 5
      
