-- The comment lines starting -- ! are used by the automatic testing tool to
-- help mark your coursework. You must not modify them or add further lines
-- starting with -- !. Of course you can create comments of your own, just use
-- the normal -- to start them.

-- !elections

-- !question0
-- This is an example question and answer.

SELECT Party.name FROM Party
JOIN Candidate ON Candidate.party = Party.id
WHERE Candidate.name = 'Mark Bradshaw';

-- !question1

SELECT name FROM Party ORDER BY name;

-- !question2

SELECT SUM(Votes) FROM Candidate;

-- !question3

SELECT Candidate.name, Candidate.votes FROM Candidate JOIN Ward
ON Candidate.ward=Ward.id WHERE Ward.name = 'Bedminster';

-- !question4

SELECT Candidate.votes FROM Candidate
JOIN Party ON Party.id=Candidate.party
JOIN Ward ON Ward.id=Candidate.ward
WHERE Party.name = 'Liberal Democrat' AND Ward.name='Filwood';

-- !question5

SELECT Candidate.name, Party.name, Candidate.votes FROM Candidate
JOIN Party ON Party.id=Candidate.party
JOIN Ward ON Ward.id=Candidate.ward
WHERE Ward.name='Hengrove'
ORDER BY Candidate.votes DESC;

-- !question6

SELECT COUNT(1) AS LabourRank FROM Candidate
JOIN Party ON Party.id=Candidate.party
JOIN Ward ON Ward.id=Candidate.ward
WHERE Ward.name='Bishopsworth'
AND Candidate.votes >= (SELECT Candidate.votes FROM Candidate
                        JOIN Party ON Party.id=Candidate.party
                        JOIN Ward ON Ward.id=Candidate.ward
                        WHERE Ward.name='Bishopsworth' AND Party.name='Labour');

-- !question7

WITH WardVotes AS
(SELECT Ward.id AS WardID, SUM(Candidate.votes) AS TotalVotes FROM Candidate
JOIN Party ON Party.id=Candidate.party
JOIN Ward ON Ward.id=Candidate.ward
GROUP BY Ward.name)
  SELECT Ward.name, CONCAT(Candidate.votes/WardVotes.TotalVotes*100, '%') AS GreenVotes FROM Candidate
  JOIN Party ON Party.id=Candidate.party
  JOIN Ward ON Ward.id=Candidate.ward
  JOIN WardVotes ON WardVotes.WardID=Ward.id
  WHERE Party.name = 'Green';



-- !question8

WITH Green AS
(SELECT Ward.name AS GreenWard, Candidate.votes AS GreenVotes FROM Candidate
JOIN Party ON Party.id=Candidate.party
JOIN Ward ON Ward.id=Candidate.ward
WHERE Party.name='Green'),
Labour AS
(SELECT Ward.name AS LabourWard, Candidate.votes AS LabourVotes FROM Candidate
JOIN Party ON Party.id=Candidate.party
JOIN Ward ON Ward.id=Candidate.ward
WHERE Party.name='Labour')
SELECT Green.GreenWard AS ward, (Green.GreenVotes-Labour.LabourVotes)*100/Ward.electorate AS rel,
(Green.GreenVotes-Labour.LabourVotes) AS abs FROM Green
JOIN Labour ON Green.GreenWard=Labour.LabourWard
JOIN Ward ON Ward.name=Green.GreenWard
WHERE Green.GreenVotes > Labour.LabourVotes;

-- !end
