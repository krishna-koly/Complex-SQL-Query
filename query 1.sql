create schema TFQ_Complex;

create table users
(
user_id int primary key,
user_name varchar(30) not null,
email varchar(50));

insert into users values
(1, 'Sumit', 'sumit@gmail.com'),
(2, 'Reshma', 'reshma@gmail.com'),
(3, 'Farhana', 'farhana@gmail.com'),
(4, 'Robin', 'robin@gmail.com'),
(5, 'Robin', 'robin@gmail.com');

SET @@sql_mode = SYS.LIST_DROP(@@sql_mode, 'ONLY_FULL_GROUP_BY');
SELECT @@sql_mode;
-- -----------------------

#Question 01 : Write a SQL Query to fetch all the duplicate records in a table

with cte as (
select *,row_number() over(partition by user_name order by user_id) as ok
from users
)
select user_id,user_name,email
from cte
where ok<>1;

#ALTERNATIVE SOLUTION
select user_id,user_name,email
from users
group by user_name,email
having count(user_name)>1













