 SELECT description, sum(revenue) total_revenue ,sum(quantity) as total_quantity
 FROM clean_retail 
 WHERE StockCode NOT IN ('POST', 'DOT', 'M', 'D', 'CRUK', 'BANK CHARGES')
 group by description  
 order by total_revenue desc
 limit 5;
  
  
SELECT InvoiceNo, InvoiceDate, Quantity, UnitPrice
FROM online_retail
WHERE Description = 'PAPER CRAFT , LITTLE BIRDIE';

-- أأعلى منتج مبيعاً هو REGENCY CAKESTAND 3 TIER بإجمالي £174,485 (13,879 وحدة)،
-- أعلى منتج في الكمية PAPER CRAFT, LITTLE BIRDIE، لكن رقمه متأثر بطلب كبير واحد اتلغى.