/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Emp_ID]
      ,[Emp_name]
      ,[Emp_Sal]
  FROM [bd2].[dbo].[Employee_Test]
SELECT Emp_ID, count(Emp_Sal)
FROM bd2.dbo.Employee_Test
WHERE Emp_Sal>1000
GROUP BY Emp_name; 