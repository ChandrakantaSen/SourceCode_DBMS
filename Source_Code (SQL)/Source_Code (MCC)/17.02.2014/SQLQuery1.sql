/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [depot_code]
      ,[dealer_code]
      ,[dealer_child_code]
  FROM [MiscDb].[dbo].[dn_dealer_link]
  
 exec cursor_procedure