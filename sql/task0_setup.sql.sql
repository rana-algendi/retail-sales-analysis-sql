-- 1. إنشاء قاعدة البيانات لو مش موجودة
CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;
-- 2. حذف الجدول لو موجود قديماً عشان نبدأ من جديد بنظافة
-- DROP TABLE IF EXISTS online_retail;
-- 3. إنشاء الجدول بالهيكل المطابق تماماً لملف الـ Online Retail
CREATE TABLE online_retail (
    InvoiceNo VARCHAR(50),
    StockCode VARCHAR(50),
    Description TEXT,
    Quantity INT,
    InvoiceDate VARCHAR(50),
    UnitPrice DECIMAL(10, 2),
    CustomerID VARCHAR(50),
    Country VARCHAR(100)
);

SELECT * FROM online_retail clean_retailclean_retailclean_retailonline_retailonline_retail
;


SELECT COUNT(*) AS total_rows FROM online_retail;

SELECT COUNT(*) AS rows_without_customer
FROM online_retail
WHERE CustomerID = '' OR CustomerID IS NULL;


SELECT * 
FROM online_retail 
WHERE InvoiceNo LIKE 'C%' LIMIT 5;


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
  
 
  
  ;
  SELECT COUNT(*) AS total_rows, COUNT(DISTINCT InvoiceNo) AS total_invoices
  FROM online_retail;
  