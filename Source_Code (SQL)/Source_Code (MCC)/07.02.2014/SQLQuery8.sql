/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Emp_ID]
      ,[Emp_name]
      ,[Emp_Sal]
  FROM bd2.dbo.Employee_Test
  Delete from bd2.dbo.Employee_Test
  where Emp_ID =10;
  
  select * from bd2.dbo.Employee_Test_Audit;