-- This file is for your solutions to the census question.
-- Lines starting with -- ! are recognised by a script that we will
-- use to automatically test your queries, so you must not change
-- these lines or create any new lines starting with this marker.
--
-- You may break your queries over several lines, include empty
-- lines and SQL comments wherever you wish.
--
-- Remember that the answer to each question goes after the -- !
-- marker for it and that the answer to each question must be
-- a single SQL query.
--
-- Upload this file to SAFE as part of your coursework.

-- !census

-- !question0

-- Sample solution to question 0.
SELECT data FROM Statistic WHERE wardId = 'E05001982' AND
occId = 2 AND gender = 0;

-- !question1

SELECT data FROM Statistic
WHERE WardId = 'E05001975' AND gender = 1 AND occId = 7;

-- !question2

SELECT SUM(data) FROM Statistic
WHERE WardId = 'E05000697' AND occId = 5;

-- !question3

SELECT SUM(data) AS num_people, Occupation.name AS occ_class FROM Statistic
JOIN Occupation ON Statistic.occId = Occupation.id
WHERE WardId = 'E05008884'
GROUP BY Occupation.name;

-- !question4

SELECT SUM(data) AS 'working population', WardId,
Ward.name AS Ward, County.name AS County FROM Statistic
JOIN Ward ON Statistic.Wardid=Ward.Code
JOIN County ON County.Code=Ward.parent
GROUP BY WardId
ORDER BY SUM(data) ASC
LIMIT 1;

-- !question5
WITH OverThousand AS
  (SELECT SUM(data) AS 'working population', WardId AS ID,
  Ward.name AS Ward, County.name AS County FROM Statistic
  JOIN Ward ON Statistic.Wardid=Ward.Code
  LEFT OUTER JOIN County ON County.Code=Ward.parent
  GROUP BY WardId
  HAVING SUM(data) >= 1000)
  SELECT COUNT(*) AS 'Wards Over 1000' FROM OverThousand;


-- !question6

WITH RegionSizes AS
  (SELECT SUM(Statistic.data) AS working_population, WardId AS ID,
  Ward.name AS Ward, County.name AS County, Region.code AS Region FROM Statistic
  JOIN Ward ON Statistic.Wardid=Ward.Code
  JOIN County ON County.Code=Ward.parent
  JOIN Region ON County.parent=Region.code
  GROUP BY WardId
  ORDER BY Region ASC)
  SELECT Region.name AS name, AVG(RegionSizes.working_population) AS avg_size FROM RegionSizes
  JOIN Region ON RegionSizes.Region=Region.code
  GROUP BY Region.name;

-- !question7

SELECT County.name AS CLU, Occupation.name AS Occupation, (CASE WHEN
gender = 1 THEN "female" ELSE "male" END) AS gender, SUM(data) AS N FROM Statistic
JOIN Ward ON Statistic.Wardid=Ward.Code
JOIN County ON County.Code=Ward.parent
JOIN Region ON County.parent=Region.code
JOIN Occupation ON Statistic.occId=Occupation.id
WHERE Region.code = 'E12000002'
GROUP BY County.name, Occupation, gender
HAVING SUM(data) >= 10000
ORDER BY N ASC;

-- !question8

WITH Managers AS
  (SELECT Region.name AS Region, Occupation.name AS Occupation, (CASE WHEN
  gender = 1 THEN "female" ELSE "male" END) AS gender, SUM(data) AS N FROM Statistic
  JOIN Ward ON Statistic.Wardid=Ward.Code
  JOIN County ON County.Code=Ward.parent
  JOIN Region ON County.parent=Region.code
  JOIN Occupation ON Statistic.occId=Occupation.id
  WHERE Occupation.id = 1
  GROUP BY Region, gender
  ORDER BY Region ASC),
Almost AS
  (SELECT Region, MAX(CASE WHEN gender = "male" THEN N ELSE NULL END) AS MaleManagers,
  MAX(CASE WHEN gender = "female" THEN N ELSE NULL END) AS FemaleManagers FROM Managers
  GROUP BY Region)
  SELECT Region, MaleManagers, FemaleManagers,
  CONCAT(ROUND(FemaleManagers/(MaleManagers + FemaleManagers)*100,2), '%') AS FemaleProportion FROM Almost
  ORDER BY FemaleProportion ASC;


-- !question9

WITH RegionSizes AS
  (SELECT SUM(Statistic.data) AS working_population, WardId AS ID,
  Ward.name AS Ward, County.code AS County, Region.code AS Region FROM Statistic
  JOIN Ward ON Statistic.Wardid=Ward.Code
  JOIN County ON County.Code=Ward.parent
  JOIN Region ON County.parent=Region.code
  GROUP BY WardId
  ORDER BY Region ASC),
AllData AS
  (SELECT SUM(Statistic.data) AS working_population, WardId AS ID,
  Ward.name AS Ward FROM Statistic
  JOIN Ward ON Statistic.Wardid=Ward.Code
  GROUP BY WardId)
  SELECT Region.name AS name, AVG(RegionSizes.working_population) AS avg_size FROM RegionSizes
  JOIN Region ON RegionSizes.Region=Region.code
  GROUP BY Region.name
  UNION
  SELECT 'England', AVG(RegionSizes.working_population) FROM RegionSizes
  UNION
  SELECT 'All', AVG(AllData.working_population) FROM AllData;

-- !end
