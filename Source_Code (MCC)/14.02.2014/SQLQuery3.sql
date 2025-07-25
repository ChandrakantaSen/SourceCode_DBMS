/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [depot_code]
      ,[dealer_code]
      ,[dealer_child_code]
  FROM [MiscDb].[dbo].[dn_dealer_link]
  
SELECT 
      dealer_code
      ,count(dealer_child_code)
  FROM [MiscDb].[dbo].[dn_dealer_link]
group by dealer_code
having (count(dealer_child_code))>1