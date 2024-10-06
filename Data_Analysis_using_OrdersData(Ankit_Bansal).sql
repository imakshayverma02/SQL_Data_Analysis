select * from Orders_data

select * from returns_data

select order_id,order_date,sales
from Orders_data

select top 20 * 
from Orders_data

select top 20 order_id,order_date,sales
from Orders_data

select *
from orders_data
order by order_date

select *
from orders_data
order by order_date,profit

select *
from orders_data
order by order_date,profit desc

select top 5 *
from orders_data 
order by profit desc

select top 10 *, profit/sales as Profit_ratio
from orders_data 
Order by Profit_ratio

Select top 10 * 
from orders_data
where region = 'Central' AND quantity >= 3
Order by Sales Desc

select * 
from orders_data
where order_date>'2020-09-17'
order by order_date

select *  from orders_data
where city =  'Los Angeles' and category like 'Office Supplies' 
Order by sales asc

select *  from orders_data
where city =  'Los Angeles' and category like 'Office Supplies' and quantity >2
Order by sales asc

select *  from orders_data
where (city = 'Los Angeles' or category = 'Technology') and quantity > 5

select top 10 *
from Orders_data
where quantity between 3 and 6
order by quantity desc


-- pattern matching 

select *
from orders_data
where customer_name like 'A%'  -- here % is a wildcard character & name is starting with A

select *
from orders_data
where customer_name like '%n' -- here name is ending with n 

select *
from orders_data
where customer_name like '%n%' --here name has n in between

select *
from orders_data
where customer_name like '_a%' -- underscore means it has only one character 

select *
from orders_data
where customer_name like '_[ae]%n' --second character should be either a or e 
order by Order_date desc


--- Aggregate the Data [Count(),Sum(),Avg(),Min(),Max()]


select * from orders_data where quantity > 4
order by quantity
select Sum(sales) as Total_Sales
from orders_data 

select avg(sales) as Avg_Sales
from orders_data 


select category, Sum(sales) as Category_sales
from orders_data
group by category

select category,region , Sum(sales) as Category_sales, Sum(Profit) as Category_profit
from orders_data
group by category,region

select category,region , Sum(sales) as Category_sales, Sum(Profit) as Category_profit
from orders_data
group by category,region
Having Sum(sales)>1000

select city, Sum(sales) as Category_sales, Sum(Profit) as Category_profit
from orders_data
where region = 'West'
group by city
Having Sum(sales)>1000


select city, Sum(sales) as Category_sales, Sum(Profit) as Category_profit
from orders_data
where region = 'West'
group by city
Having Sum(sales)>1000
Order by Category_sales


--- If we want to do the analysis on more than one table we have to perform joins to fetch details from the two or more tables

select *
from orders_data
inner join returns_data on orders_data.order_id = returns_data.order_id

select category, SUM(sales) as Category_sales
from orders_data
inner join returns_data on orders_data.order_id = returns_data.order_id
group by category

select category, SUM(sales) as Category_sales
from orders_data
inner join returns_data on orders_data.order_id = returns_data.order_id
group by category
Order by Category_sales desc

select *
from orders_data
inner join returns_data on orders_data.order_id = returns_data.order_id
where return_reason like 'Bad%'

--- left joins are more powerful in terms of data analysis as it gives a more detailed overview of data between two or more tables 

select * 
from orders_data o 
left join returns_data r on o.order_id = r.order_id  --- this will give returns id data 
where r.return_reason is not Null

select * 
from orders_data o 
left join returns_data r on o.order_id = r.order_id  --- this will give results of orders which doesnot have any return scenarios
where r.return_reason is NULL


select r.return_reason, SUM(o.sales) as return_sales
from orders_data o
left join returns_data r on o.order_id = r.order_id
Group by r.return_reason

-- Here we have found that the return_reason contains some value that are entered wrong by mistake

-- for that we have a special function CASE When where we can use it as if else statement in SQL
select *
,case when return_reason ='Wrong Item' then 'Wrong Items' else return_reason end as new_return_reason
From returns_data


select *
, Case when profit<0 then 'Loss'
when profit between 0 and 49 then 'Low pofit'
when profit between 50 and 99 then 'high Profit'
else 'very high profit'
end as Profit_Bucket
from orders_data

-- Date & String Functions

select order_id, order_date,DATENAME (MONTH, order_date) AS order_month_name
from orders_data


select order_id, order_date, ship_date
,DATEDIFF(DAY, order_date, ship_date) as lead_days
from orders_data

select order_id, order_date, ship_date
,DATEDIFF(MONTH, order_date, ship_date) as lead_days 
from orders_data

 select order_id, order_date, ship_date
 ,DATEDIFF(MONTH, order_date, ship_date) as lead_days  -- basically it will add 5 days to the order_date,for getting back use -5 for 5 days before
 ,DateAdd(DAY,5,order_date) as order_5
 from orders_data