-- Question 109
-- Table: Players

-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | player_id   | int   |
-- | group_id    | int   |
-- +-------------+-------+
-- player_id is the primary key of this table.
-- Each row of this table indicates the group of each player.
-- Table: Matches

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | match_id      | int     |
-- | first_player  | int     |
-- | second_player | int     | 
-- | first_score   | int     |
-- | second_score  | int     |
-- +---------------+---------+
-- match_id is the primary key of this table.
-- Each row is a record of a match, first_player and second_player contain the player_id of each match.
-- first_score and second_score contain the number of points of the first_player and second_player respectively.
-- You may assume that, in each match, players belongs to the same group.
 

-- The winner in each group is the player who scored the maximum total points within the group. In the case of a tie, 
-- the lowest player_id wins.

-- Write an SQL query to find the winner in each group.

-- The query result format is in the following example:

-- Players table:
-- +-----------+------------+
-- | player_id | group_id   |
-- +-----------+------------+
-- | 15        | 1          |
-- | 25        | 1          |
-- | 30        | 1          |
-- | 45        | 1          |
-- | 10        | 2          |
-- | 35        | 2          |
-- | 50        | 2          |
-- | 20        | 3          |
-- | 40        | 3          |
-- +-----------+------------+

-- Matches table:
-- +------------+--------------+---------------+-------------+--------------+
-- | match_id   | first_player | second_player | first_score | second_score |
-- +------------+--------------+---------------+-------------+--------------+
-- | 1          | 15           | 45            | 3           | 0            |
-- | 2          | 30           | 25            | 1           | 2            |
-- | 3          | 30           | 15            | 2           | 0            |
-- | 4          | 40           | 20            | 5           | 2            |
-- | 5          | 35           | 50            | 1           | 1            |
-- +------------+--------------+---------------+-------------+--------------+

-- Create table Players(player_id int, group_id int);
-- Insert into Players values(15,1),
-- (25,1),
-- (30,1),
-- (45,1),
-- (10,2),
-- (35,2),
-- (50,2),
-- (20,3),
-- (40,3);

-- Create table Matches(match_id int, first_player int, second_player int, first_score int, second_score int);
-- Insert into Matches values(1,15 ,45  ,3 ,0),
-- (2,30 ,25  ,1 ,2),
-- (3,30 ,15  ,2 ,0),
-- (4,40 ,20  ,5 ,2),
-- (5,35 ,50  ,1 ,1);

-- Result table:
-- +-----------+------------+
-- | group_id  | player_id  |
-- +-----------+------------+ 
-- | 1         | 15         |
-- | 2         | 35         |
-- | 3         | 40         |
-- +-----------+------------+

-- Solution
WITH Winner as
	(	
		SELECT CASE WHEN first_score<second_score THEN second_player
					WHEN first_score>second_score THEN first_player
					ELSE
					CASE WHEN first_player<second_player 
						 THEN first_player
						ELSE second_player
						END
				END as player_id
			  ,CASE WHEN first_score>second_score
			  		THEN first_score
			  		ELSE second_score END as score
		  FROM Matches
		),
	WinnersGroup as
	(
		SELECT a.group_id,a.player_id,b.score
		  FROM Players a
		 INNER JOIN Winner b
			ON a.player_id = b.player_id
		)
SELECT a.group_id,a.player_id
  FROM WinnersGroup a
 INNER JOIN (SELECT group_id,max(score) as score 
			   FROM WinnersGroup 
			  GROUP BY group_id) b
    ON a.group_id = b.group_id
   AND a.score = b.score;