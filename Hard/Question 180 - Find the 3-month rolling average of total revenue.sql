-- Find the 3-month rolling average of total revenue from purchases 
-- Given a table with users, their purchase amount, and date purchased.
-- Do not include returns which are represented by negative purchase values. 
-- Output the year-month (YYYY-MM) and 3-month rolling average of revenue, sorted from earliest month to latest month.

-- A 3-month rolling average is defined by calculating the average total revenue from all user purchases for the current month and previous two months. 
-- The first two months will not be a true 3-month rolling average since we are not given data from last year. 
-- Assume each month has at least one purchase.


-- Table : Purchase
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | created_dt    | date    |
-- | amount        | float   |
-- +---------------+---------+
-- (user_id, created_dt) is the primary key for this table.

-- +---------+------------+--------+
-- | user_id | created_dt | amount |
-- +---------+------------+--------+
-- | 1       | 2020-01-02 | 120    |
-- | 2       | 2020-01-03 | 22     |
-- | 7       | 2020-01-11 | 232    |
-- | 1       | 2020-02-04 | 7      |
-- | 9       | 2020-02-25 | 33     |
-- | 9       | 2020-02-25 | 66     |
-- | 9       | 2020-02-25 | 33     |

-- | 9       | 2020-03-25 | 66     |
-- | 8       | 2020-03-28 | 1      |
-- | 9       | 2020-03-25 | 99     |
-- | 8       | 2020-03-28 | 1      |
-- | 9       | 2020-04-25 | 99     |
-- | 1       | 2020-04-02 | 120    |
-- | 2       | 2020-04-03 | 22     |
-- | 7       | 2020-05-11 | 232    |
-- | 1       | 2020-05-04 | 7      |
-- | 9       | 2020-05-25 | 33     |
-- | 9       | 2020-05-25 | 66     |
-- | 8       | 2020-06-28 | 1      |
-- | 9       | 2020-06-25 | 99     |
-- | 8       | 2020-06-28 | 1      |
-- | 9       | 2020-07-25 | 99     |
-- | 1       | 2020-08-02 | 120    |
-- +---------+------------+--------+

Create table Purchase(user_id int, created_dt date, amount int);
Insert into Purchase values
(1,'2020-01-02',120),
(2,'2020-01-03',22 ),
(7,'2020-01-11',232),
(1,'2020-02-04',7  ),
(9,'2020-02-25',33 ),
(9,'2020-02-25',66 ),
(9,'2020-02-25',33 ),
(9,'2020-03-25',66 ),
(8,'2020-03-28',1  ),
(9,'2020-03-25',99 ),
(8,'2020-03-28',1  ),
(9,'2020-04-25',99 ),
(1,'2020-04-02',120),
(2,'2020-04-03',22 ),
(7,'2020-05-11',232),
(1,'2020-05-04',7  ),
(9,'2020-05-25',33 ),
(9,'2020-05-25',66 ),
(8,'2020-06-28',1  ),
(9,'2020-06-25',99 ),
(8,'2020-06-28',1  ),
(9,'2020-07-25',99 ),
(1,'2020-08-02',120);
--Solution

Select YrMonth
      ,avg(monthlyrev) over(order by YrMonth Rows between 2 preceding and current row) as threeMonthsMovingAvg
 from (
	
	select convert(varchar(7),created_dt,23) as YrMonth,avg(amount) as monthlyrev 
          from purchase
         where amount>0
         group by convert(varchar(7),created_dt,23)
)t;


