/************************************/
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
