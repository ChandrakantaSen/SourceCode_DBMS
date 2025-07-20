select * from MiscDb.dbo.pm_depot_master;
select * from MiscDb.dbo.dn_dealer_list;

select MiscDb.dbo.pm_depot_master.regn,
       MiscDb.dbo.pm_depot_master.depot_code,
       MiscDb.dbo.pm_depot_master.depot_name,
       MiscDb.dbo.dn_dealer_list.dealer_name
       
from MiscDb.dbo.dn_dealer_list,
     MiscDb.dbo.pm_depot_master
where
     MiscDb.dbo.pm_depot_master.regn between 'w1' and 'w2'
     
 order by 
		 MiscDb.dbo.pm_depot_master.regn;
		 
select MiscDb.dbo.dn_dealer_list.depot_code,
       MiscDb.dbo.dn_dealer_list.dealer_name 
	   from MiscDb.dbo.dn_dealer_list
right join
       MiscDb.dbo.pm_depot_master
 on MiscDb.dbo.pm_depot_master.depot_code = MiscDb.dbo.dn_dealer_list.depot_code 
 
select MiscDb.dbo.pm_depot_master.regn,
MiscDb.dbo.pm_depot_master.depot_code,
MiscDb.dbo.pm_depot_master.depot_name,
isnull((dbo.fun1('GC',MiscDb.dbo.pm_depot_master.depot_code)),0) "GC",
isnull((fun1('SC',MiscDb.dbo.pm_depot_master.depot_code)),0) "SC",
isnull((fun1('STA',MiscDb.dbo.pm_depot_master.depot_code)),0) "STA",
isnull((fun1('OTH',MiscDb.dbo.pm_depot_master.depot_code)),0) "OTH" 
from pm_depot_master
