USE bbs;
-- clickNum Top 10
CREATE VIEW topClick AS
SELECT * FROM posts a
WHERE (SELECT COUNT(*) FROM posts WHERE clickNum > a.clickNum) < 10
ORDER BY a.clickNum desc, a.postID;

-- replyNum Top 10
CREATE VIEW topReply AS
SELECT * FROM posts a
WHERE (SELECT COUNT(*) FROM posts WHERE replyNum > a.replyNum) < 10
ORDER BY a.replyNum desc, a.postID;

-- user posted in a specific section.
CREATE VIEW userPostBySection AS
SELECT DISTINCT b.*, a.* FROM bbsUser a NATURAL JOIN section b NATURAL JOIN posts
ORDER BY sectionName desc, (SELECT COUNT(*) FROM posts NATURAL JOIN section WHERE userID = a.userID AND sectionID = b.sectionID) desc;

CREATE VIEW userReplyBySection AS
SELECT DISTINCT b.*, a.* FROM bbsUser a NATURAL JOIN section b NATURAL JOIN posts
ORDER BY sectionName desc, (SELECT COUNT(*) FROM replys, posts NATURAL JOIN section WHERE replys.userID = a.userID AND replys.postID = posts.postID AND sectionID = b.sectionID) desc;

--  hottest posts in section.
CREATE VIEW hotPostBySection AS
SELECT sectionName, a.*, nickname, (TIME_TO_SEC(a.lastRepliedTime) - TIME_TO_SEC(a.postTime)) interTime  
FROM bbsUser NATURAL JOIN section NATURAL JOIN posts a
WHERE a.lastRepliedTime IS NOT NULL 
AND NOT EXISTS(SELECT * FROM posts WHERE sectionID = a.sectionID AND 
		lastRepliedTime IS NOT NULL AND 
		TIME_TO_SEC(lastRepliedTime) - TIME_TO_SEC(postTime) > 
        TIME_TO_SEC(a.lastRepliedTime) - TIME_TO_SEC(a.postTime));

-- clickNum above average in section.
CREATE VIEW clickAboveAvg AS
SELECT b.sectionName, a.postID, a.title, a.clickNum FROM posts a NATURAL JOIN section b
WHERE a.clickNum > (SELECT AVG(clickNum) FROM posts WHERE sectionID = b.sectionID)
ORDER BY sectionName desc, a.clickNum desc, a.postID;

-- replyNum above average in section.
CREATE VIEW replyAboveAvg AS
SELECT sectionName, userID, nickname FROM bbsUser a NATURAL JOIN section b
WHERE (SELECT COUNT(DISTINCT r_1.replyID) FROM bbsUser u_1 NATURAL JOIN replys r_1, posts p_1
	  WHERE u_1.userID = a.userID AND b.sectionID = p_1.sectionID AND p_1.postID = r_1.postID) *
      (SELECT COUNT(DISTINCT u_3.userID) FROM bbsUser u_3 NATURAL JOIN replys r_3, posts p_3
	  WHERE p_3.postID = r_3.postID AND b.sectionID = p_3.sectionID) >
      (SELECT COUNT(DISTINCT r_2.replyID) FROM bbsUser u_2 NATURAL JOIN replys r_2, posts p_2
	  WHERE p_2.postID = r_2.postID AND b.sectionID = p_2.sectionID)
ORDER BY sectionName desc, userID;

-- user who posts more in section A than in section B. Implemented in JSP code.


