USE [bd2]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[deleteStudentRecord]
		@fname = N'a',
		@lname = NULL,
		@email = NULL

SELECT	'Return Value' = @return_value

GO
select * from tbl_Students;
CREATE TABLE Persons
(
	ID int NOT NULL,
	LastName varchar(255) NOT NULL,
	FirstName varchar(255),
	Address varchar(255),
	City varchar(255),
	PRIMARY KEY (ID)
)

select * from Persons;

CREATE TABLE  tbl_Students

(
    [Studentid] [int] IDENTITY(1,1) NOT NULL,
    [Firstname] [varchar](200) NOT  NULL,
    [Lastname] [varchar](200)  NULL,
    [Email] [varchar](100)  NULL
)
Insert into tbl_Students (Firstname, lastname, Email)
 Values('Vivek', 'Johari', 'vivek@abc.com')

Insert into tbl_Students (Firstname, lastname, Email)
 Values('Pankaj', 'Kumar', 'pankaj@abc.com')

Insert into tbl_Students (Firstname, lastname, Email)
 Values('Amit', 'Singh', 'amit@abc.com')

Insert into tbl_Students (Firstname, lastname, Email)
 Values('Manish', 'Kumar', 'manish@abc.comm')

Insert into tbl_Students (Firstname, lastname, Email)
 Values('Abhishek', 'Singh', 'abhishek@abc.com')
 
 SELECT * FROM tbl_Students
create table customer_tbl
(
	 customer_id int identity(1,2)
	,customer_name varchar(10)
	,customer_type varchar(5)
)

insert into customer_tbl values ('AYAN','GC');
INSERT INTO customer_tbl VALUES ('AHANA','GC');
SELECT * FROM customer_tbl;
SELECT * FROM contract_tbl;

create table contract_tbl
(
	 contract_id int identity(1,2)
	,customer_id int 
	,amount decimal(5,2)
)

INSERT INTO contract_tbl VALUES (9,458);
