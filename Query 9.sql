create table patient_logs
(
  account_id int,
  date date,
  patient_id int
);

INSERT INTO patient_logs VALUES (1, STR_TO_DATE('02-01-2020', '%d-%m-%Y'), 100);
INSERT INTO patient_logs VALUES (1, STR_TO_DATE('27-01-2020', '%d-%m-%Y'), 200);
INSERT INTO patient_logs VALUES (2, STR_TO_DATE('01-01-2020', '%d-%m-%Y'), 300);
INSERT INTO patient_logs VALUES (2, STR_TO_DATE('21-01-2020', '%d-%m-%Y'), 400);
INSERT INTO patient_logs VALUES (2, STR_TO_DATE('21-01-2020', '%d-%m-%Y'), 300);
INSERT INTO patient_logs VALUES (2, STR_TO_DATE('01-01-2020', '%d-%m-%Y'), 500);
INSERT INTO patient_logs VALUES (3, STR_TO_DATE('20-01-2020', '%d-%m-%Y'), 400);
INSERT INTO patient_logs VALUES (1, STR_TO_DATE('04-03-2020', '%d-%m-%Y'), 500);
INSERT INTO patient_logs VALUES (3, STR_TO_DATE('20-01-2020', '%d-%m-%Y'), 450);


select * from patient_logs;

#Question: Find the top 2 accounts with the maximum number of unique patients on a monthly basis


with cte as(
SELECT MONTHNAME(date) AS month, account_id,count(distinct patient_id) as total_no_of_patients
FROM patient_logs
group by month,account_id
),
t2 as(
select *, dense_rank() over(partition by month order by total_no_of_patients desc, account_id ) as ok
from cte
)
select  month,account_id,total_no_of_patients
from t2
where ok between 1 and 2
group by month,account_id,total_no_of_patients
order by total_no_of_patients desc;




