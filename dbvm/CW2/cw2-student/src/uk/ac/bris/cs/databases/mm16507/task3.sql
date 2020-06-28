use bb;

DROP TABLE IF EXISTS LikesPost;
DROP TABLE IF EXISTS LikesTopic;

DROP TABLE IF EXISTS Post;
DROP TABLE IF EXISTS Topic;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Forum;

CREATE TABLE Forum (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Person (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  username VARCHAR(10) NOT NULL UNIQUE,
  stuId VARCHAR(10) NULL
);

CREATE TABLE Topic (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  forumID INTEGER NOT NULL,
  title VARCHAR(100) NOT NULL,
  CONSTRAINT Topic_Forum_FK FOREIGN KEY (forumID) REFERENCES
  Forum(id),
  CONSTRAINT UC_ForumTitle UNIQUE (forumID, title)
);

CREATE TABLE Post (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  topicID INTEGER NOT NULL,
  topicPosition INTEGER NOT NULL,
  authorID INTEGER NOT NULL,
  content VARCHAR(2000) NOT NULL,
  time_posted TIMESTAMP NOT NULL,
  CONSTRAINT Post_Topic_FK FOREIGN KEY (topicID) REFERENCES Topic(id),
  CONSTRAINT Post_Person_FK FOREIGN KEY (authorID) REFERENCES Person(id)
);

CREATE TABLE LikesTopic (
  personID INTEGER NOT NULL,
  topicID INTEGER NOT NULL,
  CONSTRAINT Person_LikesTopic_FK FOREIGN KEY (personID) REFERENCES Person(id),
  CONSTRAINT Topic_LikesTopic_FK FOREIGN KEY (topicID) REFERENCES Topic(id),
  PRIMARY KEY (personID, topicID)
);

CREATE TABLE LikesPost (
  personID INTEGER NOT NULL,
  postID INTEGER NOT NULL,
  CONSTRAINT Person_LikesPost_FK FOREIGN KEY (personID) REFERENCES Person(id),
  CONSTRAINT Post_LikesPost_FK FOREIGN KEY (postID) REFERENCES Post(id),
  PRIMARY KEY (personID, postID)
);
