-- Create database
create database ims;

-- Show all databases
-- SQL Server
SELECT * FROM sys.databases;
-- Oracle
Select * from DBA_USERS;

-- Create Table Client MASTER
create table Client_Master(
    ClientNo        varchar(6)
    ,Name           varchar(20)
    ,Address1       varchar(30)
    ,Address2       varchar(30)
    ,City           varchar(15)
    ,PinCode        int
    ,State          varchar(15)
    ,BalDue         decimal(10,2)
);

-- How to check the table structure
-- SQL Server
sp_help Client_Master
-- Oracle
describe Client_Master

-- How to drop a table
-- SQL Server
drop table Customer_Master

-- How to add column in an existing table
ALTER TABLE ProductType_Master ADD prodType_Value int; 

-- How to update the column value of an existing table
update ProductType_Master set prodType_Value = 101 where prodType_Id =1
