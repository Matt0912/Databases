INSERT INTO RGroup (id, name) VALUES (81, 'Hardware');
INSERT INTO RGroup (id, name) VALUES (82, 'Software');

INSERT INTO Lecturer (id, name, username, office, rgroup) VALUES (31, 'Sarah', 'csxss', '1.5', 82);
INSERT INTO Lecturer (id, name, username, office, rgroup) VALUES (32, 'Charles', 'cscw', '0.3', 81);
INSERT INTO Lecturer (id, name, username, office, rgroup) VALUES (33, 'Peter', 'csxpd', '0.3', 81);
INSERT INTO Lecturer (id, name, username, office, rgroup) VALUES (34, 'Dominic', 'csxde', null, 81);
INSERT INTO Lecturer (id, name, username, office, rgroup) VALUES (35, 'Janet', 'csxjm', '1.5', 82);
INSERT INTO Lecturer (id, name, username, office, rgroup) VALUES (36, 'David', 'csxdb', '3.22', null);

INSERT INTO Unit (id, title, code, level, cp, director) VALUES (11, 'Databases', 'COMSM0016', 'M', 10, 36);
INSERT INTO Unit (id, title, code, level, cp, director) VALUES (12, 'Web Technologies', 'COMSM0104', 'M', 10, 34);
INSERT INTO Unit (id, title, code, level, cp, director) VALUES (13, 'Programming and Algorithms', 'COMS10001', '1', 20, 32);
INSERT INTO Unit (id, title, code, level, cp, director) VALUES (14, 'Computer Architecture', 'COMS20022', '2', 30, 31);
INSERT INTO Unit (id, title, code, level, cp, director) VALUES (15, 'Overview of Computer Architecture', 'COMSM1302', 'M', 20, 31);
INSERT INTO Unit (id, title, code, level, cp, director) VALUES (16, 'Security 101', 'COMS10005', '1', 10, 36);

-- The names are taken from 'Top 50 baby names 2016'.
-- The grade data is random.

INSERT INTO Student(id, name, username, cohort, grade) VALUES ( 1, 'Sophia',     'cs15120', 'MS50', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES ( 2, 'Jackson',    'cs15800', 'MS50', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES ( 3, 'Emma',       'cs15301', 'MS50', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES ( 4, 'Aiden',      'cs15846', 'MS50', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES ( 5, 'Olivia',     'cs15255', 'MS50', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES ( 6, 'Lucas',      'cs15910', 'MS50', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES ( 7, 'Ava',        'cs15336', 'MS50', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES ( 8, 'Liam',       'cs15656', 'MS50', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES ( 9, 'Mia',        'cs15603', 'MS50', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES (10, 'Noah',       'cs15241', 'MS50', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES (11, 'Isabella',   'cs15997', 'G400', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES (12, 'Ethan',      'cs15303', 'G400', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES (13, 'Riley',      'cs15892', 'G400', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES (14, 'Mason',      'cs15331', 'G400', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES (15, 'Aria',       'cs15650', 'G400', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES (16, 'Caden',      'cs15002', 'G410', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES (17, 'Zoe',        'cs15240', 'G410', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES (18, 'Oliver',     'cs15290', 'G410', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES (19, 'Charlotte',  'cs15878', 'G410', null);
INSERT INTO Student(id, name, username, cohort, grade) VALUES (20, 'Elijah',     'cs15315', 'G410', null);

-- random normal distribution of MSc grades.

INSERT INTO Enrol(student, unit, grade) VALUES (1, 11, 58);
INSERT INTO Enrol(student, unit, grade) VALUES (1, 12, 57);
INSERT INTO Enrol(student, unit, grade) VALUES (1, 15, 56);
INSERT INTO Enrol(student, unit, grade) VALUES (2, 11, 60);
INSERT INTO Enrol(student, unit, grade) VALUES (2, 12, 52);
INSERT INTO Enrol(student, unit, grade) VALUES (2, 15, 64);
INSERT INTO Enrol(student, unit, grade) VALUES (3, 11, 54);
INSERT INTO Enrol(student, unit, grade) VALUES (3, 12, 71);
INSERT INTO Enrol(student, unit, grade) VALUES (3, 15, 68);
INSERT INTO Enrol(student, unit, grade) VALUES (4, 11, 57);
INSERT INTO Enrol(student, unit, grade) VALUES (4, 12, 65);
INSERT INTO Enrol(student, unit, grade) VALUES (4, 15, 74);
INSERT INTO Enrol(student, unit, grade) VALUES (5, 11, 63);
INSERT INTO Enrol(student, unit, grade) VALUES (5, 12, 49);
INSERT INTO Enrol(student, unit, grade) VALUES (5, 15, 63);
INSERT INTO Enrol(student, unit, grade) VALUES (6, 11, 58);
INSERT INTO Enrol(student, unit, grade) VALUES (6, 12, 69);
INSERT INTO Enrol(student, unit, grade) VALUES (6, 15, 58);
INSERT INTO Enrol(student, unit, grade) VALUES (7, 11, 62);
INSERT INTO Enrol(student, unit, grade) VALUES (7, 12, 69);
INSERT INTO Enrol(student, unit, grade) VALUES (7, 15, 48);
INSERT INTO Enrol(student, unit, grade) VALUES (8, 11, 73);
INSERT INTO Enrol(student, unit, grade) VALUES (8, 12, 69);
INSERT INTO Enrol(student, unit, grade) VALUES (8, 15, 57);
INSERT INTO Enrol(student, unit, grade) VALUES (9, 11, 61);
INSERT INTO Enrol(student, unit, grade) VALUES (9, 12, 46);
INSERT INTO Enrol(student, unit, grade) VALUES (9, 15, 74);
INSERT INTO Enrol(student, unit, grade) VALUES (10, 11, 60);
INSERT INTO Enrol(student, unit, grade) VALUES (10, 12, 67);
INSERT INTO Enrol(student, unit, grade) VALUES (10, 15, 55);

UPDATE Student s SET s.grade = (
   (20 * (SELECT e.grade FROM Enrol e WHERE s.id = e.student AND e.unit = 15) +
    10 * (SELECT e.grade FROM Enrol e WHERE s.id = e.student AND e.unit = 11) +
    10 * (SELECT e.grade FROM Enrol e WHERE s.id = e.student AND e.unit = 12))
   / 40
) WHERE s.cohort = 'MS50';

-- Security and programming grades.
INSERT INTO Enrol (student, unit, grade) values (11, 16, 63);
INSERT INTO Enrol (student, unit, grade) values (12, 16, 65);
INSERT INTO Enrol (student, unit, grade) values (13, 16, 62);
INSERT INTO Enrol (student, unit, grade) values (14, 16, 71);
INSERT INTO Enrol (student, unit, grade) values (15, 16, 63);

INSERT INTO Enrol (student, unit, grade) values (11, 13, null);
INSERT INTO Enrol (student, unit, grade) values (12, 13, null);
INSERT INTO Enrol (student, unit, grade) values (13, 13, null);
INSERT INTO Enrol (student, unit, grade) values (14, 13, null);
INSERT INTO Enrol (student, unit, grade) values (15, 13, null);
