CREATE TABLE WEATHERS(
 id int,
 recordDate Date,
 temperature int
);
INSERT INTO WEATHERS VALUES
 (1, '2015-01-01',10),
 (2, '2015-01-02',25),
 (3, '2015-01-03',20),
 (4, '2015-01-04',30);
 
 SELECT * FROM WEATHERS;
 
 -- Write an SQL query to find all dates and IDs with higher temperatures compared to their previous dates (yesterday).
 
 
 select w1.id 
 from WEATHERS w1, WEATHERS w2 
 where w1.temperature>w2.temperature and datediff(w1.recordDate,w2.recordDate)=1
 group by w1.id;
 
 #Alternative approach
 
 with cte as(
 select *, lag(temperature)over(order by recordDate,temperature) as ok
 from WEATHERS
 )
 SELECT id FROM cte
 where temperature>ok
 
 
 
 
 
 
 
 
 
 
 
 