-- Question 88
-- Table: Candidate

-- +-----+---------+
-- | id  | Name    |
-- +-----+---------+
-- | 1   | A       |
-- | 2   | B       |
-- | 3   | C       |
-- | 4   | D       |
-- | 5   | E       |
-- +-----+---------+  
-- Table: Vote

-- +-----+--------------+
-- | id  | CandidateId  |
-- +-----+--------------+
-- | 1   |     2        |
-- | 2   |     4        |
-- | 3   |     3        |
-- | 4   |     2        |
-- | 5   |     5        |
-- +-----+--------------+
-- id is the auto-increment primary key,
-- CandidateId is the id appeared in Candidate table.
-- Write a sql to find the name of the winning candidate, the above example will return the winner B.
-- Create table Candidate(id int, Name varchar(6));
-- Insert into Candidate values(1,'A'),
-- (2,'B'),
-- (3,'C'),
-- (4,'D'),
-- (5,'E');
-- Create table Vote(id int, CandidateId int);
-- Insert into Vote values(1,2),(2,4),(3,3),(4,2),(5,5);
-- +------+
-- | Name |
-- +------+
-- | B    |
-- +------+
-- Notes:

-- You may assume there is no tie, in other words there will be only one winning candidate

-- Solution

With CTE as (
	Select CandidateId, count(*) as cnt
	from Vote
	group by CandidateId)
Select Name from Candidate 
inner join CTE 
on id = CandidateId
where cnt = (Select max(cnt) from CTE);
