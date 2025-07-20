-- RDBMS 					= RELATIONAL DATABASE MANAGEMENT SYSTEM
-- SQL 						= STRUCTURED QUERY LANGUAGE
-- ROW 						= RECORD/TUPLE
-- COLUMN 					= FIELD/ATTRIBUTE
-- SCHEMA 					= OVERALL DESIGN OF THE DATABASE
-- UNIQUE KEY CONSTRAINTS   = TO SHOW THE COLUMN VALUES AS UNIQUE, ONLY ONE NULL VALUE IS PERMISBLE 
-- NOT NULL CONSTRAINTS		= TO SHOW ALL THE VALUE THOSE WHO ARE NOT NULL

-- Fetch all the database tables, made by user id 'SCOTT'
select * from all_tables where owner = 'SCOTT'

-- Create a table named as 'bbastudents'
create table bbastudents
(
	std_id varchar2(10)
	,std_name varchar2(30)
	,std_dept varchar2(3)
	,std_marks number(10)
);

create table bbastudents1
(
	stdID varchar2(10)
	, stdROLL number(10)
	, stdNAME varchar2(20)
	, stdADDRESS varchar2(50)
	, stdCONTACT number(10)
	, stdDEPT varchar2(10)
	, stdSEMESTER number(5)
);

-- To check the structure of a table
describe bbastudents

-- How to add data into a table
insert into bbastudents
values
(
	'STD/BBA/01'
	,'Supriyo Das'
	,'BBA'
	,65
	
);

insert into bbastudents1
values
(
	'STD/BBA/01'
	, 1370000337
	,'Supriyo Das'
	,'Haldia'
	,9963632002
	,'BBA'
	,2
	
);

insert into bbastudents1
values
(
	'STD/BBA/01'
	,1370000337  
	,'Supriyo Das'
	,'uluberia'
	,8585620231      
	,'BBA'
	,2
	,65
);

-- How to fetch the data from the table
select * from bbastudents

-- To show the data column wise
select std_name,std_marks from bbastudents

-- How to add where clause
select std_name,std_marks from bbastudents
where std_marks >= 80

-- How to remove duplicate data from the table
select distinct * from bbastudents1

-- How to change the data in proper order (in Ascending)
select distinct * from bbastudents1
order by stdid

-- How to change the data in proper order (in Descending)
select distinct * from bbastudents1
order by stdid desc

-- Modifying the structure of tables - Adding new columns
Alter table bbastudents1
add (stdGRADE number(10))

-- Modifying the structure of tables - modify columns size
Alter table bbastudents1
modify (stdGRADE number(2))

-- Update the existing data
Update bbastudents1
set stdGRADE = 88
where stdID = 'STD/BBA/01'

-- Update the existing data using SUB QUERY
update bbastudents1
set stdGRADE = 63
where stdid = (select stdid from bbastudents1 where stdroll = 1370002337)

-- Fetch the specific dataset from the database
select distinct * from bbastudents1
where stdgrade > 60
order by stdid 

-- Delete record under such criteria
delete from bbastudents1
where stdID = 'STD/BBA/01'

-- Using NOT NULL constraints
Alter table bbastudents1
modify (stdGRADE number(2) not null);

Alter table bbastudents1
modify 
(
	stdSEMESTER number(5) not null
	, stdDEPT   varchar2(10) not null	
);

-- Using UNIQUE constraints
Alter table bbastudents1
modify 
(
	stdROLL number(10) unique
);

-- Add primary key to the existing table
Alter table bbastudents1
add primary key(stdID)







