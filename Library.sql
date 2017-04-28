DROP TABLE taking;
DROP TABLE books;
DROP table	parents;
DROP TABLE classes;
DROP TABLE student;
DROP TABLE teacher;
DROP TABLE authorization;
DROP TABLE earlydue;


CREATE TABLE unversity_library.authorization(
authLevel INT,
title VARCHAR(50),
PRIMARY KEY (authLevel)
)ENGINE=InnoDB;

INSERT INTO unversity_library.authorization VALUES (0,'view');
INSERT INTO unversity_library.authorization VALUES (1,'admin');




CREATE TABLE unversity_library.teacher( 
authLevel int,
tID int,
teacherID int NOT NULL AUTO_INCREMENT,
    advisor  numeric(1,0),
    PRIMARY KEY (tID),
    KEY(teacherID),
    FOREIGN KEY (authLevel) REFERENCES unversity_library.authorization(authLevel)
)ENGINE=InnoDB;

INSERT INTO teacher (authLevel, tid,advisor) VALUES (1,1,0);
INSERT INTO teacher (authLevel,tid,advisor) VALUES (1,2,0);
INSERT INTO teacher (authLevel,tid,advisor) VALUES (1,3,1);
INSERT INTO teacher (authLevel,tid,advisor) VALUES (1,4,1);
INSERT INTO teacher (authLevel,tid,advisor) VALUES (1,5,0);

SELECT * FROM teacher;

CREATE TABLE unversity_library.student ( 
authlevel int DEFAULT 0, 
SID int,
studentID int AUTO_INCREMENT,
advisor INT,
	CONSTRAINT FK FOREIGN KEY (advisor) REFERENCES teacher(teacherID) ON DELETE SET NULL,
    PRIMARY KEY (SID),
    KEY(studentID),
FOREIGN KEY (authLevel) REFERENCES unversity_library.authorization(authLevel)
)ENGINE=InnoDB;



INSERT INTO student (authLevel,sid,advisor) VALUES (Null,1,3);
INSERT INTO student (authLevel,sid,advisor) VALUES (0,2,3);
INSERT INTO student (authLevel,sid,advisor) VALUES (0,3,3);
INSERT INTO student (authLevel,sid,advisor) VALUES (0,4,4);
INSERT INTO student (authLevel,sid,advisor) VALUES (0,5,4);


SELECT * FROM  student;




CREATE TABLE unversity_library.books (  
bookID int AUTO_INCREMENT,
BID int,
	ISBN  INT,
	fine INT,
	title CHAR(200),
    PRIMARY KEY (BID),
    KEY(bookID)
)ENGINE=InnoDB;



INSERT INTO books(bid,ISBN,fine,title) VALUES (1,123,100,'Manufacturing Consent');
INSERT INTO books(bid,ISBN,fine,title) VALUES (2,123,100,'Manufacturing Consent');
INSERT INTO books(bid,ISBN,fine,title) VALUES (3,321,150,'Chinese Fiction');
INSERT INTO books(bid,ISBN,fine,title) VALUES (4,321,150,'Chinese Fiction');
INSERT INTO books(bid,ISBN,fine,title) VALUES (5,987,15,'Database systems');
INSERT INTO books(bid,ISBN,fine,title) VALUES (6,987,15,'Database systems');
SELECT * FROM books;


CREATE TABLE unversity_library.classes ( 
classID int AUTO_INCREMENT,
CID int,
    PRIMARY KEY (cID),
    KEY(classid)
)ENGINE=InnoDB;

INSERT INTO classes(CID) VALUES(1) ;
INSERT INTO classes(CID) VALUES(2) ;
INSERT INTO classes(CID) VALUES(3) ;
INSERT INTO classes(CID) VALUES(4) ;
SELECT * FROM classes;


CREATE TABLE unversity_library.parents(
authlevel int, 
PID int,
parentID int AUTO_INCREMENT,
pname VARCHAR(30),
studentid INT,
contact NUMERIC(38,0),
  CONSTRAINT fk_column
    FOREIGN KEY (studentid)
    REFERENCES unversity_library.student (studentid)
    ON DELETE CASCADE,
    FOREIGN KEY (authLevel) REFERENCES authorization(authLevel),
PRIMARY KEY (pID),
KEY(parentID)
)ENGINE=InnoDB;



INSERT INTO parents(pid,authlevel,pname,studentid,contact) VALUES (1,Null,'Tim',1,3097508591);
INSERT INTO parents(pid,authlevel,pname,studentid,contact) VALUES (2,0,'Tat',1,3097508591);
INSERT INTO parents(pid,authlevel,pname,studentid,contact) VALUES (3,0,'Tick',2,3097509000);
INSERT INTO parents(pid,authlevel,pname,studentid,contact) VALUES (4,0,'Too',3,3097509111);
INSERT INTO parents(pid,authlevel,pname,studentid,contact) VALUES (5,Null,'Too',4,3097509111);

SELECT * FROM parents;




CREATE TABLE unversity_library.taking ( 
  sID INT, 
  cID  INT,
  bID  INT,
  due date,
  checkedOut date,
  
    CONSTRAINT CHECKSTUD
        FOREIGN KEY (sID) references unversity_library.student(sID)
        ON DELETE CASCADE,
        
    CONSTRAINT CHECKCLASS
        FOREIGN KEY (cID) references unversity_library.classes(cID)
        ON DELETE CASCADE,
        
    FOREIGN KEY (bID) references unversity_library.books(bID) ON DELETE CASCADE,
        
    PRIMARY KEY (bID)
)ENGINE=InnoDB;

INSERT INTO taking(sid,cid,bid,due,checkedout) VALUES (1,1,1,STR_TO_DATE('12/31/2011', '%m/%d/%Y'),STR_TO_DATE('12/31/2011', '%m/%d/%Y'));
INSERT INTO taking(sid,cid,bid,due,checkedout) VALUES (1,1,2,STR_TO_DATE('12/31/2011', '%m/%d/%Y'),STR_TO_DATE('12/31/2011', '%m/%d/%Y'));
INSERT INTO taking(sid,cid,bid,due,checkedout) VALUES (3,2,3,STR_TO_DATE('12/31/2011', '%m/%d/%Y'),STR_TO_DATE('12/31/2011', '%m/%d/%Y'));
INSERT INTO taking(sid,cid,bid,due,checkedout) VALUES (4,4,4,STR_TO_DATE('12/31/2011', '%m/%d/%Y'),STR_TO_DATE('12/31/2011', '%m/%d/%Y'));
SELECT * FROM taking;




CREATE TABLE earlydue( 
  sID INT, 
  cID  INT,
  bID  INT,
  due date,
  checkedOut date,
  PRIMARY KEY (bID))ENGINE = InnoDB;





SELECT 'teacher',tid,title FROM teacher, authorization
WHERE authorization.authlevel=teacher.authlevel AND authorization.title='admin'
UNION
SELECT 'student',sid,title FROM student, authorization
WHERE authorization.authlevel=student.authlevel AND authorization.title='view'
UNION
SELECT 'parent',pid,title FROM parents, authorization
WHERE authorization.authlevel=parents.authlevel AND authorization.title='view';


/*MODIFY BOOKS*/


	
/*DELETE FROM books 
where ISBN=123;
DELETE FROM books where bid=1;

UPDATE books
SET fine=10
WHERE ISBN =123;


UPDATE books
SET fine=10
WHERE BID =1;



UPDATE parents
SET authlevel=NULL
WHERE PID=1;

UPDATE parents
SET CONTACT=NULL
WHERE PID=1;

UPDATE parents
SET pname=NULL
WHERE PID=1;



DELETE FROM classes where cid=1;

DELETE FROM STUDENT where sid=1;

UPDATE student
SET authlevel=NULL
WHERE SID=1;



DELETE FROM teacher where tid=1;

UPDATE teacher
SET authlevel=Null
WHERE Tid=1;
*/

/*
delimiter #

create trigger trig BEFORE DELETE ON student
FOR EACH ROW BEGIN
DECLARE s int;
DECLARE c int;
DECLARE b int;
DECLARE d date;
DECLARE co date;
DECLARE i int;
SET i=1;
WHILE i<=(SELECT count(sid) FROM taking where SID=old.sid) DO
  SET s= (SELECT sid FROM taking where SID=old.sid LIMIT i,1);
  SET c= (SELECT cid FROM taking where SID=old.sid LIMIT i,1);
  SET b= (SELECT bid FROM taking where SID=old.sid LIMIT i,1);
  SET d= (SELECT due FROM taking where SID=old.sid LIMIT i,1);
  SET co= (SELECT checkedout FROM taking where SID=old.sid LIMIT i,1);
  INSERT INTO earlydue VALUES (s,c,b,d,co);
SET i=i+1;
END WHILE;
end#

delimiter ;
*/



/*



  


CREATE TABLE unversity_library.earlydue ( 
    studentid INT, 
    classid  INT,
    bkschid  CHAR(20),
	taken date,
    due date,
	fine int
);
DELIMITER $$
CREATE TRIGGER trig1
    BEFORE INSERT ON unversity_library.classes
    FOR EACH ROW 
BEGIN
    INSERT INTO unversity_library.classes(classid) VALUES (10);
END$$
DELIMITER ;

*/

/*
SELECT * FROM unversity_library.books;

SELECT * FROM unversity_library.books
WHERE bkschid IN (SELECT BKSCHID FROM unversity_library.taking);


SELECT * FROM unversity_library.taking
WHERE NOW()>due
ORDER BY studentid;

SELECT * FROM unversity_library.taking
WHERE NOW()>due and studentid IN (0,3);

SELECT sum(fine),studentid FROM unversity_library.taking
WHERE NOW()>due and studentid IN (0,3)
GROUP BY studentid;

*/




/*



SELECT * FROM unversity_library.taking;
DELETE FROM unversity_library.student 
WHERE studentid=0;


SELECT * FROM unversity_library.taking;
*/