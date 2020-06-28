package uk.ac.bris.cs.databases.cwk2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.Instant;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import uk.ac.bris.cs.databases.api.APIProvider;
import uk.ac.bris.cs.databases.api.ForumSummaryView;
import uk.ac.bris.cs.databases.api.ForumView;
import uk.ac.bris.cs.databases.api.Result;
import uk.ac.bris.cs.databases.api.PersonView;
import uk.ac.bris.cs.databases.api.SimplePostView;
import uk.ac.bris.cs.databases.api.SimpleTopicSummaryView;
import uk.ac.bris.cs.databases.api.TopicView;

public class API implements APIProvider {

    private final Connection c;

    public API(Connection c) {
        this.c = c;
    }

    /* predefined methods */

    @Override
    public Result<Map<String, String>> getUsers() {
        try (Statement s = c.createStatement()) {
            ResultSet r = s.executeQuery("SELECT name, username FROM Person");

            Map<String, String> data = new HashMap<>();
            while (r.next()) {
                data.put(r.getString("username"), r.getString("name"));
            }

            return Result.success(data);
        } catch (SQLException ex) {
            return Result.fatal("database error - " + ex.getMessage());
        }
    }

    @Override
    public Result addNewPerson(String name, String username, String studentId) {
        /** Check entered strings are valid */
        if (studentId != null && studentId.equals("")) {
            return Result.failure("StudentId can be null, but cannot be the empty string.");
        }
        if (name == null || name.equals("")) {
            return Result.failure("Name cannot be empty.");
        }
        if (username == null || username.equals("")) {
            return Result.failure("Username cannot be empty.");
        }
        if (name.length() > 100) {
            return Result.failure("Entered name is too long: 100 characters max");
        }
        if (username.length() > 10) {
            return Result.failure("Entered username is too long: 10 characters max");
        }
        if (studentId.length() > 10) {
            return Result.failure("Entered student ID is too long: 10 numbers max");
        }


        try (PreparedStatement p = c.prepareStatement(
            "SELECT count(1) AS c FROM Person WHERE username = ?"
        )) {
            p.setString(1, username);
            ResultSet r = p.executeQuery();

            if (r.next() && r.getInt("c") > 0) {
                return Result.failure("A user called " + username + " already exists.");
            }
        } catch (SQLException e) {
            return Result.fatal(e.getMessage());
        }

        try (PreparedStatement p = c.prepareStatement(
            "INSERT INTO Person (name, username, stuId) VALUES (?, ?, ?)"
        )) {
            p.setString(1, name);
            p.setString(2, username);
            p.setString(3, studentId);
            p.executeUpdate();

            c.commit();
        } catch (SQLException e) {
            return rollbackSQL(e);
        }

        return Result.success();
    }

    /* level 1 */

    @Override
    public Result<PersonView> getPersonView(String username) {
        if (username == null || username.equals("")) {
            return Result.failure("Name cannot be empty.");
        }

        try (PreparedStatement p = c.prepareStatement(
                "SELECT count(1) as c, name, stuId FROM Person WHERE username = ?"
        )) {
            p.setString(1, username);
            ResultSet r = p.executeQuery();

            if (!r.next() || r.getInt("c") == 0) {
                return Result.failure("A user called " + username + " doesn't exist.");
            }
            else {
                String name = r.getString("name");
                String stuID = r.getString("stuId");

                PersonView userView = new PersonView(name, username, stuID);
                return Result.success(userView);
            }
        } catch (SQLException e) {
            return Result.fatal(e.getMessage());
        }
    }


    /*
     * 2 Forums only (no topics needed yet).
     * Create some sample data in your database manually to test getForums.
     * Then you can implement createForum and check that the two work together.
     */
    @Override
    public Result<List<ForumSummaryView>> getForums() {

        try (Statement s = c.createStatement()) {
            ResultSet r = s.executeQuery("SELECT id, name FROM Forum");
            List<ForumSummaryView> forumViews = new ArrayList<>();

            while (r.next()) {
                forumViews.add(new ForumSummaryView(r.getInt("id"), r.getString("name")));
            }

            return Result.success(forumViews);
        } catch (SQLException ex) {
            return Result.fatal("database error - " + ex.getMessage());
        }
    }


    @Override
    public Result<Integer> countPostsInTopic(int topicId) {
        try (PreparedStatement p = c.prepareStatement(
                "SELECT count(1) as c FROM Post WHERE topicID = ?;"))
        {
            p.setString(1, String.valueOf(topicId));
            ResultSet r = p.executeQuery();

            if (r.next()) {
                int numPosts = r.getInt("c");
                return Result.success(numPosts);
            }
            return Result.fatal("Unable to find number of posts in topic");
        }
        catch (SQLException ex) {
            return Result.fatal("database error - " + ex.getMessage());
        }
    }


    @Override
    public Result<TopicView> getTopic(int topicID) {

        try (PreparedStatement p = c.prepareStatement(
                " SELECT Topic.title as title, Post.topicPosition as postPosition, " +
                        "Person.username AS author, content, time_posted " +
                        "FROM Topic JOIN Post ON Topic.id = topicID " +
                        "JOIN Person ON Post.authorID = Person.id " +
                        "WHERE Topic.id = ?"))
        {
            p.setString(1, String.valueOf(topicID));
            ResultSet r = p.executeQuery();

            String title = null;
            List<SimplePostView> posts = new ArrayList<>();

            while (r.next()) {
                title = r.getString("title");
                int postPosition = r.getInt("postPosition");
                String author = r.getString("author");
                String content = r.getString("content");
                String timeStamp = r.getString("time_posted");
                timeStamp = timeStamp.substring(0, timeStamp.length() -2);
                posts.add(new SimplePostView(postPosition, author, content, timeStamp));
            }

            TopicView newTopic = new TopicView(topicID, title, posts);

            return Result.success(newTopic);
        }
        catch (SQLException ex) {
            return Result.fatal("database error - " + ex.getMessage());
        }
    }


    /* level 2 */

    @Override
    public Result createForum(String title) {
        /** Check title name is valid */
        if (title == null || title.equals("")) {
            return Result.failure("Forum title cannot be empty.");
        }
        if (title.length() > 100) {
            return Result.failure("Entered title is too long: 100 characters max");
        }

        /** Check if forum with this name already exists */
        try (PreparedStatement p = c.prepareStatement(
                "SELECT count(1) AS c FROM Forum WHERE name = ?"
        )) {
            p.setString(1, title);
            ResultSet r = p.executeQuery();

            if (r.next() && r.getInt("c") > 0) {
                return Result.failure("A forum called " + title + " already exists.");
            }

        } catch (SQLException e) {
            return Result.fatal(e.getMessage());
        }

        /** Insert new forum in to database */
        try (PreparedStatement p = c.prepareStatement(
                "INSERT INTO Forum(name) VALUES (?)"
        )) {
            p.setString(1, title);
            p.executeUpdate();

            c.commit();
        } catch (SQLException e) {
            return rollbackSQL(e);
        }

        return Result.success();
    }


    @Override
    /**
     * Structure of this function looks confusing, but is designed to be only SQL query if a forum
     * contains topics (the most likely case), and 2 queries if a forum is empty (less likely).
     */
    public Result<ForumView> getForum(int forumID) {
        /** This data can be retrieved with one statement which works in MySQL, but kept returning
         *  null when used here (@see commented code below function), so instead
         *  I've used 2 statements
         */

        /** Try and retrieve forum name and all topics */
        try (PreparedStatement p = c.prepareStatement(
                "SELECT Forum.name, Topic.id, Topic.title " +
                        "FROM Forum JOIN Topic ON Forum.id = forumID " +
                        "WHERE forumID = ?;"
                )) {
            p.setString(1, String.valueOf(forumID));
            ResultSet r = p.executeQuery();

            List<SimpleTopicSummaryView> topics = new ArrayList<>();
            String forumName = null;

            /** If Forum is empty, no results show but still need to get the forum name */
            if (!r.isBeforeFirst()) {
                try {
                    forumName = getForumName(forumID);
                } catch (SQLException e) {
                    return Result.fatal("database error - " + e.getMessage());
                }
            }

            /** If forum has topics, iterate through and add them to a topic view */
            else {
                while (r.next()) {
                    forumName = r.getString("Forum.name");
                    int topicID = r.getInt("Topic.id");
                    String topicName = r.getString("Topic.title");
                    topics.add(new SimpleTopicSummaryView(topicID, forumID, topicName));
                }
            }

            if (forumName == null) {
                return Result.failure("Error - Couldn't find forum");
            }

            ForumView forum = new ForumView(forumID, forumName, topics);
            return Result.success(forum);
        }
        catch (SQLException ex) {
            return Result.fatal("database error - " + ex.getMessage());
        }
    }

    /** SINGLE QUERY FOR getForum() - WORKS IN MYSQL BUT NOT WHEN JDBC CALLS IT
     * "WITH Count AS " +
     *      "(SELECT count(1) as c, name, forumID FROM Topic " +
     *      "RIGHT JOIN Forum ON Forum.id = forumID WHERE forumID = ?) " +
     *      "SELECT Count.c as c, Count.name as name, " +
     *      "Topic.id as topicID, title FROM Topic " +
     *      "LEFT JOIN Forum ON Forum.id = Topic.forumID " +
     *      "RIGHT JOIN Count ON Forum.id = Count.forumID;"
    */


    @Override
    public Result createPost(int topicId, String username, String text) {
        if (text == null || text.equals("")) {
            return Result.failure("Post content cannot be empty.");
        }
        if (username == null || username.equals("")) {
            return Result.failure("Post author's username cannot be empty.");
        }

        if (text.length() > 2000) {
            return Result.failure("Entered content is too long: 2000 characters max");
        }

        int userID;
        /** Check if username and topicID both exist */
        try (PreparedStatement p = c.prepareStatement(
                "SELECT " +
                        "EXISTS (SELECT * FROM Topic " +
                        "WHERE Topic.id = ?) AS topic_found, " +
                        "id as userID FROM Person " +
                        "WHERE username = ?;"
        )) {
            p.setString(1, String.valueOf(topicId));
            p.setString(2, username);
            ResultSet r = p.executeQuery();

            if (r.next()) {
                if (r.getInt("topic_found") == 0) {
                    return Result.failure("Unable to find topic " + topicId);
                }
                userID = r.getInt("userID");
            }
            else {
                return Result.failure("Unable to find id for username " + username);
            }
        } catch (SQLException e) {
            return Result.fatal(e.getMessage());
        }


        /** Insert new post in to database */
        try (PreparedStatement p = c.prepareStatement(
                "INSERT INTO Post (topicID, topicPosition, authorID, content) " +
                        "VALUES (?, ?, ?, ?);"
        )) {
            int postPosition = countPostsInTopic(topicId).getValue();
            p.setString(1, String.valueOf(topicId));
            p.setString(2, String.valueOf(postPosition + 1));
            p.setString(3, String.valueOf(userID));
            p.setString(4, text);
            p.executeUpdate();

            c.commit();
        } catch (SQLException e) {
            return rollbackSQL(e);
        }

        return Result.success();
    }


    /* level 3 */
    @Override
    public Result createTopic(int forumId, String username, String title, String text) {
        /** Check title and text aren't null and are a valid length */
        if (title == null || title.equals("")) {
            return Result.failure("Forum title cannot be empty.");
        }
        if (text == null || text.equals("")) {
            return Result.failure("Post content cannot be empty.");
        }
        if (text.length() > 2000) {
            return Result.failure("Entered content is too long: 2000 characters max");
        }
        if (title.length() > 100) {
            return Result.failure("Entered title is too long: 100 characters max");
        }

        /** Check if username and forum exist, and if the forum already has a
        *   topic with the new name */
        try (PreparedStatement p = c.prepareStatement(
                "SELECT  " +
                        "EXISTS (SELECT * FROM Person " +
                        "WHERE username = ?) AS username_found, " +
                        "EXISTS (SELECT * FROM Forum " +
                        "WHERE Forum.id = ?) AS forum_found, " +
                        "EXISTS (SELECT * FROM Topic " +
                        "WHERE forumID = ? AND title = ?) AS forumtitle_found;"
        )) {
            p.setString(1, username);
            p.setString(2, String.valueOf(forumId));
            p.setString(3, String.valueOf(forumId));
            p.setString(4, title);
            ResultSet r = p.executeQuery();

            if (r.next()) {
                if (r.getInt("username_found") == 0 || r.getInt("forum_found") == 0) {
                    return Result.failure("Unable to find Forum " + forumId + " or user " + username);
                }
                if (r.getInt("forumtitle_found") > 0) {
                    return Result.failure("Topic name already exists in this forum - choose another name");
                }
            }
        } catch (SQLException e) {
            return Result.fatal(e.getMessage());
        }

        /** Insert new topic in to database */
        try (PreparedStatement p = c.prepareStatement(
                "INSERT INTO Topic(forumID, title) VALUES (?,?);"
        )) {
            p.setString(1, String.valueOf(forumId));
            p.setString(2, title);
            p.executeUpdate();

            c.commit();
        } catch (SQLException e) {
            return rollbackSQL(e);
        }

        /** Get Topic.id of the newly created topic */
        int topicId = getTopicID(forumId, title);

        if (topicId == -1) {
            return Result.fatal("Database error - unable to find newly created topic");
        }

        return createPost(topicId, username, text);
    }

    /**
     * Function to handle rolling back after SQLException on INSERT command
     * @param e - The exception being handled
     * @return - Result of rollback - if doesn't work, return rollback error,
     * if it does rollback, return original SQLException message
     */
    private Result rollbackSQL(SQLException e) {
        try {
            c.rollback();
        } catch (SQLException f) {
            return Result.fatal("SQL error on rollback - [" + f +
                    "] from handling exception " + e);
        }
        return Result.fatal(e.getMessage());
    }


    /**
     * Function to return topic id
     * @param forumID - the forum to check.
     * @param topicName - the name of the topic to search for.
     * @return The id of the topic with 'topicName' in the specified forum (topicName
     * should be unique within each forum according to schema), return -1 if topic
     * doesn't exist
     *
     * Used by: /createTopic
     */
    private Integer getTopicID(int forumID, String topicName) {
        ForumView forum = getForum(forumID).getValue();
        for (SimpleTopicSummaryView topic : forum.getTopics()) {
            if (topic.getTitle().equals(topicName)) {
                return topic.getTopicId();
            }
        }
        return -1;
    }


    /**
     * Function to return forum name
     * @param forumID - the forum to search for
     * @return The name of the forum with id = 'forumID', throws
     * failure if no forum is found
     *
     * Used by: /getForum
     */
    private String getForumName(int forumID) throws SQLException {
        String forumName = null;
        PreparedStatement p = c.prepareStatement(
                "SELECT name FROM Forum " +
                        "WHERE Forum.id = ?;"
        );
        p.setString(1, String.valueOf(forumID));
        ResultSet r = p.executeQuery();

        if (r.next()) {
            forumName = r.getString("name");
        }

        p.close();
        return forumName;
    }

}
