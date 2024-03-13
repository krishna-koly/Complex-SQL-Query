CREATE TABLE user_transaction(
 user_id varchar(25),
 visit int,
 make_order char(10));
 
INSERT INTO user_transaction VALUES
('4a495637', 2, 'true'),
('0288950d', 3, 'false'),
('434d93d7', 4, 'true'),
('0cf653b3', 5, 'true'),
('e4046cd7796c', 0, 'false'),
('4e5cc7cc3743', 1, 'false'),
('10bc8ea99240', 6, 'true'),
('545a8c79deab', 3, 'false'),
('d9de62380374', 3, 'true'),
('768ec99c', 7, 'true'),
('e4c9a45e1c2c', 0, 'false');

#Question: Calculate the conversion rate of Paid Order users from the number of users who visited
-- PAID ORDERS users: number of users who completed the transaction. It is possible a user can never visit.
-- A user who placed the order completes the transaction
-- Multiply the rate by 100.0 to get better and more readable output.

select * from user_transaction;

SELECT Round(100.0*(COUNT(DISTINCT user_id)/(SELECT count(user_id) FROM user_transaction WHERE visit IS NOT NULL)),1)AS conversion_rate
FROM user_transaction
WHERE make_order = 'True';
