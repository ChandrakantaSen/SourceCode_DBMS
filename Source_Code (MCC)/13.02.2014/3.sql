/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [user_id]
      ,[user_pwd]
      ,[user_type]
      ,[user_name]
      ,[user_active]
      ,[user_news]
      ,[user_sw]
  FROM [MiscDb].[dbo].[pm_user]
  
  
 select * from pm_user
  where user_type = RSM