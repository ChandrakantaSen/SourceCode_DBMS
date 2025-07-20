ALTER TABLE [dbo].[T_Category] ALTER COLUMN CatId nvarchar(5) NOT NULL;

ALTER TABLE [dbo].[T_Category] Add Primary Key (CatId);

truncate table [dbo].[T_Club]

truncate table [dbo].[T_Customer]

ALTER TABLE [dbo].[T_CustSub] ALTER COLUMN 	CustId nvarchar(7) NOT NULL;

ALTER TABLE [dbo].[T_CustSub] ALTER COLUMN 	CarId nvarchar(12) NOT NULL;

ALTER TABLE [dbo].[T_CustSub] Add Primary Key (CustId,CarId);

ALTER TABLE [dbo].[T_CustSub] Add 
	constraint FK_CustCar
	Foreign Key (CustId)
	References T_Customer(CustId)
	On Delete cascade
	On Update cascade;

