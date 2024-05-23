

-- Intermediate:
-- Q1.Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT	pt.category,sum(a.quantity) as total_quantity
from pizzas as p
join pizza_types as pt
on p.pizza_type_id=pt.pizza_type_id
join order_details as a
on a.pizza_id=p.pizza_id
group by pt.category
order by total_quantity desc;

-- Q2.Determine the distribution of orders by hour of the day.
select hour(order_time) as hr ,count(order_id) from orders
group by hr
order by hr;

-- Q3.Join relevant tables to find the category-wise distribution of pizzas.
select category,count(name) from pizza_types
group by category;

-- Q4.Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(total)) as avg_no_of_pizzas_ordered_per_day from
(select a.order_date ,sum(od.quantity)  as total
from orders as a
join order_details as od
on a.order_id=od.order_id
group by a.order_date ) as Total_quanity;

select a.order_date ,sum(od.quantity)  as total
from orders as a
join order_details as od
on a.order_id=od.order_id
group by a.order_date;

-- Q5.Determine the top 3 most ordered pizza types based on revenue.
SELECT	pt.name,round(sum(a.quantity*p.price),2) as revenue
from pizzas as p
join pizza_types as pt
on p.pizza_type_id=pt.pizza_type_id
join order_details as a
on a.pizza_id=p.pizza_id
group by pt.name
order by revenue desc
limit 3;


