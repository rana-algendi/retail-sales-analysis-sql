-- ============================================================
-- Retail Sales Analysis (Online Retail dataset)
-- Tool: MySQL Workbench (MySQL 8.0)
-- Author: Rana Algendi
-- ============================================================

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

-- ------------------------------------------------------------
-- 0. SETUP
-- ------------------------------------------------------------

-- Raw table (same columns as the Online Retail file).
-- InvoiceDate is stored as text first so the import does not fail on the date format.
CREATE TABLE online_retail (
    InvoiceNo   VARCHAR(50),
    StockCode   VARCHAR(50),
    Description TEXT,
    Quantity    INT,
    InvoiceDate VARCHAR(50),
    UnitPrice   DECIMAL(10, 2),
    CustomerID  VARCHAR(50),
    Country     VARCHAR(100)
);

-- After importing the CSV with Table Data Import Wizard, check the row count.
-- Expected: 541,909 rows and 25,900 invoices.
SELECT COUNT(*) AS total_rows,
       COUNT(DISTINCT InvoiceNo) AS total_invoices
FROM online_retail;

-- Cleaned view (the raw table is left untouched):
--  * InvoiceDate converted from text to a real datetime
--  * Revenue = Quantity x UnitPrice
--  * cancelled invoices (InvoiceNo starting with C) removed
--  * rows with zero or negative Quantity or UnitPrice removed
--  * empty CustomerID turned into NULL
CREATE OR REPLACE VIEW clean_retail AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i') AS InvoiceDate,
    UnitPrice,
    NULLIF(CustomerID, '') AS CustomerID,
    Country,
    Quantity * UnitPrice AS Revenue
FROM online_retail
WHERE InvoiceNo NOT LIKE 'C%'
  AND Quantity > 0
  AND UnitPrice > 0;

-- ------------------------------------------------------------
-- Q1. Best products (by revenue)
-- Non-product codes (postage, discounts, manual adjustments, etc.) are excluded.
-- ------------------------------------------------------------
SELECT description,
       SUM(revenue)  AS total_revenue,
       SUM(quantity) AS total_quantity
FROM clean_retail
WHERE StockCode NOT IN ('POST', 'DOT', 'M', 'D', 'CRUK', 'BANK CHARGES')
GROUP BY description
ORDER BY total_revenue DESC
LIMIT 5;

-- ------------------------------------------------------------
-- Q2. Best months
-- ------------------------------------------------------------
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS month,
       SUM(revenue) AS total_revenue,
       COUNT(DISTINCT InvoiceNo) AS orders
FROM clean_retail
WHERE StockCode NOT IN ('POST', 'DOT', 'M', 'D', 'CRUK', 'BANK CHARGES')
GROUP BY month
ORDER BY total_revenue DESC;

-- ------------------------------------------------------------
-- Q3. Top regions (countries)
-- ------------------------------------------------------------
SELECT country,
       SUM(revenue) AS total_revenue,
       COUNT(DISTINCT InvoiceNo) AS orders
FROM clean_retail
GROUP BY country
ORDER BY total_revenue DESC;

-- ------------------------------------------------------------
-- Q4. Average order value
-- One invoice = one order, so distinct invoice numbers are counted.
-- ------------------------------------------------------------
SELECT COUNT(DISTINCT InvoiceNo) AS orders,
       SUM(revenue) AS total_revenue,
       SUM(revenue) / COUNT(DISTINCT InvoiceNo) AS average_order_value
FROM clean_retail;

-- ------------------------------------------------------------
-- Q5. Repeat buyers (customers with more than one order)
-- Rows without a CustomerID are excluded.
-- ------------------------------------------------------------

-- Total customers
SELECT COUNT(DISTINCT CustomerID) AS customer_num
FROM clean_retail;

-- Repeat customers
SELECT COUNT(*) AS repeat_customers
FROM (
    SELECT CustomerID,
           COUNT(DISTINCT InvoiceNo) AS orders
    FROM clean_retail
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
) AS t
WHERE orders > 1;

-- Bonus: customers with the most orders
SELECT CustomerID,
       COUNT(DISTINCT InvoiceNo) AS orders
FROM clean_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY orders DESC
LIMIT 10;
