
select MiscDb.dbo.pm_depot_master.regn,
	   MiscDb.dbo.dn_dealer_list.depot_code,
	   MiscDb.dbo.pm_depot_master.depot_name,
	   
	  
       (select count(MiscDb.dbo.dn_dealer_list.dealer_code)
               from MiscDb.dbo.dn_dealer_list
               where MiscDb.dbo.dn_dealer_list.dealer_category='SC' and MiscDb.dbo.dn_dealer_list in MiscDb.dbo.pm_depot_master.regn,
	   MiscDb.dbo.dn_dealer_list.depot_code,
	   MiscDb.dbo.pm_depot_master.depot_name) as "SC",
       
       
from MiscDb.dbo.pm_depot_master
     --MiscDb.dbo.dn_dealer_list
     
--where (MiscDb.dbo.pm_depot_master.depot_code = MiscDb.dbo.dn_dealer_list.depot_code)
       

group by 
	   MiscDb.dbo.pm_depot_master.regn,
	   MiscDb.dbo.dn_dealer_list.depot_code,
	   MiscDb.dbo.pm_depot_master.depot_name