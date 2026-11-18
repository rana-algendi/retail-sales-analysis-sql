



USE retail_db;


select  COUNT(DISTINCT InvoiceNo) AS orders ,sum( revenue) total_revenue ,(SUM(revenue) / COUNT(DISTINCT InvoiceNo)) AS average_order_value
from clean_retail
 
;

-- متوسط قيمة الأوردر £534.40 (إجمالي مبيعات £10.67M على 19,960 أوردر)، بعد استبعاد الإلغاءات.