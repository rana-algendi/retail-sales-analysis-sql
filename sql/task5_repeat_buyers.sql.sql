 select count( distinct customerid) as customer_num ,count( distinct invoiceno) as invoiceno_count
 from clean_retail 
 ;
 
 select COUNT(*) AS repeat_customers 
 from(
 select customerid ,count( distinct invoiceno) as orders 
 from clean_retail 
  WHERE CustomerID = '' OR CustomerID IS not NULL
 group by customerid
 order by orders desc)as t
 where orders > 1;
 
 
 
-- 65.6% من العملاء (2,845 من 4,338) اشتروا أكتر من مرة خلال فترة الداتا. العملاء من غير Customer ID مستبعدين من الحساب ده.