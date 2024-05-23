create database	PIZZAhut;

create table orders(
order_id int not null primary key,
order_date date not null,
order_time time not null);


create table order_details(
order_id int not null ,
order_details_id int not null primary key,
pizza_id text not null,
quantity int not null);


-- Basic:
-- Q1.Retrieve the total number of orders placed
select count(distinct order_id) as total_orders from orders;

-- Q2.Calculate the total revenue generated from pizza sales.
select round(sum(a.quantity*p.price),2) as total_revenue
from order_details as a
join pizzas as p on a.pizza_id=p.pizza_id;

-- Q3.Identify the highest-priced pizza.
select pt.name,p.price
from pizzas as p
join  pizza_types as pt 
on p.pizza_type_id=pt.pizza_type_id
order by p.price desc
limit 1;

-- Q4.Identify the most common pizza size ordered.

select p.size,count(a.order_details_id) as order_count
from order_details as a
join pizzas as p on a.pizza_id=p.pizza_id
group by p.size
order by order_count desc
limit 1;

-- Q5.List the top 5 most ordered pizza types along with their quantities.
use pizzahut;
select pt.name,sum(a.quantity)
from pizzas as p
join order_details as a
on a.pizza_id=p.pizza_id
join pizza_types as pt
on p.pizza_type_id=pt.pizza_type_id
group by pt.name
order by count(a.quantity) desc
limit 5;


