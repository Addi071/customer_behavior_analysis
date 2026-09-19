
select * from customer limit 10;

-- Q1 What is the total revenue generaed by male vs. female customers?
select gender, SUM(purchase_amount) as revene
from customer
group by gender;

-- Q2 which customers used a discount but still spent more than the average purchase amount?
select customer_id, purchase_amount, gender
from customer
where discount_applied = 'Yes' AND purchase_amount > 
(select AVG(purchase_amount)as avg_purchase_amount
from customer);

-- Q3 Which are the top 5 products with highest average review rating?
select item_purchased, ROUND(AVG(review_rating::numeric),2) as "Avg Product Rating"
from customer 
group by item_purchased
order by avg(review_rating) desc
limit 5;

-- Q4 Compare the average purchase amounts between standard and express shipping
select shipping_type, ROUND(avg(purchase_amount),2)
from customer
where shipping_type in ('Express','Standard')
group by shipping_type;

-- Q5 Do subscribed customers spend more? compare avg spend and total revenue btwn subscribers
select subscription_status, ROUND(avg(purchase_amount),3) as avg_spend, sum(purchase_amount) as ttl_revenue
from customer
group by subscription_status;

-- Q6 Which 5 prodcts have the highest percentage of purchases with discount applied?
select item_purchased, ROUND(100 * SUM(CASE when discount_applied = 'Yes' THEN 1 else 0 end)/count(*),2) as discount_rate
from customer
group by item_purchased
order by discount_rate desc
limit 5;

-- Q7 Segment customer into new, Returning, and Loyal based on their total no. of previous purchases, and show the count of each segment
with customer_type as(
select customer_id, previous_purchases,
case when previous_purchases = 1 then 'New'
when previous_purchases between 2 and 10 then 'Returning'
else 'Loyal'
end as customer_segment 
from customer
)select customer_segment, count(*) as count_of_segment
from customer_type 
group by customer_segment;

-- Q8 What are the top 3 most purchased products within each category
with item_count as (
select category, item_purchased,
count(customer_id) as total_orders,
row_number() over(partition by category order by count(customer_id)desc) as item_rank
from customer
group by category, item_purchased
)
select item_rank, category, item_purchased, total_orders
from item_count
where item_rank <= 3;

-- Q9 Are customers who are repeat buyers (more than 5 previous purchases) also likely to subscribe?
select subscription_status,
count(customer_id) as repeat_buyers
from customer
where previous_purchses > 5
group by subscription_status;

-- Q10 What is the revenue contribution off each age group?
select age_group,
sum(purchase_amount) as revenue_contribution
from customer
group by age_group;