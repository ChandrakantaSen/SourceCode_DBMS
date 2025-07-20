-- How to show database tables created by a specific user`
select owner, table_name from all_tables where Owner = 'SCOTT'

-- List of all TABLES
select * from client_master;
select * from product_master;
select * from sales_order;
select * from sales_order_details;
select * from salesman_master; 
select * from student_master;
select * from faculty_master;
select * from department_master;
select * from Hostel_Master;
select * from Placement_Master;
select * from AdmissionCell_Master;
select * from CollegeFinanace_Master
select * from newSales_Order
select * from newStudent_Master
select * from newSales_Order_Details
select * from newClient_master

-- Table Creation
create table bca(std_id number(5),std_name varchar2(10)) 

-- To show table structure
describe bca

-- Insert data values
insert into bca (std_id,std_name) values (1,'Surajit');
insert into bca values (2,'Mrinal');

-- Create a table named BankMaster whose structure is -
create table BankMaster
(
	AcctHolderId varchar2(10)
	,FirstName varchar2(20)
	,LastName varchar2(20)
	,Address varchar2(30)
	,PinCode number(6)
);

-- Insert the values into the BankMaster Table
insert into BankMaster
values
(
	'SB100'
	,'Chandrakanta'
	,'Sen'
	,'Entally'
	,700014
);

insert into BankMaster
values
(
	'SB101'
	,'Suniti'
	,'Ghorai'
	,'Haldia'
	,500145
);

insert into BankMaster
values
(
	'SB102'
	,'Riya'
	,'Pattanayak'
	,'Haldia'
	,500145
);

insert into BankMaster
values
(
	'SB103'
	,'Surajit'
	,'Samanta'
	,'Tamluk'
	,500140
);

insert into BankMaster
values
(
	'SB104'
	,'Ramkrishna'
	,'Bhakta'
	,'Entally'
	,700014
);

insert into BankMaster
values
(
	'SB105'
	,'Manoj'
	,'Aloo'
	,'Howrah'
	,700136
);

-- Viewing data from Table -- All rows & All COLUMNS
select * from BankMaster;

-- Viewing data from Table -- Selected columns & All rows
select AcctHolderId,FirstName,LastName,Address,PinCode
from BankMaster;

select FirstName, LastName 
from BankMaster

-- Viewing data from Table -- Selected rows & All columns
select * from BankMaster
where AcctHolderId = 'SB101'

-- Viewing data from Table -- Selected rows & Selected columns
select FirstName, LastName 
from BankMaster
where AcctHolderId = 'SB101'

-- Eliminating Duplicate Rows when using a select satatement
select distinct * from BankMaster;

-- Sorting Data in a table
select * from BankMaster
order by AcctHolderId desc/asc;

-- Delete of a specific row
delete from bca where std_id = 3

-- Delete of all rows
delete from bca

-- Update records conditionally
update BankMaster 
set 
	lastname = 'Manna'
  , address = 'Diamond Harbour' 
where acctholderid = 'SB106'

-- Modifying the structure of tables - Adding new columns
Alter table BankMaster
add (Telephone number(10))

-- Modifying the structure of tables - modify columns size
Alter table BankMaster
modify (xyz number(8))

-- Modifying the structure of tables - drop column from a table
Alter table BankMaster drop column xyz;

-- To show the table details, created by the user
select * from TAB;

-- 3 Master Tables -- Client_Master, Product_Master, Salesman_Master
-- Find out the names of all the clients
Select name from client_master

-- Retrive the list of names, city and the state of all the clients
Select name, city, state from client_master

-- List the various products available from the Product_Master table
Select description from product_master

-- List of all clients who are located in Mumbai
Select name from Client_Master
where city = 'Mumbai'

-- Find the names of Salesman who have a salary equal to Rs. 3000/-
Select salesmanname from salesman_master
where salamt = 3000

-- Change the city of ClientNo. 'C00004' to 'Indore'
Update client_master
set city = 'Indore'
where clientno = 'C00004'

-- Change the state of ClientNo. 'C00004' to 'MP'
Update client_master
set state = 'MP'
where clientno = 'C00004'

-- Change the baldue of ClientNo. 'C00002' to Rs. 3690/-
Update client_master
set baldue = 3690
where clientno = 'C00002'

-- Change the cost price of the product 'Pan D' to Rs. 1000/-
Update product_master
set costprice = 1000
where description = 'Pan D'

Update product_master
set costprice = 1000
where productno = (select productno from product_master where description = 'Pan D')

-- Change the city & state of salesman to Lucknow, UP
Update salesman_master
set city = 'Lucknow', state = 'UP'
where salesmanno = 'S00001'

-- Add a column called 'email' of datatype 'varchar2' and size = '20' to the client_master table
Alter table Client_Master
add(EMAIL varchar2(20))

-- Add the email id of clientno = 'C00003' to the client_master table
Update client_master
set email = 'lam@ggihaldia.com'
where clientno = 'C00003'

-- Drop a column called 'email23' from the client_master table
Alter table Client_Master
drop column EMAIL23

-- Change the size of costprice column in Product_Master to (10,2)
Alter table product_master
modify (costprice number(10,2))

-- Create table 'Student_Master' by using 'NOT NULL' constraint defined at the column level
Create table Student_Master (
	Student_No varchar2(6) not null
	,Student_Name varchar2(20) not null
	,Address1 varchar2(20)
	,Address2 varchar2(20)
	,City varchar2(15) not null
	,State varchar2(15)
	,PinCode number(10,2) not null
	,Bal_Due number(10,2)
);

-- Insert values into 'Student_Master'
insert into Student_Master
values
(
	'STD001'
	,'Anindita Samanta'
	,'Tamluk'
	,''
	,'Purba Midnapore'
	,'West Bengal'
	,789630
	,4700.78
);

insert into Student_Master
values
(
	'STD002'
	,'Bipasha Manna'
	,'Tamluk'
	,''
	,'Purba Midnapore'
	,'West Bengal'
	,''
	,4700.78
);

-- Create Table 'Faculty_Master' by using 'UNIQUE' constraint defined at the column level
Create table Faculty_Master (
	Faculty_No varchar2(6) UNIQUE
	,Faculty_Name varchar2(20)
	,Address1 varchar2(20)
	,Address2 varchar2(20)
	,City varchar2(15)
	,State varchar2(15)
	,PinCode number(10,2)
	,Dept_Name varchar2(10)
);

-- Insert values into 'Faculty_Master'
insert into Faculty_Master
values
(
	'FCAL01'
	,'Dr. Sumit Banerjee'
	,'Ankurhati'
	,''
	,'Howrah'
	,'West Bengal'
	,712536
	,'BSc in HHA'
);

insert into Faculty_Master
values
(
	'FCAL02'
	,'Mrs. Moumita Bhattacherjee'
	,'Barasat'
	,''
	,'North 24 Pgs.'
	,'West Bengal'
	,712446
	,'BBA'
);

insert into Faculty_Master
values
(
	'FCAL03'
	,'Mrs. Moumita Das'
	,'Manjushree'
	,''
	,'Haldia'
	,'Purba Midnapore'
	,700259
	,'BBA in HM'
);

insert into Faculty_Master
values
(
	'FCAL04'
	,'Mrs. Arpita Saha'
	,'Mechada'
	,''
	,'Howrah'
	,'West Bengal'
	,712536
	,'BCA'
);

-- Create Table 'Department_Master' by using 'UNIQUE' constraint defined at the table level
Create table Department_Master (
	Dept_No varchar2(10)
	,Dept_Name varchar2(20)
	,HOD_Name varchar2(30)
	,Faculty_Present number(10)
	,Student_Present number(10)
	,Placement_Rate number(6)
	,UNIQUE(Dept_No)
);

-- Insert values into 'Department_Master'
insert into Department_Master
values
(
	'Dept/01'
	,'BSc in HHA'
	,'Dr. Sumit Banerjee'
	,5
	,250
	,85
);

-- Define 'PRIMARY' key constraint at the column level
create table Hostel_Master (
	Hostel_Id number(10) PRIMARY KEY
	,Boarder_Name varchar2(30)
	,Boarder_Dept varchar2(30)
	,Meal_Taken varchar2(3)
	,Bal_Due number(10,2)
	,IsActive number(1)
);

-- Insert values into 'Hostel_Master'
insert into Hostel_Master
values
(
	1
	,'Gopinath Bhowmick'
	,'BCA'
	,'Yes'
	,3596.88
	,1
);

insert into Hostel_Master
values
(
	2
	,'Manoj Aloo'
	,'BCA'
	,'Yes'
	,570.00
	,1
);

insert into Hostel_Master
values
(
	3
	,'Pritam Maity'
	,'BBA'
	,'No'
	,0.00
	,0
);

insert into Hostel_Master
values
(
	4
	,'Anjan Mahapatra'
	,'BSc in HHA'
	,'No'
	,0.00
	,1
);

-- Define 'PRIMARY' key constraint at the table level
create table Placement_Master (
	Plc_Id varchar2(10)
	,Std_Name varchar2(30)
	,Std_Dept varchar2(20)
	,Plc_Company varchar2(30)
	,Join_Date date
	,PRIMARY KEY(Plc_Id)
);

-- Insert values into 'Placement_Master'
insert into Placement_Master
values
(
	'Plc/001'
	,'Gopinath Bhowmick'
	,'BCA'
	,'TCS'
	, TO_DATE('1994/12/16 12:00:00', 'yyyy/mm/dd hh:mi:ss')
);

-- How to add 'PRIMARY' key constraint in an existing table
Alter table Student_Master
add primary key(Student_No);

-- Define 'FOREIGN' key constraint at the column level
create Table AdmissionCell_Master (
	Adm_ID varchar2(10)
	,Adm_Name varchar2(20)
	,Adm_Dept varchar2(20)
	,Adm_PaymentPaid number(10,2)
	,Adm_PaymentDue number(10,2)
	,Std_ID varchar2(6) REFERENCES Student_Master
	,PRIMARY KEY(Adm_ID,Std_ID)
);

-- Define 'FOREIGN' key constraint at the table level
create table CollegeFinanace_Master(
	FinOrdr_No varchar2(10)
	,Std_ID varchar2(6)
	,Amt_Paid number(10,2)
	,Amt_Due number(10,2)
	,Primary Key(FinOrdr_No,Std_ID)
	,Foreign Key(Std_ID)
	REFERENCES student_master
);

-- How to add column level 'PRIMARY' key constraint
create table newClient_master(
	client_no varchar2(10) CONSTRAINT pk_ClientKey PRIMARY KEY
	,client_name varchar2(30)
	,client_address1 varchar2(30)
	,client_address2 varchar2(30)
	,client_city varchar2(10)
	,client_pincode varchar2(6)
	,client_bal_due number(10,2)
);

-- How to add table level 'FOREIGN' key constraint
create table newSales_Order_Details(
	sales_detlorder_no varchar2(6)
	,sales_product_no varchar2(6)
	,sales_qty_ordered number(8)
	,sales_qty_disp number(8)
	,sales_product_rate number(8,2)
	,CONSTRAINT fk_OrderKey 
	FOREIGN KEY(sales_detlorder_no)
	REFERENCES sales_order
);

-- Alter table 'Student_Master' using check constraints at column level
Alter Table Student_Master
modify (
	student_no varchar2(6) CHECK (student_no like 'STD%')
);

Alter Table Student_Master
modify (
	student_name varchar2(20) CHECK (student_name = upper(student_name))
	,address1 varchar2(20) CHECK (address1 in ('Haldia','Nandigram','Khejuri','Garbeta','Kanthi'))
);

-- Alter table 'Student_Master' using check constraints at table level
Create table newStudent_Master(
	Student_No varchar2(6) not null
	,Student_Name varchar2(20) not null
	,Address1 varchar2(20)
	,Address2 varchar2(20)
	,City varchar2(15) not null
	,State varchar2(15)
	,PinCode number(10,2) not null
	,Bal_Due number(10,2)
	,CHECK(Student_No like 'STD%')
	,CHECK(Student_Name = upper(Student_Name))
	,CHECK(Address1 in ('Haldia','Nandigram','Khejuri','Garbeta','Kanthi'))
);

-- How do we check constraints list in Oracle 10g
select * from user_constraints

select * from user_constraints
where table_name = 'newstudent_master'

-- Default Vaue Concept
Create table newSales_Order(
	Order_no varchar2(6) Primary Key
	,Order_date date
	,Client_No varchar2(6)
	,Dely_addr varchar2(25)
	,Salesman_no varchar2(6)
	,Dely_type char(1) DEFAULT 'F'
	,Billed_yn char(1)
	,Dely_date date
	,Order_status varchar2(10)
);

-- Create table 'Persons' defined at the table level (Primary Key)
Create table persons(
    id int not null,
    lastname varchar2(255) not null,
    firstname varchar2(255),
    age int,
    constraint pk_person 
	primary key (id,lastname)
); 

-- Insert values into 'Persons' table
Insert into persons
values
(
	1
	,'Sen'
	,'Chandrakanta'
	,32
);

-- Create table 'Orders' defined at the table level (Foreign Key)
create table orders(
    orderid int not null,
    ordernumber int not null,
    personid int,
    primary key (orderid),
    constraint fk_personorder 
	foreign key (personid)
    references persons(id)
); 

-- Insert values into 'Orders' table
Insert into orders
values
(
	11
	,2231
	,1
);

-- Create table 'Supplier' defined at the table level (Primary Key)
create table supplier( 
	supplier_id number(10) not null,
	supplier_name varchar2(50) not null,
	contact_name varchar2(50),
	constraint supplier_pk 
	primary key (supplier_id)
);

-- Create table 'Products' defined at the table level (Foreign Key)
create table products( 
  product_id number(10) not null,
  supplier_id number(10) not null,
  constraint fk_supplier
  foreign key (supplier_id)
  references supplier(supplier_id)
);

-- How to drop primary key from a table
alter table persons
drop constraint pk_person;

-- How to add primary key to a table again
alter table persons
add constraint pk_person primary key(id);


delete from orders where orderid = 12
delete from persons where id= 4

-- Create table 'FKClient_Master' with some specific information
-- ClientNo -- Primary Key and first letter must be start with 'C'
-- Name -- Should be not null
create table FKClient_Master(
	client_no varchar2(6)
	,name varchar2(20)
	,address1 varchar2(30)
	,address2 varchar2(30)
	,city varchar2(15)
	,pincode number(8)
	,state varchar2(15)
	,baldue number(10,2)
	,constraint pk_clientM
	primary key(client_no)
	,check(client_no like 'C%')
);

-- Create table 'FKProduct_Master' with some specific information
-- Product_No -- Primary Key and first letter must be start with 'P'
-- Description/ProfitPercent/UnitMeasure/QtyonHand/ReorderLvl -- Should be not null
-- SellPrice/CostPrice -- Should be not null and can not be 0
create table FKProduct_Master(
	product_no varchar2(6)		not null	
	,description varchar2(15)   not null
	,profit_percent number(4,2) not null
	,unit_measure varchar2(10)  not null
	,QtyonHand number(8)        not null
	,ReorderLvl number(8)       not null
	,SellPrice number(8,2)      not null
	,CostPrice number(8,2)      not null
	,constraint pk_ProductM
	primary key(product_no)
	,check(product_no like 'P%')
	,check(sellprice > 0)
	,check(costprice > 0)
);

-- Create table 'FKSales_Order' 
create table FKSales_Order(
	orderNo varchar2(6)
	,orderDate date
	,ClientNo varchar2(6) not null
	,DelyAddr varchar2(25)
	,DelyType char(1) DEFAULT 'F'
	,BilledYn char(1)
	,constraint pk_orderNo
	primary key(orderNo)
	, constraint fk_clientNo
	foreign key (clientNo)
	references FKClient_Master(client_no)
);

-- Arithmetic Operators
---- + Addition
---- - Substraction
---- / Division
---- * Multiplication
---- ** Exponentiation
---- () Brackets

-- How to find the 16% on sell price
select 	productno
		, description
		, sellprice
		, (sellprice*0.16) Discount
		, (sellprice - (sellprice*0.16)) Net_AmtPayable
from product_master
where (sellprice - (sellprice*0.16)) > 500;

-- Logical Operator Utilization
select productno
	, description
	, sellprice
	, sellprice*0.16 Discount
	, (sellprice - (sellprice*0.16)) AmtPayable
from product_master
where (sellprice - (sellprice*0.16)) >=500;

-- Logical Operators
-- AND OPERATOR
select 	productno
		, description
		, sellprice
		, (sellprice*0.16) Discount
		, (sellprice - (sellprice*0.16)) Net_AmtPayable
from product_master
where (sellprice - (sellprice*0.16)) > 200 and (sellprice - (sellprice*0.16)) < 350;

-- OR OPERATOR
select 	productno
		, description
		, sellprice
		, (sellprice*0.16) Discount
		, (sellprice - (sellprice*0.16)) Net_AmtPayable
from product_master
where (sellprice - (sellprice*0.16)) = 200 or (sellprice - (sellprice*0.16)) =306.60;

-- NOT Operator utilization
select name
	,state
	,pincode
	,baldue
from client_master
where not(city = 'Kolkata');

select 	productno
		, description
		, reorderlvl
from product_master
where not(reorderlvl = 50);

select 	productno
		, description
		, reorderlvl
from product_master
where not(reorderlvl >= 20 and reorderlvl <= 40);

-- RANGE SEARCHING (between)
-- Both are same
select 	productno
		, description
		, reorderlvl
from product_master
where reorderlvl between 20 and 40;

select 	productno
		, description
		, reorderlvl
from product_master
where reorderlvl >= 20 and reorderlvl <= 40;

-- Simillarly -- NOT BETWEEN can also be used
-- Both are same
select 	productno
		, description
		, reorderlvl
from product_master
where reorderlvl not between 20 and 40;

select 	productno
		, description
		, reorderlvl
from product_master
where not(reorderlvl >= 20 and reorderlvl <= 40);

-- PATTERN MATCHING (LIKE predicate)
-- For character data types -
--- % sign matches any string
--- _ sign matches any single character

select * from product_master
where description LIKE 'P%'

select productno
	, description
	, sellprice
	, sellprice*0.16 Discount
	, (sellprice - (sellprice*0.16)) AmtPayable
from product_master
where (sellprice - (sellprice*0.16)) between 500 and 600;

select productno
	, description
	, sellprice
	, sellprice*0.16 Discount
	, (sellprice - (sellprice*0.16)) AmtPayable
from product_master
where (sellprice - (sellprice*0.16)) not between 500 and 600;

-- 'IN' clause/predicate is used as arithmatic operator (=) 
select productno
	, description
	, sellprice
	, sellprice*0.16 Discount
	, (sellprice - (sellprice*0.16)) AmtPayable
from product_master
where (sellprice - (sellprice*0.16)) in (481.32,600);

---- Using of 'DUAL' table
select (2*2)+10/5 from dual;
select sysdate from dual;

---- Aggregate Functions (Group Functions)
-- Average(avg)
select avg(sellprice) "Average"
from product_master;

-- Minimum(min)
select min(baldue) "Minimum Balance"
from client_master;

-- Maximum(max)
select max(baldue) "Maximum Balance"
from client_master;

-- Count() (those who are not null)
select count(clientNo) "No of Clients"
from client_master;

-- Count(*) (including duplicates and also null)
select count(*) "No of Clients"
from client_master;

-- Sum()
select sum(baldue) "Total Balance"
from client_master;

---- Numeric Functions
-- ABS (absolute value)
select ABS(-15) from dual;

-- Power(m,n)
select power(3,2) "Power Table"
from dual;

-- Round(m,n)
select round(15.351592,2) "Round Table"
from dual;

-- SQRT(n) (Square Root)
select SQRT(25) "SQUARE ROOT"
from dual;

---- String Functions
-- LOWER
select lower('GLOBAL GROUP OF INSTITUTIONS') "LOWER"
from dual;

-- UPPER
select upper('global group of institutions') "UPPER"
from dual;

-- INITCAP
select initcap('global group of institutions') "INITCAP"
from dual;

-- SUBSTR
select substr('HALDIA',3,2) "SUBSTRING"
from dual;

-- LENGTH
select length('global group of institutions') "LENGTH"
from dual;

-- LTRIM
select ltrim('HALDIA','HAL') "Left Trim"
from dual;

-- RTRIM
select rtrim('HALDIA','DIA') "Right Trim"
from dual;

-- LPAD (Left Padding)
select LPAD('HALDIA',10,'*') "LPAD"
from dual;

-- RPAD (Right Padding)
select RPAD('HALDIA',10,'*') "RPAD"
from dual;

---- Conversion Functions
-- TO_NUMBER
update product_master
set reorderlvl = reorderlvl + TO_NUMBER(SUBSTR('$100',2,2))

-- TO_CHAR
select TO_CHAR(17145,'$099,999') "CHAR CONVERSION"
from dual;

-- TO_CHAR (date conversion)
select TO_CHAR(orderdate, 'Month DD, YYYYY') "Date Format"
from Sales_Order
where orderno = 'O19005'

-- TO_DATE (date conversion)


---- DATE Functions
-- ADD_MONTHS
select add_months(sysdate,4)
from dual;

-- LAST_DAY
select SYSDATE, LAST_DAY(sysdate) "LAST"
from dual;

-- MONTHS_BETWEEN
select months_between('07-oct-21','07-jun-21') "months difference"
from dual;

-- NEXT_DAY
select next_day('07-jun-21','monday') "NEXT DAY"
from dual;

---- JOINS
-- EQUI JOINS
-- Table used: Sales_Order & Client_Master

select 
	orderNo
	, clientNo
	, orderDate
from 
	sales_order
	
select 
	clientNo
	, name
	, baldue
from 
	client_master

-- EQUI JOIN
select 
	orderNo
	, name
	, to_char(orderDate,'DD/MM/YY') "Order Date"
	,baldue
from sales_order, client_master
where client_master.clientNo = sales_order.clientNo
order by to_char(orderDate,'DD/MM/YY');

-- Table used: Sales_Order_Details & Product_Master
select
	orderNo
	, productno
	, qtyordered
	, productrate
from
	sales_order_details

select
	productno
	, description
from
	product_master
	
-- EQUI JOIN
select
	product_master.productno
	, description
	, sum(qtyordered) "Total Quantity Ordered"
from 
	product_master
	, sales_order_details
where
	product_master.productno = sales_order_details.productno
group by
	product_master.productno
	, description
order by
	product_master.productno
	
-- EQUI JOIN/INNER JOIN
select
	cm.clientNo
	,cm.name
	,cm.baldue
	,so.orderno
	,so.orderDate
	,so.delyaddr
	,so.clientNo
from
	client_master cm
	, sales_order so
where
	cm.clientNo = so.clientNo
	and cm.clientno = 'C00001'
	and so.orderdate in ('13-Jun-02','15-Jun-02')
order by
	cm.clientNo
	
-- EQUI JOIN/INNER JOIN
select
	pm.productno
	, pm.description
	, pm.qtyonhand
	, sod.productno
	, sum(sod.qtyordered) "Total Qty Ordered"
	--, sod.qtydisp--) "Total Qty Display"
from
	product_master 			pm
	, sales_order_details	sod
where
	pm.productno = sod.productno
	and pm.productno = 'P00001'
order by
	pm.productno
group by
	pm.productno
	
-- Create a table named SuppliersMaster whose structure is -
create table SuppliersMaster
(
	SupID number(10)
	,SupNM varchar2(20)
);	
	
-- Create a table named OrdersMaster whose structure is -
create table OrdersMaster
(
	OrderID number(10)
	,SupID number(10)
	,OrderDT date
);


-- Insert the values into the SuppliersMaster Table
insert into SuppliersMaster
values
(
	'100'
	,'IBM'
);
	
-- Insert the values into the OrdersMaster Table
insert into OrdersMaster
values
(
	500
	,109
	,TO_DATE('2003/05/12','YYYY/MM/DD')
);	
	
-- INNER JOIN
select 
s.SupID
,s.SupNM
,o.OrderDT
from SuppliersMaster s
INNER JOIN OrdersMaster
on s.SupID = o.SupID

-- Left Outer Join_Date
select 
s.SupID
,s.SupNM
,o.OrderDT
from SuppliersMaster s
LEFT OUTER JOIN OrdersMaster
on s.SupID = o.SupID
	

	