--
-- Student stuff script
--
-- NB _dt is a date time string in R format "2022-07-29 06:04:23"
--
-- v01 - 1st cut
-- v02 - Added constraints
--
-- USER STUFF
--
create user 'IS_student_01'@localhost identified by 'pillar_one1';
select user from mysql.user;
select user(), current_user();
--
drop database if exists IS_students_v01;
--
create database IS_students_v01;
--
use IS_students_v01;
--
create table students (
    moodle_user_id      int not null,
    moodle_user_name    varchar(255),
    moodle_full_name    varchar(255),
    moodle_email        varchar(255),
    RStudio_user_id     varchar(255),
    RStudio_password    varchar(255),
    RStudio_dt          varchar(255),
    primary key(moodle_user_id),
    index(moodle_user_id),
    unique(moodle_user_id)
);
--
--
create table assessments (
	moodle_user_id		 int not null,
	moodle_course_id	 int not null,
	assessment_start_dt  varchar(255),
	assessment_stop_dt   varchar(255),
	assessment_result 	 int,
	certificate_dt       varchar(255),
	primary key(moodle_user_id, moodle_course_id),
	index(moodle_user_id, moodle_course_id),
	foreign key(moodle_user_id) references students(moodle_user_id), 
	constraint c1_assessments unique (moodle_user_id, moodle_course_id)
);
--
--
create table questions (
	moodle_user_id		 int not null,
	moodle_course_id	 int not null,
	question_id      	 int not null,
	question_result      int not null,
	primary key(moodle_user_id, moodle_course_id, question_id),
	index(moodle_user_id, moodle_course_id, question_id),
	foreign key(moodle_user_id, moodle_course_id) references  assessments(moodle_user_id, moodle_course_id), 
	constraint c1_questions unique (moodle_user_id, moodle_course_id, question_id)
);
--
describe IS_students_v01.students;
describe IS_students_v01.assessments;
describe IS_students_v01.questions;
--
grant all privileges on IS_student_v01 to 'IS_student_01'@'localhost';
--
drop user 'IS_student_01'@localhost;