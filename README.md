# DSA-Documentation Using SQL
## Project Topic: Kultra Mega Stores Inventory Analysis
#### Table of Contents
1.	Introduction / Overview
2.	Data Source
3.	Tools used
4.	Data Loading and Preparation
5.	Exploratory Data Analysis (EDA)
6.	SQL Analysis and Visualizatons 
7.	Business Insights and Recommendations
8.	Conclusions

### Project Introduction / Overview
This project contains a set of SQL scripts designed to practice and demonstrate SQL skills as part of learning Data Structures and Algorithms (DSA) in the context of data analysis and database management. Kultra Mega Stores (KMS), headquartered in Lagos, specialises in office supplies and furniture. Its customer base includes individual consumers, small businesses (retail), and large corporate clients (wholesale) across Lagos, Nigeria. This projects is based on the order data from 2009 to 2012 that needs to be analyzed.  The main file in this repository, **`DSA SQLQuery1 PROJECT.sql`**, includes SQL queries that: - Retrieve, filter, and manipulate data from relational database - Explore SQL concepts like joins, grouping, aggregate functions, subqueries, and data modification - Solve practice problems or use-case scenarios relevant to data analysis. The purpose of this project is both educational and practical: it helps learners solidify SQL knowledge through hands-on examples, it can serve as a template or starting point for future projects involving SQL queries for data retrieval and reporting. Whether you are: A student learning SQL fundamentals, A developer looking for query examples,Or a data professional revising SQL techniques,you’ll find this repository helpful.

### Data Sources
The primary source of data used is the KMS Sql Case Study.csv, it was provided by the incubator hub as our final project
### Tools Used
 - SQL Server [Download Here](https://learn.microsoft.com/en-us/ssms/install/install)
   - Data Cleaning
   - Quering and Analysis

### Data Loading and Preparation
#### Dataset Overview
The KMS dataset covers transaction-level data, including:
•	Order ID
•	Product Category
•	Region
•	Customer Segment
•	Sales
•	Profit
•	Quantity
•	Shipping Cost
•	Order Date
•	Order Priority
•	Returned Items
- Data Quality Issues Identified	Missing or NULL values in:
   - Region
   -	Product category
   -	Customer segment
•	Inconsistent region or category labels
-	e.g. “Ontario” vs “ontario”
•	Potential duplicate transactions
•	Negative profits (possible returns or discounts)
#### Data Preparation Steps
•	Standardized text fields for:
o	Region names
o	Category names
•	Removed rows with NULL critical fields where necessary
•	Created new derived fields:
o	Gross Margin = Profit / Sales
o	Year extracted from Order Date
•	Aggregated data into summary tables for analysis


### Exploratory Data Analysis
Initial analysis provided high-level understanding:
- Sales Trends (2009 – 2012)
  - Overall sales grew steadily across the four years.
  - Spikes observed during end-of-year months (likely tied to business purchases).
- Product Category Performance
   - Top-selling categories:
  1. Office Supplies
  2. Furniture
  3. Technology
  - Variations in profitability among categories despite high sales.
- Regional Performance
   - Some regions consistently outperform others in sales and profit.
   - Certain regions incur higher shipping costs, potentially impacting margins.
- Customer Segments
   - Corporate clients contributed the highest sales volume.
   - Individual consumers showed lower overall revenue but higher transaction counts.



### Data Analysis and Visualization
1.	Which product category had the highest sales? 

```  SQL
select top 1
product_category,
sum(sales) as totalsales
from
KMS_Sql_Case_Study
group by
product_category
order by
totalsales desc

``` 
✅ Result: Office Supplies had the highest total sales, followed by Furniture.
#### Visualisation
![image](https://github.com/user-attachments/assets/9389921e-b725-47cb-9313-e68afbdde961)

2. What are the Top 3 and Bottom 3 regions in terms of sales? 
``` SQL
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

```
✅ Top 3 Regions:
•	Ontario
•	Lagos Mainland
•	Abuja
✅ Bottom 3 Regions:
•	Port Harcourt
•	Kano
•	Ibadan

#### Visualization
![image](https://github.com/user-attachments/assets/5ea04730-672e-4cab-ae80-7d04e3514b52)

3.	What were the total sales of appliances in Ontario?
``` SQL
select sum(sales) as
appliancesalesinontario
from KMS_Sql_Case_Study
where province = 'ontario'
and product_sub_category = 'Appliances';

```
✅ Appliances sales in Ontario totaled  202346.839630127
#### Visualization
![image](https://github.com/user-attachments/assets/44f32bbe-888a-44e0-9461-f6799b4d1490)

4.	Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers 
``` SQL
select top 10 Customer_Name, sum(sales)
as totalsales
from KMS_Sql_Case_Study
group by Customer_Name
order by Totalsales asc

```
✅ Bottom 10 customers showed very low sales and low order frequency, suggesting possible churn.
#### Visualization
![image](https://github.com/user-attachments/assets/5a1a1274-ded9-448e-96c3-45a54d871cab)

5.	KMS incurred the most shipping cost using which shipping method?
``` SQL
select ship_mode, sum(shipping_cost) as Totalshippingcost
from KMS_Sql_Case_Study
group by ship_mode
order by Totalshippingcost asc
```
✅ Express Air incurred the highest shipping cost.
#### Visualization
![image](https://github.com/user-attachments/assets/5b3c01af-2761-473a-a532-e49a5ad0d874)

6.	Who are the most valuable customers, and what products or services do they typically purchase? 
``` SQL

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
```
✅ Top customers are predominantly corporate clients purchasing Office Supplies and Furniture.
#### Visualization
![image](https://github.com/user-attachments/assets/08215ee4-fe00-4eb1-832d-fc8e3c5868c2)

7.	Which small business customer had the highest sales?
``` SQL
  SELECT top 1 Customer_Name, sum(sales)
  as totalsales
  from KMS_Sql_Case_Study
  where Customer_Segment = 'small business'
  group by customer_name
  order by totalsales desc
```
✅ Identified top small business client is Dennis Kane
#### Visualization
![image](https://github.com/user-attachments/assets/26249344-267d-46b2-82c9-5190f782c5c6)

8.	Which Corporate Customer placed the most number of orders in 2009 – 2012? 
``` SQL
 select top 1 customer_name,
 count(distinct Order_ID) AS Numorders
 from KMS_Sql_Case_Study
 where Customer_Segment = 'corporate'
 group by Customer_Name
 order by Numorders desc
```
✅ Specific corporate customer identified as most active is Adam Hart
#### Visualization
![image](https://github.com/user-attachments/assets/93deb3b6-40bd-4c48-9ccb-47d5103be8a0)

9.	Which consumer customer was the most profitable one?
``` SQL
select top 1 customer_name, sum(profit)
as totalprofit
from KMS_Sql_Case_Study
where Customer_Segment = 'consumer'
group by Customer_Name
order by totalprofit desc
```
✅ Identified the consumer customer driving most profit is Emily Phan
#### Visualization
![image](https://github.com/user-attachments/assets/7bdde4c6-0b62-49e4-b5b7-743a64bef462)

10.	Which customer returned items, and what segment do they belong to? 
``` SQL
   select distinct
          K.Customer_Name,
          K.Customer_segment
from [dbo].[KMS_Sql_Case_Study] K
join Order_Status O on K.Order_ID =
O.ORDER_ID
WHERE O. Status = 'Returned'
```
✅ Returns span multiple segments but predominantly occur in the consumer group.
#### Visualization
![image](https://github.com/user-attachments/assets/f02d9935-ba8b-4046-9aac-9e2c315104fb)

11.	If the delivery truck is the most economical but the slowest shipping method and Express Air is the fastest but the most expensive one, do you think the company appropriately spent shipping costs based on the Order Priority? Explain your answer 
``` SQL

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
```
✅ Found that high shipping costs sometimes correspond to low-priority orders — a potential cost inefficiency
#### Visualization
![image](https://github.com/user-attachments/assets/02ae27ba-ca24-41f2-9c0d-5d4aa0f3add8)

### Business Insights and Recommendations
- Sales Strategy
   - Office Supplies lead in sales but Furniture yields higher profit margins. Consider marketing focus to boost Furniture sales further.
   - Appliances have lower volume but higher unit profit. Opportunity for targeted upselling.
- Regional Focus
   - Ontario and Lagos Mainland are star performers.
   - Regions like Port Harcourt and Kano need tailored promotions or operational review.
- Shipping Costs
   -	Express Air incurs the highest shipping costs. Encourage switching to lower-cost options (e.g. Truck) for non-urgent orders.
   -	Review order priority processes to ensure shipping costs match urgency.
- Customer Retention
   - Bottom 10 customers show signs of churn. Propose:
     1. Personalized promotions
     2. Loyalty programs
     3. Direct engagement
- Returns Reduction
   - Consumer segment has highest return rates. Consider:
     1.Improving product quality for high-return items
     2.Transparent return policies
     
### Conclusions
The KMS analysis revealed:
 - Clear revenue drivers in Office Supplies and Furniture.
 - Significant cost challenges tied to shipping.
 - Regional disparities that can be addressed with targeted strategies.
 - Opportunities to improve customer retention and reduce returns.
Through SQL querying, data visualization, and interpretation, actionable insights have been uncovered to support KMS management in data-driven decision-making for sustainable growth.

### Refenceces
SQL Management Studio 21
Inubator hub on youtube















