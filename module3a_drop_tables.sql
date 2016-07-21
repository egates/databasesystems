/************************************/
/* Program: module3a_drop_tables.sql */
/* Author: Eric Gates  */
/* Date Created: 10-JUL-2017 */
/* Last Updated: 16-JUL-2017/Eric Gates */
/* Requested By: Benjamin Fruchter SUNY Empire State College */
/* Purpose: */
/* For Module 3a: just drop the tables. */
/* I/O: None */
/************************************/

-- setup terminal session
-- set termout on
-- set termout off
-- set feedback on

--programenrollment table
DROP TABLE programenrollment CASCADE CONSTRAINTS;

--person table
DROP TABLE person CASCADE CONSTRAINTS;

--faculty table
DROP TABLE faculty CASCADE CONSTRAINTS;

--student table
DROP TABLE student CASCADE CONSTRAINTS;

--course table
DROP TABLE course CASCADE CONSTRAINTS;

--courseenrollment table
DROP TABLE courseenrollment CASCADE CONSTRAINTS;

--thesis table
DROP TABLE thesis CASCADE CONSTRAINTS;

--committee table
DROP TABLE committeemember CASCADE CONSTRAINTS;


