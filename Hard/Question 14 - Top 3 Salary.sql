-- Question 14
-- The Employee table holds all employees. Every employee has an Id, and there is also a column for the department Id.

-- +----+-------+--------+--------------+
-- | Id | Name  | Salary | DepartmentId |
-- +----+-------+--------+--------------+
-- | 1  | Joe   | 85000  | 1            |
-- | 2  | Henry | 80000  | 2            |
-- | 3  | Sam   | 60000  | 2            |
-- | 4  | Max   | 90000  | 1            |
-- | 5  | Janet | 69000  | 1            |
-- | 6  | Randy | 85000  | 1            |
-- | 7  | Will  | 70000  | 1            |
-- +----+-------+--------+--------------+
-- The Department table holds all departments of the company.

-- +----+----------+
-- | Id | Name     |
-- +----+----------+
-- | 1  | IT       |
-- | 2  | Sales    |
-- +----+----------+
-- Write a SQL query to find employees who earn the top three salaries in each of the department. For the above tables, your SQL query should return the following rows (order of rows does not matter).

-- Create table Employees(id int, Name varchar(20), Salary int, DepartmentId int);
-- Insert into Employees values
-- (1,'Joe',85000,1),
-- (2,'Henry',80000,2),
-- (3,'Sam',60000,2),
-- (4,'Max',90000,1),
-- (5,'Janet',69000,1),
-- (6,'Randy',85000,1),
-- (7,'Will',70000,1);

-- Create table Department(id int, Name varchar(20));
-- Insert into Department values(1,'IT'),(2,'Sales');
-- +------------+----------+--------+
-- | Department | Employee | Salary |
-- +------------+----------+--------+
-- | IT         | Max      | 90000  |
-- | IT         | Randy    | 85000  |
-- | IT         | Joe      | 85000  |
-- | IT         | Will     | 70000  |
-- | Sales      | Henry    | 80000  |
-- | Sales      | Sam      | 60000  |
-- +------------+----------+--------+
-- Explanation:

-- In IT department, Max earns the highest salary, both Randy and Joe earn the second highest salary, 
-- and Will earns the third highest salary. 
-- There are only two employees in the Sales department, 
-- Henry earns the highest salary while Sam earns the second highest salary.

-- convert(varchar(6), a.pay_date, 112)
-- Solutions
With top3 as(Select *, dense_rank() over(partition by DepartmentId order by Salary desc) as rnk from Employees)
Select d.Name as Department, e.Name as Employee, e.Salary
from Department d inner join top3 e on d.id = e.DepartmentId
where rnk<=3;
