
-- Question 52
-- Write a SQL query to find all numbers that appear at least three times consecutively.

-- +----+-----+
-- | Id | Num |
-- +----+-----+
-- | 1  |  1  |
-- | 2  |  1  |
-- | 3  |  1  |
-- | 4  |  2  |
-- | 5  |  1  |
-- | 6  |  2  |
-- | 7  |  2  |
-- +----+-----+
-- For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

Create table Logs (Id int, Num int);

Insert into Logs values(1,1),
(2,1),
(3,1),
(4,2),
(5,1),
(6,2),
(7,2);

-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+

Select Num from(
Select *, lead(id,2) over(partition by Num order by Id) lead_id
from Logs)t
where lead_id-id = 2