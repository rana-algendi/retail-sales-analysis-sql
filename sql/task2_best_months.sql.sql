SELECT   DATE_FORMAT(InvoiceDate, '%Y-%m') AS month, sum(revenue) as total_revenue , COUNT(DISTINCT InvoiceNo) AS orders 

FROM clean_retail
WHERE StockCode NOT IN ('POST', 'DOT', 'M', 'D', 'CRUK', 'BANK CHARGES')
group by month
order by total_revenue desc
 
; 

-- أعلى 3 شهور مبيعاً: نوفمبر 2011 (£1.46M)، أكتوبر 2011 (£1.11M)، سبتمبر 2011 (£1.03M)
-- نوفمبر هو الأعلى بسبب زيادة عدد الأوردرات (2,751) وليس زيادة قيمة الأوردر.