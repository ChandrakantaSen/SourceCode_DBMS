-- Create Table Client_Master
create table Client_Master(
    ClientNo        varchar2(6)
    ,Name           varchar2(20)
    ,Address1       varchar2(30)
    ,Address2       varchar2(30)
    ,City           varchar2(15)
    ,PinCode        Number(8)
    ,State          varchar2(15)
    ,BalDue         Number(10,2)
);

-- Create Table Product_Master
create table Product_Master(
    ProductNo       varchar2(6)
    ,Description    varchar2(15)
    ,ProfitPercent  Number(4,2)
    ,UnitMeasure    varchar2(10)
    ,QtyOnHand      Number(8)
    ,ReorderLvl     Number(8)
    ,SellPrice      Number(8,2)
    ,CostPrice      Number(8,2)
);

-- Create Table Salesman_Master
create table Salesman_Master(
    SalesmanNo      varchar2(6)
    ,SalesmanName   varchar2(20)
    ,Address1       varchar2(30)
    ,Address2       varchar2(30)
    ,City           varchar2(20)
    ,PinCode        Number(8)
    ,State          varchar2(20)
    ,SalAmt         Number(8,2)
    ,TgtToGet       Number(6,2)
    ,YtdSales       Number(6,2)
    ,Remarks        varchar2(60)
);

-- Create Table Salesman_Order
create table Sales_Order(
	OrderNo			varchar2(6) primary key
	,OrderDate		date
	,ClientNo		varchar2(6) references Client_Master(ClientNo)
	,DelyAddr		varchar2(25)
	,DelyType		char(1)
	,BilledYn		char(1)
	,SalesmanNo		varchar2(6) references Salesman_Master(SalesmanNo)
	,DelyDate		date
	,OrderStatus	varchar2(10)
);

-- Create Table Sales_Order_Details
create table Sales_Order_Details(
	OrderNo			varchar2(6)	primary key
	,ProductNo		varchar2(6) references Product_Master(ProductNo)
	,QtyOrdered		number(8)
	,QtyDisp		number(8)
	,ProductRate	number(10,2)
);

create table sales_order(
	orderno varchar2(6) primary key,
	orderdate date,
	clientno varchar2(6) references Client_Master(clientno),
	delyaddr varchar2(25),
	delytype char(1),
	billedyn char(1),
	salesmanno varchar2(6)references Salesman_Master(salesmanno),
	delydate date, 
	orderstatus varchar2(10)
);

-- Insert data to Client_Master table
Insert into Client_Master values ('C00001','Li Smith','Mumbai',' ',400054,'Maharastra',15000);
Insert into Client_Master values ('C00002','Smith Jones','Madras',' ',780001,'TamilNadu',0);
Insert into Client_Master values ('C00003','Lam Williams','Mumbai',' ',400057,'Maharastra',5000);
Insert into Client_Master values ('C00004','Martin Brown','Bangalore',' ',560001,'Karnataka',0);
Insert into Client_Master values ('C00005','Gelbero Wilson','Mumbai',' ',400060,'Maharastra',2000);
Insert into Client_Master values ('C00006','Roy Taylor','Mangalore',' ',560050,'Karnataka',0);

-- Insert data to Sales_Order table
Insert into Sales_Order values ('O19000','12-June-02','C00001','Kolkata','F','Y','S00001','22-June-02','In Process');
Insert into Sales_Order values ('O19001','13-June-02','C00002','Lucknow','P','N','S00002','19-June-02','Cancelled');
Insert into Sales_Order values ('O19002','12-June-02','C00003','Kolkata','P','Y','S00003','29-June-02','Fulfilled');
Insert into Sales_Order values ('O19003','15-June-02','C00001','Patna','F','N','S00001','20-June-02','Cancelled');
Insert into Sales_Order values ('O19004','12-June-02','C00004','Mumbai','F','N','S00002','16-June-02','In Process');
Insert into Sales_Order values ('O19005','15-June-02','C00005','Pune','P','N','S00004','16-June-02','In Process');

-- Insert data to Sales_Order_Details table
Insert into Sales_Order_Details values ('O19001','P00001',2,3,2611);
Insert into Sales_Order_Details values ('O19002','P00002',8,3,1467);
Insert into Sales_Order_Details values ('O19003','P00003',4,10,3010);
Insert into Sales_Order_Details values ('O19004','P00854',6,12,3024);
Insert into Sales_Order_Details values ('O19005','P00705',3,6,2967);
Insert into Sales_Order_Details values ('O19006','P00006',4,10,1560);
Insert into Sales_Order_Details values ('O19007','P00007',5,1,1651);
Insert into Sales_Order_Details values ('O19008','P00008',5,6,2057);
Insert into Sales_Order_Details values ('O19009','P0909',12,2,2617);
Insert into Sales_Order_Details values ('O19010','P00010',10,9,1608);
Insert into Sales_Order_Details values ('O19011','P00011',10,5,2411);
Insert into Sales_Order_Details values ('O19012','P00612',6,4,2564);
Insert into Sales_Order_Details values ('O19013','P00013',12,3,840);
Insert into Sales_Order_Details values ('O19014','P00014',1,1,3542);
Insert into Sales_Order_Details values ('O19015','P00515',5,10,446);




