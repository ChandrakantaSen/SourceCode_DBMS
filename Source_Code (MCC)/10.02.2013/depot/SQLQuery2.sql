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
select regn, COUNT(depot_code)as "depot_code"
from pm_depot_master
where pm_depot_master.regn='W2'
group by depot_code;