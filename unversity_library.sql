DROP table unversity_library.teacher;
DROP table unversity_library.student;

DROP table unversity_library.books;
DROP table unversity_library.classes;

DROP table unversity_library.parents;
DROP table unversity_library.taking;

DROP table unversity_library.earlydue;


CREATE TABLE unversity_library.teacher ( 
autoID int NOT NULL AUTO_INCREMENT,
    teacherid   INT,
   teacheruid INT,
    authorized CHAR(20),
    advisor  numeric(1,0),
    PRIMARY KEY (teacheruid),
    KEY(autoID)
);


CREATE TABLE unversity_library.student ( 
autoID int AUTO_INCREMENT,
    studentid INT,
    authorized CHAR(20),
    advisor INT,
    FOREIGN KEY (advisor) REFERENCES teacher(teacheruid),
    PRIMARY KEY (studentid),
   KEY(autoID)
);



/*CREATE ASSERTION checking if advisor is allowed to be an advisor*/



CREATE TABLE unversity_library.books (  
autoID int AUTO_INCREMENT,
	bkschid CHAR(20),
	ISBN  INT,
	fine INT,
	title CHAR(200),
    PRIMARY KEY (bkschid,fine),
    KEY(autoID)
);




/*CREATE ASSERTION FOR BOOKS ABOUT title vs isbn*/




CREATE TABLE unversity_library.classes ( 
autoID int AUTO_INCREMENT,
    classid  INT,
    PRIMARY KEY (classid),
    KEY(autoID)
);





CREATE TABLE unversity_library.parents(
autoID int AUTO_INCREMENT,
ParentID INT,
pname CHAR(30),
studentid INT,
contact NUMERIC(38,2),
authorized CHAR(30),
  CONSTRAINT fk_column
    FOREIGN KEY (studentid)
    REFERENCES student (studentid)
    ON DELETE CASCADE,
KEY(autoID)
);








CREATE TABLE unversity_library.taking ( 
    studentid INT, 
    classid  INT,
    bkschid  CHAR(20),
	taken date,
    due date,
	fine int,
    
        FOREIGN KEY (studentid) references student(studentid)
        ON DELETE CASCADE,
        
        FOREIGN KEY (classid) references classes(classid)
        ON DELETE CASCADE,
        
    FOREIGN KEY (bkschid,fine) references books,
        
    PRIMARY KEY (studentid,classid,bkschid)
);




CREATE TABLE unversity_library.earlydue ( 
    studentid INT, 
    classid  INT,
    bkschid  CHAR(20),
	taken date,
    due date,
	fine int
);



  
/*-------------------------------ALL INSERTIONS OF DATA AND VALUES----------------------------------*/
INSERT INTO unversity_library.teacher(teacherid,teacheruid,authorized,advisor) values (100,000,'teacher',1);
INSERT INTO unversity_library.teacher(teacherid,teacheruid,authorized,advisor)values (200,001,null,1);
INSERT INTO unversity_library.teacher(teacherid,teacheruid,authorized,advisor) values (300,002,'teacher',0);
INSERT INTO unversity_library.teacher(teacherid,teacheruid,authorized,advisor)values (400,003,null,0);

INSERT INTO unversity_library.student(studentid,authorized,advisor) values (00,'student',000);
INSERT INTO unversity_library.student(studentid,authorized,advisor) values (01,'student',001);
INSERT INTO unversity_library.student(studentid,authorized,advisor) values (02,'student',001);
INSERT INTO unversity_library.student(studentid,authorized,advisor) values (03,null,000);

INSERT INTO unversity_library.books(bkschid,ISBN,fine,title) values ('B1',123456,100,'Manufacturing Consent');
INSERT INTO unversity_library.books(bkschid,ISBN,fine,title)values ('B2',123456,100,'Manufacturing Consent');
INSERT INTO unversity_library.books(bkschid,ISBN,fine,title) values ('B3',120000,50,'Divine Speech');
INSERT INTO unversity_library.books(bkschid,ISBN,fine,title) values ('B4',120000,50,'Divine Speech');
INSERT INTO unversity_library.books(bkschid,ISBN,fine,title) values ('B4a',100000,100,'The China Study');
INSERT INTO unversity_library.books(bkschid,ISBN,fine,title) values ('B4b',200000,5,'Database Systems');

INSERT INTO unversity_library.classes(classid) VALUES (1);
INSERT INTO unversity_library.classes(classid) VALUES (2);
INSERT INTO unversity_library.classes(classid) VALUES (3);
INSERT INTO unversity_library.classes(classid) VALUES (4);

INSERT INTO unversity_library.parents(ParentID,pname,studentid,contact,authorized) VALUES (101,'Tom',00,2222222222,'parent');
INSERT INTO unversity_library.parents(ParentID,pname,studentid,contact,authorized) VALUES (202,'Kate',00,2222222222,'parent');
INSERT INTO unversity_library.parents(ParentID,pname,studentid,contact,authorized) VALUES (303,'Mat',01, 3333333333,'parent');
INSERT INTO unversity_library.parents(ParentID,pname,studentid,contact,authorized) VALUES (404,'Xing',02,4444444444,'parent');
INSERT INTO unversity_library.parents(ParentID,pname,studentid,contact,authorized) VALUES (404,'Xing',03,4444444444,'parent');
INSERT INTO unversity_library.parents(ParentID,pname,studentid,contact,authorized) VALUES (606,'Carlos',03,5555555555,null);

INSERT INTO unversity_library.taking(studentid,classid,bkschid,taken,due,fine) VALUES(0,1,'b1',str_to_date("30/06/2017","%d/%m/%Y"),str_to_date("30/06/2015","%d/%m/%Y"),100);
INSERT INTO unversity_library.taking(studentid,classid,bkschid,taken,due,fine) VALUES(0,2,'b2',str_to_date("30/06/2017","%d/%m/%Y"),str_to_date("30/06/2015","%d/%m/%Y"),100);
INSERT INTO unversity_library.taking(studentid,classid,bkschid,taken,due,fine) VALUES(1,1,'b1',str_to_date("30/06/2017","%d/%m/%Y"),str_to_date("30/06/2015","%d/%m/%Y"),100);
INSERT INTO unversity_library.taking(studentid,classid,bkschid,taken,due,fine) VALUES(1,2,'b2',str_to_date("30/06/2017","%d/%m/%Y"),str_to_date("30/06/2017","%d/%m/%Y"),100);
INSERT INTO unversity_library.taking(studentid,classid,bkschid,taken,due,fine) VALUES(2,3,'b3',str_to_date("30/06/2017","%d/%m/%Y"),str_to_date("30/06/2015","%d/%m/%Y"),50);
INSERT INTO unversity_library.taking(studentid,classid,bkschid,taken,due,fine) VALUES(3,3,'b3',str_to_date("30/06/2017","%d/%m/%Y"),str_to_date("30/06/2017","%d/%m/%Y"),50);
INSERT INTO unversity_library.taking(studentid,classid,bkschid,taken,due,fine) VALUES(3,4,'b4',str_to_date("30/06/2017","%d/%m/%Y"),str_to_date("30/06/2017","%d/%m/%Y"),50);
INSERT INTO unversity_library.taking(studentid,classid,bkschid,taken,due,fine) VALUES(3,4,'b4a',str_to_date("30/06/2017","%d/%m/%Y"),str_to_date("30/06/2017","%d/%m/%Y"),100);
INSERT INTO unversity_library.taking(studentid,classid,bkschid,taken,due,fine) VALUES(3,4,'b4b',str_to_date("30/06/2017","%d/%m/%Y"),str_to_date("30/06/2015","%d/%m/%Y"),5);

/*
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
CREATE TRIGGER unversity_library.trig 
AFTER DELETE ON unversity_library.taking
FOR EACH ROW
    INSERT INTO unversity_library.earlydue SELECT deleted.studentid,deleted.classid,deleted.bkschid,deleted.taken, NULL, fine FROM deleted;


SELECT * FROM unversity_library.taking;
DELETE FROM unversity_library.student 
WHERE studentid=0;


SELECT * FROM unversity_library.taking;
*/