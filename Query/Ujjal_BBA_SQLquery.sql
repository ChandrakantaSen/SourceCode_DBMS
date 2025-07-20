-- Fetch all database those are created under the user 
select * from all_tables
select * from all_tables where owner = 'SCOTT'

-- Create table named as 'FriendList'
create table friendlist
(
	listId varchar2(6)
	,frndName varchar2(20)
	,address varchar2(20)
	,frndAge number(2)
);

-- How to check the table structure
describe friendlist

-- How to insert values into a table
insert into friendlist
values
(
	'FND/01'
	,'ABC'
	,'Kolkata'
	,23
);

-- How to show all data from a table
select * from friendlist

-- How to show some specific columns from a table
select frndName,frndAge
from friendlist

-- How to show some specific rows from a table
select frndName,frndAge
from friendlist
where frndAge > 22

-- How to update the values of a specific columns
update friendlist
set
	frndName = 'JKL'
where listId = 'FND/04'

-- How to add extra column in the table
alter table friendlist
add (schlName varchar2(30))

-- How to update blank cell value in the table
update friendlist
set
	schlName = 'St. Lawrence High School'
where listId = 'FND/01'

-- Eliminating Duplicate Rows when using a select satatement
insert into friendlist
values
(
	'FND/01'
	,'ABC'
	,'Kolkata'
	,23
	,'St. Lawrence High School'
);

select distinct * from friendlist;

-- Modifying the structure of tables - modify columns size
Alter table friendlist
modify (SCHLNAME varchar2(50));

-- Modifying the structure of tables - drop column from a table
Alter table friendlist drop column SCHLNAME;

-- To show the table details, created by the user
select * from TAB;



