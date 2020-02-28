#!/bin/bash
# Rebuild the COMSM0016 database from scratch.
SOURCE=/vagrant/sql

echo "Installing course DB tables"

mysql <<DATA -h 127.0.0.1 -u root -ppassword

\. ${SOURCE}/setup.sql
USE census;
\. ${SOURCE}/census/setup-census.sql
\. ${SOURCE}/census/import.sql

USE elections15;
\. ${SOURCE}/elections/setup-elections.sql
\. ${SOURCE}/elections/elections-rawdata.sql
LOAD DATA INFILE '${SOURCE}/elections/elections-2015.csv' INTO TABLE Rawdata FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
INSERT INTO Ward (name, electorate) SELECT DISTINCT ward, electorate FROM Rawdata;
INSERT INTO Party (name) SELECT DISTINCT party FROM Rawdata;
INSERT INTO Candidate (name, party, ward, votes) SELECT candidate, Party.id, Ward.id, votes FROM Rawdata
INNER JOIN Party ON Party.name = Rawdata.party INNER JOIN Ward ON Ward.name = Rawdata.ward;
DROP TABLE Rawdata;

USE elections14;
\. ${SOURCE}/elections/setup-elections.sql
\. ${SOURCE}/elections/elections-rawdata.sql
LOAD DATA INFILE '${SOURCE}/elections/elections-2014.csv' INTO TABLE Rawdata FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 LINES;
INSERT INTO Ward (name, electorate) SELECT DISTINCT ward, electorate FROM Rawdata;
INSERT INTO Party (name) SELECT DISTINCT party FROM Rawdata;
INSERT INTO Candidate (name, party, ward, votes) SELECT candidate, Party.id, Ward.id, votes FROM Rawdata
INNER JOIN Party ON Party.name = Rawdata.party INNER JOIN Ward ON Ward.name = Rawdata.ward;
DROP TABLE Rawdata;

USE uni;
\. ${SOURCE}/uni/uni.sql
\. ${SOURCE}/uni/unidata.sql

DATA
