select * from MiscDb.dbo.pm_depot_master;
select * from MiscDb.dbo.dn_dealer_list;

select MiscDb.dbo.pm_depot_master.regn,MiscDb.dbo.dn_dealer_list.depot_code,MiscDb.dbo.dn_dealer_list.dealer_code,MiscDb.dbo.dn_dealer_list.dealer_name,MiscDb.dbo.dn_dealer_list.dealer_category 
from MiscDb.dbo.pm_depot_master,MiscDb.dbo.dn_dealer_list
where MiscDb.dbo.pm_depot_master.depot_code = MiscDb.dbo.dn_dealer_list.depot_code;

select MiscDb.dbo.pm_depot_master.regn,
	   MiscDb.dbo.pm_depot_master.depot_code,
	   MiscDb.dbo.pm_depot_master.depot_name,
       MiscDb.dbo.dn_dealer_list.dealer_category,
       COUNT(MiscDb.dbo.dn_dealer_list.dealer_code) "Count_Dealers"
       
from MiscDb.dbo.pm_depot_master,MiscDb.dbo.dn_dealer_list
where MiscDb.dbo.pm_depot_master.depot_code = MiscDb.dbo.dn_dealer_list.depot_code
group by 
		MiscDb.dbo.pm_depot_master.regn,
	   MiscDb.dbo.pm_depot_master.depot_code,
	   MiscDb.dbo.pm_depot_master.depot_name,
       MiscDb.dbo.dn_dealer_list.dealer_category,
       MiscDb.dbo.dn_dealer_list.dealer_code;