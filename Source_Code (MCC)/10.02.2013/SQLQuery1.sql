/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [regn]
      ,[sub_regn]
      ,[depot_code]
      ,[depot_name]
      ,[state]
      ,[phone]
      ,[email]
      ,[maneger]
      ,[mobile]
      ,[fund_depot_code]
      ,[unix_code]
  FROM [MiscDb].[dbo].[pm_depot_master]
  
DECLARE @TestVal INT
SET @TestVal = 3
SELECT
CASE @TestVal
WHEN 1 THEN 'First'
WHEN 2 THEN 'Second'
WHEN 3 THEN 'Third'
ELSE 'Other'
END

select * from MiscDb.dbo.dn_dealer_list                                  