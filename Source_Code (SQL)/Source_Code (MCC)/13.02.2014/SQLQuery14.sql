/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [empno]
      ,[ename]
      ,[job]
      ,[mgr]
      ,[hiredate]
      ,[sal]
      ,[comm]
      ,[dept]
  FROM [bd2].[dbo].[emp]
 