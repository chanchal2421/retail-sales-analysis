use sales;

CREATE TABLE retail_sales(
transactions_id	INT PRIMARY KEY,
sale_date	DATE,
sale_time	TIME,
customer_id	 INT,
gender	VARCHAR(15),
age INT,	
category VARCHAR(15),
quantiy	INT,
price_per_unit FLOAT,	
cogs	FLOAT,
total_sale FLOAT
);

-- DATA CLEANING
select * FROM retail_sales
WHERE
  transactions_id IS NULL
  OR
  sale_date IS NULL
  OR
  sale_time IS NULL
  OR
  customer_id IS NULL
  OR 
  gender IS NULL 
  OR 
  age IS NULL
  OR 
  category IS NULL
  OR 
  quantiy IS NULL
  OR 
  price_per_unit IS NULL
  OR 
  cogs IS NULL
OR 
total_sale IS NULL;

-- DATA EXPLOARTION

-- how many sales we have
select count(*) as total_sales from retail_sales;

-- how many unique customers we have
select count(distinct customer_id) from retail_sales;

-- how many categories we have
select count(distinct category) from retail_sales;

-- DATA ANALYSIS AND SOLVING BUISNESS PROBLEMS

-- write sql queries to retrieve all columns for sales made on "2022-11-05"
select *
from retail_sales
where sale_date="2022-11-05"; 

-- write an sql query to retrieve all transaction where the category is 'clothing' and the quantity sold is more than 3 in the month of nov-2022
select *
from retail_sales
where category='clothing' and quantiy>3 and sale_date between '2022-11-01' and '2022-11-30';

-- wirte a sql query to calculate the total-sales for each category
select category,sum(total_sale) as total_sales,count(*) as total_orders
from retail_sales
group by category;

-- write a sql query to find the average age of customers who purchased items from the 'beauty' category
select category,round(avg(age),2) as average_age
from retail_sales
where category='beauty';

-- write a sql query to find all transactions where the total_sales is greater than 1000
select * 
from retail_sales
where total_sale>1000;

-- write a sql query to find the total number of transactions made by each gender in each category
select category,gender,count(*) as total_transactions
from retail_sales
group by category,gender
order by category;

-- write a sql query to calculate the average sale for each month .find out best selling month of each year 
select year,month,average_sale from 
(
select year(sale_date) as year,month(sale_date) as month,avg(total_sale) as average_sale,
rank() over(partition by year(sale_date) order by avg(total_sale) desc) as Rank_sale
from retail_sales
group by year,month
) as t1
where Rank_sale=1;

-- write a sql query to find the top 5 customers based on the highest total sales
select customer_id,sum(total_sale)as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5;

-- write a sql query  to find the number of unique customers who purchased items from each category
select category,count(distinct customer_id)
from retail_sales
group by category;

-- write sql query to create each shift and a number of orders (example morning=<=12,afternoon between 12 & 17,evening >17)
with hourly_sales
as(
select *,
case
when extract(HOUR from sale_time)<12 then 'morning'
when extract(HOUR from sale_time)between 12 and 17 then 'afternoon'
else 'evening'
end as shift
from retail_sales
)
select shift,count(*) as total_sales from hourly_sales
group by shift
order by total_sales;



SELECT * FROM retail_sales;
