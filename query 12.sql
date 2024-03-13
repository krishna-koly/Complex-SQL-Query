select * from employeee;

#Question : Display the employees who are earning the same salary in the table

-- In a department, more than one employee may have the same salary.


select * from employeee;

SELECT e1.EMPNO, e1.ENAME, e1.JOB, e1.SAL
FROM employeee e1
JOIN employeee e2 ON e1.SAL = e2.SAL AND e1.EMPNO <> e2.EMPNO;


#Alternative Approach 

SELECT EMPNO,ENAME,JOB,SAL
FROM employeee
WHERE SAL IN (
    SELECT SAL
    FROM employeee
    GROUP BY SAL
    HAVING COUNT(*) > 1
);


