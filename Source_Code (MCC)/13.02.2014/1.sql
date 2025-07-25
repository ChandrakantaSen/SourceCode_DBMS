/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [depot_code]
      ,[dealer_code]
      ,[dealer_name]
      ,[dealer_category]
      ,[dealer_category_old]
      ,[active]
  FROM [MiscDb].[dbo].[dn_dealer_list]
  
  select * 
  from dn_dealer_list
      ,dn_dealer_sales
      ,dn_dealer_link
 SELECT MAX(dealer_code) FROM dn_dealer_list
SELECT DISTINCT dealer_code
FROM dn_dealer_list
WHERE dealer_code >=(SELECT * FROM dn_dealer_list)