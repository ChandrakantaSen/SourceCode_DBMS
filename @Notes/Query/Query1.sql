create table T_Cust (
   CustId nvarchar(7) Not Null,
   CustName nvarchar(200),
   CustPhon nvarchar(30))

Alter Table T_Cust
Add Primary Key (CustId)

Alter Table T_Cust
delete CustPhon nvarchar(30)

select CustId, CustName, CustMob into T_Cust1 from T_Customer
   where CustAddr like '%KOL%26%';


ALTER TABLE T_Cust DROP COLUMN CustPhon;


SELECT ORDINAL_POSITION, COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
       , IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'T_Cust'

SELECT CONSTRAINT_NAME
FROM INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
WHERE TABLE_NAME = 'T_CustSub'

SELECT name, type_desc, is_unique, is_primary_key
FROM sys.indexes
WHERE [object_id] = OBJECT_ID('dbo.T_CustSub')

