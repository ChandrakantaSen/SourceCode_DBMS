-- Customer Master Table
create table Customer_Master(
    Cust_Id			int IDENTITY(1,1)
	,Cust_fname		varchar(max)
	,Cust_lname		varchar(max)
	,Cust_address	varchar(max)
	,Cust_lndMrk	varchar(max)
	,Cust_mail		varchar(max)
	,Cust_contact	varchar(max)
	,Cust_createdBy	varchar(max)
	CONSTRAINT PK_Customer_Master PRIMARY KEY (Cust_Id)
);

-- Product Type Master Table
create table ProductType_Master(
	prodType_Id		int IDENTITY(1,1)
	,prodType_Name	varchar(max)
	,prodType_Value	int
	CONSTRAINT PK_ProductType_Master PRIMARY KEY (prodType_Id)
);

-- Product Master Table
create table Product_Master(
	prod_Id				int IDENTITY(1,1)
	,prod_Name			varchar(max)
	,prod_TypeValue		int
	,prod_Description 	varchar(max)
	,prod_Price			decimal(8,2)
	,prod_Quantity		int
	CONSTRAINT PK_Product_Master PRIMARY KEY (prod_Id)
	CONSTRAINT FK_Product_Master FOREIGN KEY (prod_TypeValue)
	REFERENCES ProductType_Master(prodType_Value)
);

-- How to add Unique Key 
ALTER TABLE ProductType_Master
ADD CONSTRAINT UC_ProductType UNIQUE (prodType_Value); 

-- Stored Procedure
create procedure sp_GetProducttypeValueByName
@prodName varchar(max),
@prodValue int output
as
begin
	select @prodValue = prodType_Value
	from ProductType_Master
	where prodType_Name = @prodName
end

-- For execution of Stored Procedure
declare @r int
exec sp_GetProducttypeValueByName 'Grocery', @r  output
select @r;

-- Sub Query
select prod_Name
from Product_Master
where prod_TypeValue = (select prodType_Value from ProductType_Master where prodType_Name = 'Grocery')