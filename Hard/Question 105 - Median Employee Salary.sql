-- Question 105
-- The Employee table holds all employees. The employee table has three columns: Employee Id, Company Name, and Salary.

-- +-----+------------+--------+
-- |Id   | Company    | Salary |
-- +-----+------------+--------+
-- |1    | A          | 2341   |
-- |2    | A          | 341    |
-- |3    | A          | 15     |
-- |4    | A          | 15314  |
-- |5    | A          | 451    |
-- |6    | A          | 513    |
-- |7    | B          | 15     |
-- |8    | B          | 13     |
-- |9    | B          | 1154   |
-- |10   | B          | 1345   |
-- |11   | B          | 1221   |
-- |12   | B          | 234    |
-- |13   | C          | 2345   |
-- |14   | C          | 2645   |
-- |15   | C          | 2645   |
-- |16   | C          | 2652   |
-- |17   | C          | 65     |
-- +-----+------------+--------+
-- Write a SQL query to find the median salary of each company. Bonus points if you can solve it without using any built-in SQL functions.

-- Create table Employee(id int, Company varchar(1),Salary int);
-- Insert into Employee values
-- (1 ,'A',2341 ),
-- (2 ,'A',341  ),
-- (3 ,'A',15   ),
-- (4 ,'A',15314),
-- (5 ,'A',451  ),
-- (6 ,'A',513  ),
-- (7 ,'B',15   ),
-- (8 ,'B',13   ),
-- (9 ,'B',1154 ),
-- (10,'B',1345 ),
-- (11,'B',1221 ),
-- (12,'B',234  ),
-- (13,'C',2345 ),
-- (14,'C',2645 ),
-- (15,'C',2645 ),
-- (16,'C',2652 ),
-- (17,'C',65   );

-- +-----+------------+--------+
-- |Id   | Company    | Salary |
-- +-----+------------+--------+
-- |5    | A          | 451    |
-- |6    | A          | 513    |
-- |12   | B          | 234    |
-- |9    | B          | 1154   |
-- |14   | C          | 2645   |
-- +-----+------------+--------+

-- Solution

WITH CTE as 
(
	SELECT *,row_number() over(partition by Company order by Salary) rno
			,count(1) over(partition by Company) as cnt
	  FROM Employee
	  )
SELECT id, Company, Salary
  FROM CTE 
 WHERE rno between cnt/2.0 and (cnt/2.0)+1   -- Making cnt float is imp
 ORDER BY Company,Salary;