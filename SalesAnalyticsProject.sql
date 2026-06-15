CREATE DATABASE OURFIRSTPROJECT;
USE OURFIRSTPROJECT;
-- 1Q SELECT TOP MOST 5 Selling products by quantity
-- Select  distinct quantiy from sales order by quantiy desc limit 5;
Select product_name,Sum(quantity) As totalquantitysold 
from sales
Where status = 'delivered'
 group by product_name order by totalquantitysold desc limit 5;
 -- 2Q Which products are most frequently cancelled?
 -- Product name thone justification
 Select product_name, count(*) as totalCancelled from sales
 Where status = 'cancelled'
 Group by product_name
 Order by totalCancelled desc limit 10; 
 
 -- 3Q What times of the day has the highest number of purchases?
SELECT 
   Case 
     when hour(time_of_purchase) between 6 and 11 then 'Morning'
     When hour(time_of_purchase) between 12 and 17 then 'Afternoon'
     when hour(time_of_purchase) between 18 and 23 then 'Evening'
     else 'Night'
     end as time_of_day,
     count(*) as total_orders
     From sales
     Group by time_of_day
     order by total_orders desc;
     -- Who are the top highest Spending Customers 
     ALTER TABLE sales rename column prce to price;
     SELECT
      customer_id,
      customer_name,
      sum(quantity * price) as total_spedings_by_customers
      FROM
      sales
      Where status = 'delivered'
      Group by customer_id,customer_name
      order by total_spedings_by_customers desc
      Limit 10;
-- 5 Q Which product cateogories generate high revenues?

Select product_category ,sum(price * quantity) as Revenue from sales 
Where status = 'delivered'
group by product_category 
 order by Revenue desc
 limit 1;
 -- 6Q What is the return/cancellation rate per product_category
 SELECT
   product_category,
   Count(*) as TOTALORDERS,
   SUM(status = 'returned') as returned_orders,
   SUM(status = 'cancelled') as cancelled_orders,
   round(SUM(status = 'returned')/count(*) * 100,2) as returned_rate,
   round(SUM(status = 'cancelled')/count(*) * 100,2) as cancelled_rate
   FROM sales
   Group by product_category;
   
   -- Q7 What is the preffered payment method
   SELECT 
     payment_mode,
     count(*) as total_count
     from sales
     Group by payment_mode
     order by  total_count desc
	;
   -- 8Q  How does age group effect purchasing behavior
   
SELECT 
    CASE 
        WHEN customer_age BETWEEN 16 AND 25 THEN '16-25'
        WHEN customer_age BETWEEN 26 AND 35 THEN '26-35'
        WHEN customer_age BETWEEN 36 AND 55 THEN '36-55'
        ELSE '55+'
    END AS age_group,
    
    SUM(price * quantity) AS total_purchase_by_age_group

FROM sales

GROUP BY 
    CASE 
        WHEN customer_age BETWEEN 16 AND 25 THEN '16-25'
        WHEN customer_age BETWEEN 26 AND 35 THEN '26-35'
        WHEN customer_age BETWEEN 36 AND 55 THEN '36-55'
        ELSE '55+'
    END

ORDER BY total_purchase_by_age_group DESC;
-- 9Q  What are monthly sales Trend
Select 
  date_format( purchase_date, '%Y-%M') as Monthly_purchase,
  sum(quantity*price) as total_sales,
  sum(quantity)
from sales
group by monthly_purchase
order by monthly_purchase;

-- 10 Are certain genders buying more Specific product categories?
SELECT
gender ,product_category,
count(product_category) as total_purchase
from sales
group by gender, product_category
order by total_purchase desc;
 
    
      