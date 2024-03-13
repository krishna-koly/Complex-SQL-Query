
CREATE TABLE orders (
 `customer_id` VARCHAR(1),
 `order_date` DATE,
 `product_id` INTEGER
);
INSERT INTO orders
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
 

CREATE TABLE menu (
 `product_id` INTEGER,
 `product_name` VARCHAR(5),
 `price` INTEGER
);
INSERT INTO menu
VALUES
 ('1', 'sushi', '10'),
 ('2', 'curry', '15'),
 ('3', 'ramen', '12');
 

CREATE TABLE members (
 `customer_id` VARCHAR(1),
 `join_date` DATE
);
INSERT INTO members
VALUES
 ('A', '2021-01-07'),
 ('B', '2021-01-09');
 
 
 
 
 #Question: What are the total items and amount spent for each member before they became a member?
 
 -- ASSUMPTION - A customer can order more than one item just before becoming a member. 
 -- A customer can order a particular ffod item more than once. Consider all the records as an individual.
 
 
 select * from orders;
 select * from menu;
 select * from members;
 
 select o.customer_id,count(o.product_id) as total_item,sum(mu.price) as total_price
 from orders o
 join menu mu using(product_id)
 join members m on o.customer_id = m.customer_id
 where join_date>order_date
 group by customer_id
 order by customer_id ASC
 
 
 
 
 
 
 
 
 
 
 
 
 
 