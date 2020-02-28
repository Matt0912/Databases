DROP TABLE IF EXISTS Enrol;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Unit;
DROP TABLE IF EXISTS Lecturer;
DROP TABLE IF EXISTS RGroup;

CREATE TABLE RGroup (
    id       INTEGER      PRIMARY KEY AUTO_INCREMENT,
    name     VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Lecturer (
    id       INTEGER      PRIMARY KEY AUTO_INCREMENT,
    name     VARCHAR(100) NOT NULL,
    username VARCHAR(10)  NOT NULL UNIQUE,
    office   VARCHAR(20)  NULL,
    rgroup   INTEGER      NULL,
    FOREIGN KEY (rgroup) REFERENCES RGroup(id)
);

CREATE TABLE Unit (
    id       INTEGER      PRIMARY KEY AUTO_INCREMENT,
    title    VARCHAR(100) NOT NULL UNIQUE,
    code     VARCHAR(9)   NOT NULL UNIQUE,
    level    CHAR(1)      NOT NULL,
    cp       INTEGER      NOT NULL,
    director INTEGER      NOT NULL,
    FOREIGN KEY (director) REFERENCES Lecturer(id)
);

CREATE TABLE Student (
    id       INTEGER      PRIMARY KEY AUTO_INCREMENT,
    name     VARCHAR(100) NOT NULL,
    username VARCHAR(10)  NOT NULL UNIQUE,
    cohort   VARCHAR(10)  NOT NULL,
    grade    INTEGER      NULL
);

CREATE TABLE Enrol (
    student  INTEGER      NOT NULL,
    unit     INTEGER      NOT NULL,
    grade    INTEGER      NULL,
    FOREIGN KEY (student) REFERENCES Student(id),
    FOREIGN KEY (unit) REFERENCES Unit(id),
    PRIMARY KEY (student, unit)
);
