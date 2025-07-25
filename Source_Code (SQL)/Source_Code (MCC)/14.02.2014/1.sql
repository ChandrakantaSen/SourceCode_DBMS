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
  
 select pm_depot_master.regn, dn_dealer_list.dealer_category
       ,ISNULL(phone,'--') as "phone_list"
 from pm_depot_master
     ,dn_dealer_list
 where pm_depot_master.regn in
     (select regn,phone 
        from dn_dealer_list 
        where pm_depot_master.depot_code = dn_dealer_list.depot_code) 
          and dn_dealer_list.dealer_category in (select dealer_category from dn_dealer_list)
