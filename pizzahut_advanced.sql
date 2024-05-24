use pizzahut;

-- Advanced:
-- Q1.Calculate the percentage contribution of each pizza type to total revenue.

select pizza_types.category,
round((sum(order_details.quantity*pizzas.price) /
(SELECT sum(order_details.quantity*pizzas.price) as total_Sales from
order_details
join pizzas on order_details.pizza_id=pizzas.pizza_id))*100 ,2)as revenue
from pizza_types
join pizzas
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.category
order by revenue desc;

-- Q2.Analyze the cumulative revenue generated over time.
select order_date,
round(sum(revenue) over(order by order_date),2) as cum_revenue
from
(select orders.order_Date,
sum(order_details.quantity*pizzas.price) as revenue
from pizzas
join order_details on pizzas.pizza_id=order_details.pizza_id
join orders on orders.order_id=order_details.order_id
group by orders.order_Date
)as sales;

-- Using common table expression
With cum as
(select orders.order_Date,
sum(order_details.quantity*pizzas.price) as revenue
from pizzas
join order_details on pizzas.pizza_id=order_details.pizza_id
join orders on orders.order_id=order_details.order_id
group by orders.order_Date) 

select cum.order_date,
round(sum(cum.revenue) over(order by cum.order_date),2) as cum_revenue
from cum
group by cum.order_date;


-- Q3.Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT name , category ,revenue FROM (
SELECT 
    category, name, revenue, RANK() OVER(PARTITION BY category ORDER BY revenue DESC) AS rank_revenue
FROM
    (SELECT 
        pizza_types.category,
            pizza_types.name,
            SUM(pizzas.price * order_details.quantity) AS revenue
    FROM
        pizza_types
    JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
    JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
    GROUP BY pizza_types.category , pizza_types.name) AS a ) AS b 
    WHERE rank_revenue <= 3;
