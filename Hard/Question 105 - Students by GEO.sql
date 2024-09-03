-- Question 105
-- A U.S graduate school has students from Asia, Europe and America. 
-- The students' location information are stored in table student as below.
 

-- | name   | continent |
-- |--------|-----------|
-- | Jack   | America   |
-- | Pascal | Europe    |
-- | Xi     | Asia      |
-- | Jane   | America   |
 

-- Pivot the continent column in this table so that each name is sorted alphabetically and displayed underneath its corresponding continent. The output headers should be America, Asia and Europe respectively. It is guaranteed that the student number from America is no less than either Asia or Europe.
 

-- For the sample input, the output is:
 
-- Create table student(name varchar(20),continent varchar(20));
-- Insert into student values('Jack','America'),('Pascal','Europe'),('Xi','Asia'),('Jane','America');

-- | America | Asia | Europe |
-- |---------|------|--------|
-- | Jack    | Xi   | Pascal |
-- | Jane    |      |        |

-- Solution
SELECT MIN(CASE continent WHEN 'America' THEN name END) as America,
	   MIN(CASE continent WHEN 'Europe' THEN name END) as Europe,
	   MIN(CASE continent WHEN 'Asia' THEN name END) as Asia
  FROM (
  		SELECT *,ROW_NUMBER() OVER(partition by continent order by name) as rowno
  		)t
 GROUP BY rowno;