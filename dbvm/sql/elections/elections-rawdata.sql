DROP TABLE IF EXISTS Rawdata;

CREATE TABLE Rawdata (
    date DATE, ward VARCHAR(100),
    electorate INTEGER, candidate VARCHAR(100),
    party VARCHAR(100), votes INTEGER,
    percent DECIMAL(5,2)
);
