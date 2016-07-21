/************************************/
/* Program: module3a_db_create.sql */
/* Author: Eric Gates  */
/* Date Created: 10-JUL-2017 */
/* Last Updated: 16-JUL-2017/Eric Gates */
/* Requested By: Benjamin Fruchter SUNY Empire State College */
/* Purpose: */
/* For Module 3a: Create database and populate with initial data. */
/* I/O: None */
/************************************/

-- setup terminal session
-- set termout on
prompt Building tables. Please wait.
-- set termout off
-- set feedback on

-- find out what these do
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
ALTER SESSION SET NLS_TERRITORY = AMERICA;

--programenrollment table
DROP TABLE programenrollment CASCADE CONSTRAINTS;
CREATE TABLE programenrollment
(enrollmentStatusID VARCHAR2(10) NOT NULL
,enrollmentStatus VARCHAR2(20)
,CONSTRAINT programenrollment_PK PRIMARY KEY(enrollmentStatusID)
);

--person table
DROP TABLE person CASCADE CONSTRAINTS;
CREATE TABLE person
(personID VARCHAR2(10) NOT NULL
,firstName VARCHAR2(20)
,middleName VARCHAR2(20)
,lastname VARCHAR2(20)
,officeTelephone NUMBER(9)
,officeNumber VARCHAR2(7)
,CONSTRAINT person_PK PRIMARY KEY(personID)
);

--faculty table
DROP TABLE faculty CASCADE CONSTRAINTS;
CREATE TABLE faculty
(facultyID VARCHAR2(10) NOT NULL
,CONSTRAINT faculty_PK PRIMARY KEY(facultyID)
,CONSTRAINT faculty_facultyID_FK FOREIGN KEY (facultyID) REFERENCES person(personID)
);

--student table
DROP TABLE student CASCADE CONSTRAINTS;
CREATE TABLE student
(studentNumber VARCHAR2(10) NOT NULL
,homeAddressStreet VARCHAR2(30)
,homeAddressCity VARCHAR2(20)
,homeAddressState VARCHAR2(2)
,homeAddressZip NUMBER(5)
,spouseName VARCHAR2(40)
,firstJob VARCHAR2(40)
,enrollDate DATE NOT NULL
,convocationDate DATE
,enrollmentStatusID VARCHAR2(10) NOT NULL
,academicAdvisor VARCHAR2(10) 
,CONSTRAINT student_PK PRIMARY KEY(studentNumber)
,CONSTRAINT student_studentNumber_FK FOREIGN KEY (studentNumber) REFERENCES person(personID)
,CONSTRAINT student_academicAdvisor_FK FOREIGN KEY (academicAdvisor) REFERENCES faculty(facultyID)
,CONSTRAINT student_enrollmentStatusID_FK FOREIGN KEY (enrollmentStatusID) REFERENCES programenrollment(enrollmentStatusID)
);

--course table
DROP TABLE course CASCADE CONSTRAINTS;
CREATE TABLE course
(courseID NUMBER(4) NOT NULL
,courseNumber VARCHAR2(4) NOT NULL
,courseName VARCHAR2(30) NOT NULL
,preRequisite VARCHAR2(4)
,facultyID VARCHAR2(10)
,CONSTRAINT course_PK PRIMARY KEY(courseID)
,CONSTRAINT course_facultyID_FK FOREIGN KEY (facultyID) REFERENCES faculty(facultyID)
);

--courseenrollment table
DROP TABLE courseenrollment CASCADE CONSTRAINTS;
CREATE TABLE courseenrollment
(courseEnrollmentID VARCHAR2(10) NOT NULL
,status VARCHAR2(20)
,studentNumber VARCHAR2(10)
,courseID NUMBER(4)
,CONSTRAINT courseenrollment_PK PRIMARY KEY(courseEnrollmentID)
,CONSTRAINT courseenroll_studentNumber_FK FOREIGN KEY (studentNumber) REFERENCES student(studentNumber)
,CONSTRAINT courseenroll_courseID_FK FOREIGN KEY (courseID) REFERENCES course(courseID)
);

--thesis table
DROP TABLE thesis CASCADE CONSTRAINTS;
CREATE TABLE thesis
(thesisID VARCHAR2(10) NOT NULL
,thesisAdvisor VARCHAR2(10)
,studentNumber VARCHAR2(10) NOT NULL
,thesisTitle VARCHAR2(50)
,internationalContent VARCHAR2(3) NOT NULL
,CONSTRAINT thesis_PK PRIMARY KEY(thesisID)
,CONSTRAINT thesis_thesisAdvisor_FK FOREIGN KEY (thesisAdvisor) REFERENCES faculty(facultyID)
,CONSTRAINT thesis_studentNumber_FK FOREIGN KEY (studentNumber) REFERENCES student(studentNumber)
);

--committee table
DROP TABLE committeemember CASCADE CONSTRAINTS;
CREATE TABLE committeemember
(thesisID VARCHAR2(10) NOT NULL
,facultyID VARCHAR2(10) NOT NULL
,committeeChair VARCHAR2(3)
,CONSTRAINT committeemember_thesisID_FK FOREIGN KEY (thesisID) REFERENCES thesis(thesisID)
,CONSTRAINT committeemember_facultyID_FK FOREIGN KEY (facultyID) REFERENCES faculty(facultyID)
);

INSERT INTO programenrollment VALUES ('FULL','Full-Time');
INSERT INTO programenrollment VALUES ('PART','Part-Time');
INSERT INTO programenrollment VALUES ('WITH','Withdrawn');
INSERT INTO programenrollment VALUES ('LEAV','On Leave');

--faculty 10xxx
INSERT INTO person VALUES ('10001','Mikhail','','Baryshinokov','','');
INSERT INTO person VALUES ('10002','Arthur','','Mitchell','','');
INSERT INTO person VALUES ('10003','Alicia','','Alonso','','');
-- maybe add a 'title' or 'salutation' to handle something like 'Dame'
INSERT INTO person VALUES ('10004','Dame','Margot','Fonteyn','','');
INSERT INTO person VALUES ('10005','Antony','','Tudor','','');
INSERT INTO person VALUES ('10006','George','','Balanchine','','');
INSERT INTO person VALUES ('10007','Martha','','Graham','','');
INSERT INTO person VALUES ('10008','Kir','','Jooss','','');
INSERT INTO person VALUES ('10009','Rudolf','','Nureyev','','');
INSERT INTO person VALUES ('10010','Fred','','Astaire','','');
INSERT INTO person VALUES ('10011','Jerome','','Robbins','','');
INSERT INTO person VALUES ('10012','Gene','','Kelly','','');
INSERT INTO person VALUES ('10013','Agnes','','de Mille','','');
INSERT INTO person VALUES ('10014','Katherine','','Dunham','','');
INSERT INTO person VALUES ('10015','Gaetano','','Vestris','','');
INSERT INTO person VALUES ('10016','Anna','Matveyevna','Pavlova','','');
INSERT INTO person VALUES ('10017','Bill','(Bojangles)','Robinson','','');
INSERT INTO person VALUES ('10018','Hayna','','Holm','','');

--students 20xxx
INSERT INTO person VALUES ('20001','Louisa','Mae','Alcott','','');
INSERT INTO person VALUES ('20002','Isaac','','Asimov','','');
INSERT INTO person VALUES ('20003','Alice','','Walker','','');
INSERT INTO person VALUES ('20004','ee','','cummings','','');
INSERT INTO person VALUES ('20005','Isaac','Bashevis','Singer','','');
INSERT INTO person VALUES ('20006','Kurt','','Vonnegut','','');
INSERT INTO person VALUES ('20007','Emily','','Bronte','','');
INSERT INTO person VALUES ('20008','Thomas','Sterns','Eliot','','');
INSERT INTO person VALUES ('20009','Mary','Wollstonecraft','Shelly','','');

INSERT INTO faculty VALUES ('10001');
INSERT INTO faculty VALUES ('10002');
INSERT INTO faculty VALUES ('10003');
INSERT INTO faculty VALUES ('10004');
INSERT INTO faculty VALUES ('10005');
INSERT INTO faculty VALUES ('10006');
INSERT INTO faculty VALUES ('10007');
INSERT INTO faculty VALUES ('10008');
INSERT INTO faculty VALUES ('10009');
INSERT INTO faculty VALUES ('10010');
INSERT INTO faculty VALUES ('10011');
INSERT INTO faculty VALUES ('10012');
INSERT INTO faculty VALUES ('10013');
INSERT INTO faculty VALUES ('10014');
INSERT INTO faculty VALUES ('10015');
INSERT INTO faculty VALUES ('10016');
INSERT INTO faculty VALUES ('10017');
INSERT INTO faculty VALUES ('10018');

/* there could be some contradictory data shown in module2a and 2b where 2b has an Advisor Report but it does not specify if its Academic or Thesis Advisor
   what's below being entered into student is from 2a and shows the Academic Advisor as listed in 2a
   I'm going with 2b's Advisor Report being Thesis Advisor because it does not match the academic advisor sample date listed in 2a
   actually, it does not match at all - according to 2a Louisa Mae Alcott has a Thesis Advisor of Hayna Holm and a Academic Advisor of Martha Graham
   but the Advisor Report in 2b says that Louisa's advisor is Alica Alonso.  
   According to 2b Isaac Singer has an advisor of Alicia as well.  ee and Kurt have Mikhail for an advisor (per the 2b advisor report)
   however in 2a Isaac has Ruddolf for AA and has no thesis at all listed
   in 2a ee has Auther as AA but has no thesis advisor listed despite having a thesis committee
   in 2a kurt has Fred as AA but has no thesis advisor listed despite having a thesis commitee
*/
INSERT INTO student VALUES ('20001','2 Main Street','Irving','TX','11111','Joe','','01-JUN-2011','','FULL','10007');
INSERT INTO student VALUES ('20002','30 Queens Blvd','New York','NY','10011','Sonya','','01-JUN-2013','','PART','10001');
INSERT INTO student VALUES ('20003','12 Baker Street','Boston','MA','12127','Jim','','01-JUN-2012','','FULL','10010');
INSERT INTO student VALUES ('20004','100 Electric Avenue','San Francisco','CA','93401','Mary','','01-JUN-2009','','FULL','10002');
INSERT INTO student VALUES ('20005','123 Sesame Street','New York','NY','11017','Miriam','','01-JUN-2012','','FULL','10009');
INSERT INTO student VALUES ('20006','232 G Street','Washington','DC','15611','Mary','','01-JUN-2014','','PART','10010');
INSERT INTO student VALUES ('20007','1842 Commonwealth Avenue','Brighton','MA','22156','Pat','','01-JUN-2015','','WITH','10011');
INSERT INTO student VALUES ('20008','516 Park Drive','Boston','MA','12155','Chris','','01-JUN-2011','','LEAV','10008');
INSERT INTO student VALUES ('20009','1234 Steadman Road','Townville','PA','11557','Frankie','','01-JUN-2013','','LEAV','10002');

/* course number is not enough for the unique identifier if there can be 2 712 courses
   also, there appears to be a section qualifier of 'a' but the data shows that 2 sections can
   be the same - sample data says there are 2 701a courses just with different professors
   maybe a new table called something like courseoffering or maybe even courseenrollment would handle it
   but probably not.  courseenrollment would then link to courseoffering which would link to course
   
   courseenrollment does not care which professor ran the course in the case of 701a that has duplicate sections wiht different profs
   that separates the prof teaching the course from the course itself so maybe that could be handled by the new courseoffering table
*/
INSERT INTO course VALUES (1000,'702','Statistics I','','10003');
INSERT INTO course VALUES (1001,'712','Statistics II',1000,'');
INSERT INTO course VALUES (1002,'712','Reseach Apprenticeship I','','');
INSERT INTO course VALUES (1003,'722','Reseach Apprenticeship II',1002,'');
INSERT INTO course VALUES (1004,'701','Microeconomics','','10001');
INSERT INTO course VALUES (1005,'701','Microeconomics','','10002');
INSERT INTO course VALUES (1006,'703','International Business','','');

INSERT INTO courseenrollment VALUES ('3000','In Progress','20001',1004);
INSERT INTO courseenrollment VALUES ('3001','Incomplete','20001',1000);
INSERT INTO courseenrollment VALUES ('3002','Incomplete','20001',1006);
INSERT INTO courseenrollment VALUES ('3003','In Progress','20002',1004);
INSERT INTO courseenrollment VALUES ('3004','Waived','20002',1000);
INSERT INTO courseenrollment VALUES ('3005','Incomplete','20002',1006);
INSERT INTO courseenrollment VALUES ('3006','In Progress','20004',1004);
INSERT INTO courseenrollment VALUES ('3007','In Progress','20004',1000);
INSERT INTO courseenrollment VALUES ('3008','B+','20004',1006);

/* sample data from module 2b Advisor Report assumed to be Thesis Advisor Report so thesis info added accordingly
   sample date inconsistent so assigning thesis advisor randomly to 20004 and 20003's thesis
   commenting out 2 rows that represent data from Ivey Part II
*/
--INSERT INTO thesis VALUES ('THESIS1000','10005','20004','Why is there air?','No');
--INSERT INTO thesis VALUES ('THESIS1001','10013','20003','What goes up, must come down.','No');
INSERT INTO thesis VALUES ('THESIS1002','10018','20001','Little Women','No');
INSERT INTO thesis VALUES ('THESIS1003','10008','20002','I, Robot','No');
INSERT INTO thesis VALUES ('THESIS1004','10003','20008','Is 5','No');
INSERT INTO thesis VALUES ('THESIS1005','10002','20009','Frankenstein, or the Modern Prometheus','No');

/* sample data in modules did not indicate thesis committee chair for THESIS1002,1003,1004,1005
   commenting out 2 of the thesis that represent data from Ivey Part II
*/
--INSERT INTO committeemember VALUES ('THESIS1000','10003','No');
--INSERT INTO committeemember VALUES ('THESIS1000','10004','Yes');
--INSERT INTO committeemember VALUES ('THESIS1000','10005','No');
--INSERT INTO committeemember VALUES ('THESIS1001','10004','No');
--INSERT INTO committeemember VALUES ('THESIS1001','10006','No');
--INSERT INTO committeemember VALUES ('THESIS1001','10007','Yes');
INSERT INTO committeemember VALUES ('THESIS1002','10010','No');
INSERT INTO committeemember VALUES ('THESIS1002','10001','No');
INSERT INTO committeemember VALUES ('THESIS1002','10007','No');
INSERT INTO committeemember VALUES ('THESIS1002','10012','No');
INSERT INTO committeemember VALUES ('THESIS1003','10013','No');
INSERT INTO committeemember VALUES ('THESIS1003','10007','No');
INSERT INTO committeemember VALUES ('THESIS1003','10009','No');
INSERT INTO committeemember VALUES ('THESIS1003','10011','No');
INSERT INTO committeemember VALUES ('THESIS1004','10014','No');
INSERT INTO committeemember VALUES ('THESIS1004','10004','No');
INSERT INTO committeemember VALUES ('THESIS1004','10009','No');
INSERT INTO committeemember VALUES ('THESIS1004','10015','No');
INSERT INTO committeemember VALUES ('THESIS1005','10010','No');
INSERT INTO committeemember VALUES ('THESIS1005','10001','No');
INSERT INTO committeemember VALUES ('THESIS1005','10016','No');
INSERT INTO committeemember VALUES ('THESIS1005','10017','No');

commit;/************************************/
/* Program: Module3a_Reports_From_Module2a.sql */
/* Author: Eric Gates  */
/* Date Created: 16-JUL-2017 */
/* Last Updated: 18-JUL-2017/Eric Gates */
/* Requested By: Benjamin Fruchter SUNY Empire State College */
/* Purpose: */
/* For Module 3a: Create the two reports describe in Module 2a Ivey Part I. */
/* I/O:*/
/*      1) Student Status Report */
/*      2) Thesis Committee Report */
/************************************/


-- Student Status Report
set wrap off;
set linesize 240;
set pagesize 60;
COLUMN "Student" FORMAT A30;
COLUMN "Years Enrolled" FORMAT A15;
COLUMN "Academic Advisor" FORMAT A20;
TTITLE LEFT "Student Status Report";
SELECT CONCAT(CONCAT(person.lastname, ', '), CONCAT(CONCAT(person.firstname,' '), person.middlename)) AS "Student" 
     , programenrollment.enrollmentstatus AS "Current Enrollment Status"
     , TO_CHAR(EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM student.enrollDate)) AS "Years Enrolled"
     , (SELECT CONCAT(CONCAT(person.lastname, ', '), CONCAT(CONCAT(person.firstname,' '), person.middlename)) FROM person WHERE student.academicadvisor = person.personID) AS "Academic Advisor"
FROM student
   , person
   , programenrollment
WHERE student.studentnumber = person.personid 
AND student.enrollmentstatusid = programenrollment.enrollmentstatusid
ORDER BY lower(person.lastname);
COLUMN "Student" CLEAR;
COLUMN "Years Enrolled" CLEAR;
COLUMN "Academic Advisor" CLEAR;
	 
-- Thesis Committee Report	 
set wrap off;
set linesize 120;
set pagesize 60;
COLUMN "Student" FORMAT A30;
COLUMN "Thesis Title" FORMAT A42;
COLUMN "Thesis advisor" FORMAT A20;
TTITLE LEFT "Thesis Committee Report";
BREAK ON "Student" NODUP ON "Thesis title" NODUP ON "Thesis advisor" NODUP;
SELECT (SELECT CONCAT(CONCAT(person.lastname, ', '), CONCAT(CONCAT(person.firstname,' '), person.middlename)) FROM person WHERE studentNumber = personid) AS "Student"
     , thesis.thesistitle AS "Thesis title" 
     , (SELECT CONCAT(CONCAT(person.lastname, ', '), CONCAT(CONCAT(person.firstname,' '), person.middlename)) FROM person WHERE thesisadvisor = personid) AS "Thesis advisor"
     , (SELECT CONCAT(CONCAT(person.lastname, ', '), CONCAT(CONCAT(person.firstname,' '), person.middlename)) FROM person WHERE committeemember.facultyid = personid) AS "Thesis committee members"
FROM thesis, committeemember
WHERE thesis.thesisID = committeemember.thesisID
ORDER BY LOWER("Student"), "Thesis title", "Thesis advisor";

CLEAR BREAKS;
COLUMN "Student" CLEAR;
COLUMN "Thesis Title" CLEAR;
COLUMN "Thesis advisor" CLEAR;
