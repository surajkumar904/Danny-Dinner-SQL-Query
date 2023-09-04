create database Danny_Dinner;
use Danny_Dinner;

CREATE TABLE sales(
	customer_id VARCHAR(10),
    order_date DATE,
    product_id int
);
INSERT INTO sales
	(customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
  
SELECT * FROM SALES;

CREATE TABLE menu(
	product_id INT,
    product_name VARCHAR(10),
    price int
);

INSERT INTO menu
  (product_id, product_name, price)
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');

SELECT * FROM MENU; 
 
CREATE TABLE members(
	customer_id VARCHAR(5),
    join_date DATE
);

INSERT INTO members
  (customer_id, join_date)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  
  SELECT * FROM MEMBERS;
   
 ----  Case Study Questions -----
1. What is the total amount each customer spent at the restaurant?
SELECT a.customer_id, sum(b.price) as totalspent
FROM sales a
JOIN menu b ON a.product_id = b.product_id
group by a.customer_id;

2. How many days has each customer visited the restaurant?
	select customer_id, count(distinct order_date) as numberofdays
    from sales
    group by customer_id;
    
3. What was the first item from the menu purchased by each customer?
	select *, 
    rank() over (partition by customer_id order by order_date) as ranking
    from sales;

4. What is the most purchased item on the menu and how many times was it purchased by all customers?
	with final as (
    select a.*, b.product_name,
    rank() over (partition by customer_id order by order_date) as ranking
    from sales a
    join menu b
    on a.product_id = b.product_id)
    select * from final where ranking= 1;
    
5. Which item was the most popular for each customer?
	with final as (
	select a.customer_id,b.product_name,count(*) as total
	from sales a
	join menu b
	on a.product_id=b.product_id
	group by a.customer_id,b.product_name)
 
	select customer_id,product_name,total,
	rank() over (partition by customer_id order by total desc) as ranking
	from final