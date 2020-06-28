/* mysql data < /vagrant/CW2/cw2-student/src/uk/ac/bris/cs/databases/mm16507/task3.sql
mysql data < /vagrant/CW2/cw2-student/src/uk/ac/bris/cs/databases/cwk2/dummyData.sql */

/* SQL Query for getForum - name keeps returning null
WITH Count AS
  (SELECT count(1) as c, name, forumID FROM Topic
  RIGHT JOIN Forum ON Forum.id = forumID
  WHERE forumID = 1)
  SELECT Count.c as c, Count.name as name, Topic.id as topicID, title FROM Topic
  LEFT JOIN Forum ON Forum.id = Topic.forumID
  RIGHT JOIN Count ON Forum.id = Count.forumID;
  */


use bb;

INSERT INTO Person(name, username, stuId) VALUES ("Matt", "mm16507", "1637077");
INSERT INTO Person(name, username, stuId) VALUES ("Georgia", "gm19870", "1864571");
INSERT INTO Person(name, username, stuId) VALUES ("Bob", "bb16230", "1234567");
INSERT INTO Person(name, username, stuId) VALUES ("testing", "tr1337", "0000000");

INSERT INTO Forum(name) VALUES ("How to create basic websites!");
INSERT INTO Forum(name) VALUES ("Why won't my code compile?");
INSERT INTO Forum(name) VALUES ("Java Questions Hub");

INSERT INTO Topic(forumID, title) VALUES (1,"Intro to HTML");
INSERT INTO Topic(forumID, title) VALUES (1, "Intro to CSS");
INSERT INTO Topic(forumID, title) VALUES (1, "JavaScript Help?");
INSERT INTO Topic(forumID, title) VALUES (2, "C Help");
INSERT INTO Topic(forumID, title) VALUES (3, "What is an Interface?");
INSERT INTO Topic(forumID, title) VALUES (3, "Object-Oriented Programming");


INSERT INTO Post(topicID, topicPosition, authorID, content)
VALUES (1, 1, 1, "Keep getting weird errors when running HTML code???");
INSERT INTO Post(topicID, topicPosition, authorID, content)
VALUES (1, 2, 3, "Have you tried another browser?");
INSERT INTO Post(topicID, topicPosition, authorID, content)
VALUES (2, 1, 1, "CSS code help");
INSERT INTO Post(topicID, topicPosition, authorID, content)
VALUES (3, 1, 2, "Where do I download JavaScript?");
INSERT INTO Post(topicID, topicPosition, authorID, content)
VALUES (4, 1, 2, "I'm here to help anyone with C");
INSERT INTO Post(topicID, topicPosition, authorID, content)
VALUES (5, 1, 3, "I don't know what an interface is???");
INSERT INTO Post(topicID, topicPosition, authorID, content)
VALUES (6, 1, 4, "What is OOP?");


INSERT INTO LikesTopic(personID, topicID) VALUES (1,1);
INSERT INTO LikesTopic(personID, topicID) VALUES (1,5);
INSERT INTO LikesTopic(personID, topicID) VALUES (1,2);
INSERT INTO LikesTopic(personID, topicID) VALUES (1,3);
INSERT INTO LikesTopic(personID, topicID) VALUES (1,4);

INSERT INTO LikesPost(personID, postID) VALUES (1,7);
INSERT INTO LikesPost(personID, postID) VALUES (1,5);
INSERT INTO LikesPost(personID, postID) VALUES (1,4);
INSERT INTO LikesPost(personID, postID) VALUES (1,6);
INSERT INTO LikesPost(personID, postID) VALUES (1,1);
