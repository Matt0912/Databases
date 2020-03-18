DROP TABLE IF EXISTS Attends;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS Has_Skill;
DROP TABLE IF EXISTS Skill;
DROP TABLE IF EXISTS Committee;
DROP TABLE IF EXISTS Member;

CREATE TABLE Member (
    email   VARCHAR(100) NOT NULL PRIMARY KEY,
    name    VARCHAR(100) NOT NULL,
    student_number INTEGER NULL,
    hoverboard_skill INTEGER NOT NULL
);

CREATE TABLE Committee (
  role   VARCHAR(100)  NOT NULL  PRIMARY KEY,
  CONSTRAINT Committee_Member_FK FOREIGN KEY (role) REFERENCES
  Member(email)
);

CREATE TABLE Skill (
  name  VARCHAR(100)  NOT NULL  PRIMARY KEY
);

CREATE TABLE Has_Skill (
  member  VARCHAR(100)  NOT NULL,
  skill   VARCHAR(100)  NOT NULL,
  skill_level   INTEGER   NOT NULL,
  CONSTRAINT Has_Skill_Member_FK FOREIGN KEY (member) REFERENCES Member(email),
  CONSTRAINT Has_Skill_Skill_FK FOREIGN KEY (skill) REFERENCES Skill(name)
);

CREATE TABLE Event (
  id  INTEGER  NOT NULL  PRIMARY KEY,
  organiser   VARCHAR(100)  NOT NULL,
  date  DATE NOT NULL,
  name    VARCHAR(100) NOT NULL,
  location    VARCHAR(100)  NOT NULL,
  description VARCHAR(100)  NULL,
  CONSTRAINT Event_Member_FK FOREIGN KEY (organiser) REFERENCES Member(email),
  CONSTRAINT Event_Unique_Date_Location UNIQUE KEY(location, date)
);

CREATE TABLE Attends (
  event_id  INTEGER   NOT NULL,
  member    VARCHAR(100)  NOT NULL,
  CONSTRAINT Attends_Event_FK FOREIGN KEY (event_id) REFERENCES Event(id),
  CONSTRAINT Attends_Member_FK FOREIGN KEY (member) REFERENCES Member(email)
);
