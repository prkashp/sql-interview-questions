-- Question 113
-- Table: Spending

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | user_id     | int     |
-- | spend_date  | date    |
-- | platform    | enum    | 
-- | amount      | int     |
-- +-------------+---------+
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile application.
-- (user_id, spend_date, platform) is the primary key of this table.
-- The platform column is an ENUM type of ('desktop', 'mobile').
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, 
-- desktop only and both mobile and desktop together for each date.

-- The query result format is in the following example:

-- Spending table:
-- +---------+------------+----------+--------+
-- | user_id | spend_date | platform | amount |
-- +---------+------------+----------+--------+
-- | 1       | 2019-07-01 | mobile   | 100    |
-- | 1       | 2019-07-01 | desktop  | 100    |
-- | 2       | 2019-07-01 | mobile   | 100    |
-- | 2       | 2019-07-02 | mobile   | 100    |
-- | 3       | 2019-07-01 | desktop  | 100    |
-- | 3       | 2019-07-02 | desktop  | 100    |
-- +---------+------------+----------+--------+

-- Create table Spending(user_id int, spend_date date, platform varchar(20), amount int);
-- Insert into Spending values
-- (1,'2019-07-01','mobile',100),
-- (1,'2019-07-01','desktop',100),
-- (2,'2019-07-01','mobile',100),
-- (2,'2019-07-02','mobile',100),
-- (3,'2019-07-01','desktop',100),
-- (3,'2019-07-02','desktop',100);
-- Result table:
-- +------------+----------+--------------+-------------+
-- | spend_date | platform | total_amount | total_users |
-- +------------+----------+--------------+-------------+
-- | 2019-07-01 | desktop  | 100          | 1           |
-- | 2019-07-01 | mobile   | 100          | 1           |
-- | 2019-07-01 | both     | 200          | 1           |
-- | 2019-07-02 | desktop  | 100          | 1           |
-- | 2019-07-02 | mobile   | 100          | 1           |
-- | 2019-07-02 | both     | 0            | 0           |
-- +------------+----------+--------------+-------------+ 
-- On 2019-07-01, user 1 purchased using both desktop and mobile, user 2 purchased using mobile only and user 3 purchased using desktop only.
-- On 2019-07-02, user 2 purchased using mobile only, user 3 purchased using desktop only and no one purchased using both platforms.

-- Solution

WITH SpendingDates as
(
	SELECT Distinct spend_date,platform
	  FROM Spending 
	 UNION
	SELECT Distinct spend_date,'both' as platform
	  FROM Spending
  ),
SpendingSummary as
(
	SELECT user_id,spend_date,sum(amount) as total_amount,case when count(platform)>1 then 'both' else platform end as platform
	  FROM Spending
	 GROUP BY user_id,spend_date
	)
SELECT a.spend_date,a.platform,COALESCE(b.total_amount,0) as total_amount,count(b.user_id) as total_users
  FROM SpendingDates a
 INNER JOIN SpendingSummary b
    ON a.spend_date = b.spend_date
   AND a.platform = b.platform
 GROUP BY a.spend_date,a.platform,b.total_amount;