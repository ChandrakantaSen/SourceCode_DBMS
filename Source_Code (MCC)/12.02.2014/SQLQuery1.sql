/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [user_id]
      ,[user_depot]
  FROM [MiscDb].[dbo].[pm_user_depots]

Select TOP 25 user_depot
from  pm_user_depots
order by user_id;

select depot_code
  from pm_depot_master
intersect1
select depot_code
  from dn_dealer_list

select count(user_depot) as "dual_count",max(user_depot) as "dual_max",min(user_depot) as "dual_min"
from pm_user_depots

select * from pm_depot_master;

select (isnull(maneger,0))
from pm_depot_master

select pm_depot_master.regn
      ,pm_depot_master.unix_code
      ,count(dn_dealer_list.active)
from
	pm_depot_master
	,dn_dealer_list
	
where pm_depot_master.depot_code = dn_dealer_list.depot_code

group by 
       pm_depot_master.regn
      ,dn_dealer_list.active
      ,pm_depot_master.unix_code;
select @@ERROR

BEGIN TRY
  print 'At Outer Try Block'
   BEGIN TRY
      print 'At Inner Try Block'
   END TRY
   BEGIN CATCH
      print 'At Inner catch Block'
   END CATCH
END TRY
BEGIN CATCH
   print 'At Outer catch block'
END CATCH

