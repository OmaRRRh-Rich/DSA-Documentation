# DSA-Documentation Using SQL
## Project Topic: Kultra Mega Stores Inventory
### Project Introduction / Overview
This project contains a set of SQL scripts designed to practice and demonstrate SQL skills as part of learning Data Structures and Algorithms (DSA) in the context of data analysis and database management. Kultra Mega Stores (KMS), headquartered in Lagos, specialises in office supplies and furniture. Its customer base includes individual consumers, small businesses (retail), and large corporate clients (wholesale) across Lagos, Nigeria. This projects is based on the order data from 2009 to 2012 that needs to be analyzed.  The main file in this repository, **`DSA SQLQuery1 PROJECT.sql`**, includes SQL queries that: - Retrieve, filter, and manipulate data from relational database - Explore SQL concepts like joins, grouping, aggregate functions, subqueries, and data modification - Solve practice problems or use-case scenarios relevant to data analysis. The purpose of this project is both educational and practical: it helps learners solidify SQL knowledge through hands-on examples, it can serve as a template or starting point for future projects involving SQL queries for data retrieval and reporting. Whether you are: A student learning SQL fundamentals, A developer looking for query examples,Or a data professional revising SQL techniques,you’ll find this repository helpful.

### Data Sources
The primary source of data used is the KMS Sql Case Study.csv, it can be freely downloaded as it is an open source data, it can be downloaded freely by open source online such as google data search, Kaggle etc.

### Tools Used
 - SQL Server [Download Here](https://learn.microsoft.com/en-us/ssms/install/install)
   - Data Cleaning
   - Quering and Analysis

### Data Loading and Preparation
In the initial phase we perform the following action:
1. Data Importing/Loading, Renaming and Inspection
2. handling missing variables
3. Changing datatype and Formatting

### Exploratory Data Analysis




### Data Analysis
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

### Visualisation
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
### Visualization
![image](https://github.com/user-attachments/assets/5ea04730-672e-4cab-ae80-7d04e3514b52)

3.	What were the total sales of appliances in Ontario?
``` SQL
select sum(sales) as
appliancesalesinontario
from KMS_Sql_Case_Study
where province = 'ontario'
and product_sub_category = 'Appliances';

```
### Visualization
![image](https://github.com/user-attachments/assets/44f32bbe-888a-44e0-9461-f6799b4d1490)

4.	Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers 
``` SQL
select top 10 Customer_Name, sum(sales)
as totalsales
from KMS_Sql_Case_Study
group by Customer_Name
order by Totalsales asc

```
### Visualization





































