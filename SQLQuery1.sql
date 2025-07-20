--SELECT ORDINAL_POSITION, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH, IS_NULLABLE
--FROM INFORMATION_SCHEMA.COLUMNS
--WHERE TABLE_NAME= 'STUDENTS'

INSERT INTO STUDENTS (ID, NAME, AGE, ADDRERSS) VALUES (1, 'Anderson', 25, 'London');
INSERT INTO STUDENTS VALUES(2, 'Amit', 30, 'Kolkata');

SELECT * FROM STUDENTS

ALTER TABLE STUDENTS
RENAME COLUMN 'ADDRERSS' to 'ADDRESS'

--sp_rename 'STUDENTS.ADDRERSS', 'ADDRESS', 'COLUMN';
--SP_HELP sp_rename


Insert into students values (3,'soumyojit',29,'Kolkata')


Insert into students values (4,'Rahul',40,'Delhi')
Insert into students values (5,'Sumit',15,'Mumbai')
Insert into students values (6,'Rahul',26,'Mumbai')
Insert into students values (7,'Dipak',16,'Chennai')
