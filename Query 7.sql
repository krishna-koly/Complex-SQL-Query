
create table weather
(
id int,
city varchar(50),
temperature int,
day date
);
delete from weather;
INSERT INTO weather 
VALUES
(1, 'London', -1, '2021-01-01'),
(2, 'London', -2, '2021-01-02'),
(3, 'London', 4, '2021-01-03'),
(4, 'London', 1, '2021-01-04'),
(5, 'London', -2, '2021-01-05'),
(6, 'London', -5, '2021-01-06'),
(7, 'London', -7, '2021-01-07'),
(8, 'London', 5, '2021-01-08');


select * from weather;

-- Question: From the weather table, fetch all the records when London had extremely cold temperature for 3 consecutive days or more.

with cte as (
select *,
row_number() over( order by id) as rnk,
id - row_number() over( order by id) as difference
from weather
where temperature <0
)
,
t2 as(
select *, count(*) over(partition by difference) as ok
from cte
)
select id,city,temperature,day
from t2 where ok = 3













