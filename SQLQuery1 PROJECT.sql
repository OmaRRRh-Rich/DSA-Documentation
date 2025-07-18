select top 1
product_category,
sum(sales) as totalsales
from
KMS_Sql_Case_Study
group by
product_category
order by
totalsales desc

select top 3 Region, sum(sales) as
totalsales
from KMS_Sql_Case_Study
group by Region
order by totalsales desc

select top 3 Region, sum(sales) as
totalsales
from KMS_Sql_Case_Study
group by Region
order by totalsales asc

select sum(sales) as
appliancesalesinontario
from KMS_Sql_Case_Study
where province = 'ontario'
and product_sub_category = 'Appliances';

select top 10 Customer_Name, sum(sales)
as totalsales
from KMS_Sql_Case_Study
group by Customer_Name
order by Totalsales asc

select ship_mode, sum(shipping_cost) as Totalshippingcost
from KMS_Sql_Case_Study
group by ship_mode
order by Totalshippingcost asc


with customer_sales as (
select
      Customer_Name,
      Product_category,
      sum(sales) as totalsales
from [dbo].[KMS_Sql_Case_Study]
group by Customer_Name,
Product_Category
),
Rankedsales as (
select *,
         rank() over (partition by 
customer_name order by totalsales
desc) as rank
     from customer_sales
),
customertotals as (
     select customer_name,
sum(totalsales) as
total_customer_sales
    from customer_sales
    group by Customer_Name
    )
select top 10
  r.customer_name,
  c.total_customer_sales,
  r.product_category as
top_product_category
from Rankedsales r
join customertotals c on r.Customer_Name=
 c.Customer_Name
 where r.rank=1
 order by c.total_customer_sales
 asc

   SELECT top 1 Customer_Name, sum(sales)
  as totalsales
  from KMS_Sql_Case_Study
  where Customer_Segment = 'small business'
  group by customer_name
  order by totalsales desc

   select top 1 customer_name,
 count(distinct Order_ID) AS Numorders
 from KMS_Sql_Case_Study
 where Customer_Segment = 'corporate'
 group by Customer_Name
 order by Numorders desc

 select top 1 customer_name, sum(profit)
as totalprofit
from KMS_Sql_Case_Study
where Customer_Segment = 'consumer'
group by Customer_Name
order by totalprofit desc

   select distinct
          K.Customer_Name,
          K.Customer_segment
from [dbo].[KMS_Sql_Case_Study] K
join Order_Status O on K.Order_ID =
O.ORDER_ID
WHERE O. Status = 'Returned'


SELECT
     ORDER_PRIORITY,
     Ship_mode,
     count(*) as OrderCount,
     sum(shipping_cost) as
     Totalshippingcost,
     avg(shipping_Cost) as
     avgshippingcost
     from [dbo].[KMS_Sql_Case_Study]
     group by Order_Priority, Ship_Mode
     order by Order_Priority, Ship_Mode

    SELECT
    ROUND(SUM(Sales - Profit), 2) AS EstimatedShippingCost,
    AVG(DATEDIFF(DAY, Order_Date, Ship_Date)) AS AvgShipDays
    FROM
    [dbo].[KMS_Sql_Case_Study]

