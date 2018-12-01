-- trigger when user post more than 10 articles within 10 minutes.
DROP TRIGGER IF EXISTS over_post; 
delimiter //
CREATE TRIGGER over_post AFTER INSERT ON posts
FOR EACH ROW 
BEGIN 
	IF 	EXISTS(SELECT userID
		FROM (SELECT userID, COUNT(*) as tmpcount FROM posts 
				WHERE userID = NEW.userID AND 
				TIME_TO_SEC(postTime) + 600 < TIME_TO_SEC(NEW.postTime)) posts_alias
		WHERE tmpcount > 10)
	THEN 
	INSERT INTO suspectedUser(userID)
	VALUES (NEW.userID);
    END IF;
END;//
delimiter ;

-- insert registerDate when new user registerd.
DROP TRIGGER IF EXISTS user_registerDate;
delimiter //
CREATE TRIGGER user_registerDate BEFORE INSERT ON bbsUser
FOR EACH ROW
BEGIN 
	SET NEW.registerDate = NOW();
END;//
delimiter ;

-- update clickNum and replyNum and lastRepliedTime when replys
DROP TRIGGER IF EXISTS click_update;
delimiter //
CREATE TRIGGER click_update AFTER INSERT ON replys
FOR EACH ROW
BEGIN
	UPDATE posts a
    SET a.clickNum = a.clickNum + 1, a.replyNum = a.replyNum + 1, lastRepliedTime = NOW()
    WHERE a.postID = NEW.postID;
END;//
delimiter ;

-- set floorNum after insert replys
DROP TRIGGER IF EXISTS set_floor;
delimiter //
CREATE TRIGGER set_floor BEFORE INSERT ON replys
FOR EACH ROW
BEGIN
	SET NEW.floorNum = (SELECT replyNum FROM posts WHERE postID = NEW.postID) + 1;
END;//
delimiter ;

-- update replyNum after delete on replys
DROP TRIGGER IF EXISTS replyNum_update;
delimiter //
CREATE TRIGGER replyNum_update AFTER DELETE ON replys
FOR EACH ROW
BEGIN
	UPDATE posts a
    SET a.replyNum = a.replyNum - 1
    WHERE a.postID = OLD.postID;
END; //
delimiter ;
