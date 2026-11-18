SELECT    country ,sum(revenue) as total_revenue ,       COUNT(DISTINCT InvoiceNo) AS orders
FROM clean_retail
group by country
order by total_revenue desc

;


-- أعلى دولة مبيعاً هي United Kingdom (£9.03M)، تليها Netherlands (£285K) وEIRE (£283K). هولندا جابت مبيعاتها من 94 أوردر بس، يعني أوردرات كبيرة القيمة.