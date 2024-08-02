-- Total Revenue generated on 14th Feb
 select sum(revenue) as total_revenue from sales

--find the products with the highest average revenue per sale
select product_name,avg_revenue from(
select product_name, round(avg(revenue),0) as avg_revenue,rank() over(order by avg(revenue) desc) as rank1 from products
join sales on products.product_id=sales.product_id
GROUP by 1) b 
where rank1=1

--Find the Product with the Highest Total_Revenue
select product_name,sum(revenue) as total_revenue from products
join sales on products.product_id=sales.product_id
GROUP by product_name
order by total_revenue DESC
LIMIT 1

-- Find Country wise revenue and sales
select country_name, sum(revenue) as total_revenue,quantity_sold from countries
join sales on countries.country_id=sales.country_id
group by country_name,3
order by total_revenue DESC,country_name asc

--Rank the brand based on the total no. of chocolates sold
select brand,sum(quantity_sold) as total_qty,
rank() over(order by sum(quantity_sold) desc) as rank1 from products
join sales on products.product_id=sales.product_id
group by 1

--country wise most sold chocolate and their brand name
SELECT country_name,product_name,brand,sum(quantity_sold) as total_qty from sales
join products on sales.product_id=products.product_id
join countries on countries.country_id=sales.country_id
GROUP by 1,2,3
order by 4 desc,country_name asc



