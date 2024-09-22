-- Write a query to print start date and end date of all project.


-- Table : Task
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | start         | date    |
-- | end           | date    |
-- +---------------+---------+

-- +---------+------------+------------+
-- | id      | start      | end        |
-- +---------+------------+------------+
-- | 1       | 2020-01-01 | 2020-01-02 |
-- | 2       | 2020-01-02 | 2020-01-03 |
-- | 3       | 2020-01-03 | 2020-01-04 |
-- | 4       | 2020-02-10 | 2020-01-11 |
-- | 5       | 2020-02-11 | 2020-01-12 |
-- | 6       | 2020-02-20 | 2020-01-21 |
-- | 7       | 2020-02-29 | 2020-01-30 |
-- +---------+------------+------------+

Create table task(id int, start date, end date);

Insert into task values
(1,'2024-01-01','2024-01-02'),
(2,'2024-01-02','2024-01-03'),
(3,'2024-01-03','2024-01-04'),
(4,'2024-01-10','2024-01-11'),
(5,'2024-01-11','2024-01-12'),
(6,'2024-01-20','2024-01-21'),
(7,'2024-01-29','2024-01-30');
--Solution

with CTE as (
	Select *, 
  		   COALESCE(Lead(start) over(order by id),'9999-12-31') as next_start,
  		   COALESCE(Lag(start) over(order by id),'1800-01-01') as previous_start
  	from task
)
Select end
from CTE
where end!=next_start and start!=previous_start;

