USE sql_store;
SELECT *
FROM orders
WHERE order_date >='2019-01-01';


SELECT *,
       unit_price*quantity AS T_price
 FROM order_items
 WHERE order_id = 6 AND unit_price*quantity>= 30;
 
 -- IN operator use --
 SELECT * FROM products
 WHERE quantity_in_stock IN (49,38,72);


-- Between operator use --

SELECT * FROM customers
WHERE birth_date BETWEEN '1990/1/1' AND '2000/1/1';

-- Like % - operators uses --
SELECT * FROM customers
WHERE address LIKE '%Trail%' OR  address LIKE '%Avenue%';

SELECT * FROM customers
WHERE phone LIKE ('%9');
-- REGEXP EXAMPLES---
SELECT * FROM customers
WHERE first_name REGEXP 'ELKA|AMBUR';
SELECT * FROM customers
WHERE last_name REGEXP 'ey$|on$';

SELECT * FROM customers
WHERE last_name REGEXP '^my|se';

SELECT * FROM customers
WHERE last_name REGEXP 'b[ru]';

SELECT * FROM orders
WHERE shipped_date IS NULL;

SELECT * FROM order_items
WHERE order_id = 2
ORDER BY quantity * unit_price DESC;

SELECT * FROM customers
ORDER BY points DESC
LIMIT 3 ;
-- inner join examples -- we can also call inner join AS JOIN . it also not matters if we type INNER JOIN OR JOIN
SELECT order_id, p.product_id, p.name, o.unit_price 
FROM order_items o
JOIN  products p ON o.product_id = p.product_id;
-- Multiple databases joining and fetch data 
SELECT * FROM order_items o
JOIN sql_inventory.products p 
ON o.product_id = p.product_id;
-- joining multiple tables example from sql_invoicing database.
USE sql_invoicing;
SELECT ps.date,cl.name,ps.invoice_id,ps.amount,pd.name AS Paymenttype
FROM payments ps
JOIN clients cl
ON ps.client_id = cl.client_id
JOIN payment_methods pd
ON ps.payment_method = pd.payment_method_id;
-- composite key joining. compound join . where more than 2 primary keys neeeds to match to get the accurate data.
USE sql_store;
SELECT * FROM order_items oi
JOIN order_item_notes oin
ON oi.order_id = oin.order_id
AND oi.product_id = oin.product_id;
-- OUTER JOIN. its actually invisible like the word inner. left and right actually means the joining is iuter join.-
SELECT p.product_id,p.name,oi.quantity
FROM products p 
LEFT JOIN order_items oi
ON p.product_id = oi.product_id;
-- LEFT Join means joing with the 2nd table with the first one.--
-- Right join means joining the first table with the 2nd one...--

-- Outer JOIN with multiple tables example
SELECT os.order_date, os.order_id, cs.first_name, sh.name, oes.name
FROM orders os
JOIN customers cs
ON os.customer_id = cs.customer_id
LEFT JOIN shippers as sh
ON os.shipper_id = sh.shipper_id
JOIN order_statuses oes
ON os.status = oes.order_status_id
ORDER BY os.order_date DESC;

-- start using the USING phrase in sql instaed of ON example below
USE sql_invoicing;

SELECT pa.date,c.name, pa.amount, pmd.name
FROM payments pa
LEFT JOIN clients c
USING(client_id)
JOIN payment_methods pmd
ON pa.payment_method = pmd.payment_method_id;

-- CROSS JOIN --
USE sql_store;
SELECT p.name,p.unit_price,s.name
FROM products p
CROSS JOIN shippers s
ORDER BY p.name;
-- USE of UNION--
SELECT customer_id, first_name,points, 'BRONZE' AS TYPE
FROM customers
WHERE points <= 2000 
UNION
SELECT customer_id, first_name,points, 'SILVER' AS TYPE
FROM customers
WHERE points BETWEEN 2000 AND 3000 
UNION
SELECT customer_id, first_name,points, 'GOLD' AS TYPE
FROM customers
WHERE points > 3000 
ORDER BY first_name;
-- DATA INSERTAION__
INSERT INTO customers(
first_name,last_name,birth_date,address,city,state)
VALUES('JHON','Smith','1990-01-05','address','city','FL');

INSERT INTO products(name,quantity_in_stock,unit_price)
VALUES('MUG','34','8.90'),('perfume','56','7.9'),('Mirror','76','8.45');

INSERT INTO orders(customer_id,order_date,status)
VALUES(2,'2023-02-22',1);

INSERT INTO order_items
VALUES (LAST_INSERT_ID(),2,1,2.94),
	   (LAST_INSERT_ID(),3,2,1.94);
       
-- creating new table with copying data from another table
CREATE TABLE invoices_archived AS
SELECT i.invoice_id,i.number, c.name,i.invoice_total,i.payment_total,i.invoice_date,i.due_date,i.payment_date
FROM invoices i
JOIN clients c
USING(client_id)
WHERE i.payment_date IS NOT NULL;
-- UPDATE DATA IN SQL

UPDATE customers
SET points = points+50
WHERE birth_date < '1990-01-01';

-- new--
UPDATE orders
SET comments = 'Gold customer'
WHERE customer_id IN
				(SELECT customer_id
				FROM customers
				WHERE points>3000)








