-- Question 107
-- The Numbers table keeps the value of number and its frequency.

-- +----------+-------------+
-- |  Number  |  Frequency  |
-- +----------+-------------|
-- |  0       |  7          |
-- |  1       |  1          |
-- |  2       |  3          |
-- |  3       |  1          |
-- +----------+-------------+
-- In this table, the numbers are 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, so the median is (0 + 0) / 2 = 0.
CREATE TABLE Numbers (
  Number int,
  Frequency int);

INSERT INTO Numbers VALUES
(2,7),(3,1),(5,3),(7,1);
-- +--------+
-- | median |
-- +--------|
-- | 0.0000 |
-- +--------+
-- Write a query to find the median of all numbers and name the result as median.

-- Solution

SELECT avg(Number) as median
  FROM(
		SELECT *
		    ,sum(Frequency) over(order by Number asc) as sum_freq
		    ,sum(Frequency) over() as cnt
		  FROM Numbers
	  	)t
  	WHERE cnt/2 between sum_freq - Frequency and sum_freq

-- Mode
-- SELECT Number
--   FROM Numbers
--  WHERE Frequency = (SELECT max(frequency) FROM Numbers)
-- Mode = 3*Median - 2*Mean
-- Median = (Mode +(2*Mean))/3
(2+2*3.25)/3
-- -- Mean
-- SELECT avg(Number)
--   FROM Numbers

--Another approach
With Mode as (SELECT Number 
			    FROM Numbers
			   WHERE Frequency = (SELECT max(frequency) as Mode
	 	   					  		FROM Numbers))
,Mean as (SELECT cast(sum(Number*Frequency)/sum(Frequency) as Float)as Number
			From Numbers)
SELECT Trim(((SELECT Number from Mode) + 2 *(SELECT Number FROM Mean))/3,0) as Median

