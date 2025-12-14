-- SQL Retail Sales Analysis - P1

-- Create Table 

create table Retail_Sales (
transactions_id	int primary key,
sale_date date,
sale_time time,
customer_id	int,
gender varchar (15),
age	int,
category varchar (15),	
quantiy	int,
price_per_unit float,
cogs float,
total_sale float
);

select * from retail_sales
where sale_date is null;


select count(*) 
from retail_sales;

select * 
from retail_sales
where
	transactions_id is null
    or
    sale_date is null
    or
    sale_time is null
    or
    customer_id is null
    or
    gender is null
    or
    age is null
    or
    category is null
    or 
    quantiy is null
    or 
    price_per_unit is null
    or 
    cogs is null
    or
    total_sale is null;


SELECT DISTINCT customer_id
FROM retail_sales;
-- data exploration

-- sales number
select count(*) as total_sales from retail_sales;

-- how many unique customers we have?

select count(distinct customer_id) as total_sales from retail_sales;

-- unique category

select distinct category from retail_sales;

-- Data Analysis

-- Q1. All columns sales made on '2022-11-05'

select *
from retail_sales
where sale_date = '2022-11-05';

-- Q2. All transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of November - 2022
 
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity > 3
  AND sale_date >= '2022-11-01'
  AND sale_date <  '2022-12-01';
  
  Alter table retail_sales
  rename column quantiy to quantity;
  
  -- calculate the total sales for each category
  
  select category, 
  sum(total_sale) as net_sale,
  count(*) as total_orders
  from retail_sales
  group by category;
  
  -- find average age of customers who purchased items from the 'Beauty' category
  
  
  Select 
	round(avg(age), 2) as average_age
  from retail_sales
  where category = 'Beauty';
  
  -- find all transactions where total_sale is more than 1000
  
select *
from retail_sales
where total_sale > '1000'
order by total_sale asc;
  
  -- find the total number of transactions made by each gender in each category
  
select 
	category, gender, count(transactions_id) as total_transactions
from retail_sales
group by category, gender;


-- find out average sales for each month and find the best selling month of each year

select 
	year_, 
    month_, 
    average_sale
from 
(
	select 
		year(sale_date) as year_,
		month(sale_date) as month_,
		round(avg(total_sale), 2) as average_sale,
		rank() over(partition by year(sale_date) order by avg(total_sale) desc) as ranking
	from retail_sales
	group by year_, month_
) as t1
where ranking = 1;

-- find the top 5 customers based on the total_sale

select 
	customer_id, 
    sum(total_sale) as total_sales
from retail_sales
group by customer_id 
order by total_sales desc
limit 5;

-- find the number of unique customers who purchase items from each category

select 
	category,
    count(distinct customer_id) as unique_customers
from retail_sales
group by category;

-- create number of orders per shifts, ie, (Morning <12, Afternoon between 12 and 17, Evening >17)


select 
    case
		when extract( hour from sale_time) < 12 then 'morning'
        when extract( hour from sale_time) between 12 and 17 then 'afternoon'
        else 'evening'
	end as shifts,
    count(*) as num_of_sales
from retail_sales
group by shifts
order by shifts asc;

-- End of Project


 
