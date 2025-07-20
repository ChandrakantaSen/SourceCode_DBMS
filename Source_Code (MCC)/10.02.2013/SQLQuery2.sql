select COUNT(regn) "No_of_W2_regn"
from MiscDb.dbo.pm_depot_master
where regn='W2'
select * from MiscDb.dbo.pm_depot_master
select * from MiscDb.dbo.dn_dealer_list

select MiscDb.dbo.pm_depot_master.regn,
	   MiscDb.dbo.dn_dealer_list.depot_code,
	   MiscDb.dbo.pm_depot_master.depot_name, 	   
	   No_of_Dealers=
		   (case 
			When MiscDb.dbo.dn_dealer_list.dealer_category='GC' then COUNT(MiscDb.dbo.dn_dealer_list.dealer_category) 
			When MiscDb.dbo.dn_dealer_list.dealer_category='SC' then COUNT(MiscDb.dbo.dn_dealer_list.dealer_category)
			When MiscDb.dbo.dn_dealer_list.dealer_category='STA' then COUNT(MiscDb.dbo.dn_dealer_list.dealer_category)
			When MiscDb.dbo.dn_dealer_list.dealer_category='OTH' then COUNT(MiscDb.dbo.dn_dealer_list.dealer_category)
			Else Null
			End)		
from MiscDb.dbo.pm_depot_master,MiscDb.dbo.dn_dealer_list
where MiscDb.dbo.pm_depot_master.depot_code = MiscDb.dbo.dn_dealer_list.depot_code
group by MiscDb.dbo.dn_dealer_list.depot_code,
         MiscDb.dbo.dn_dealer_list.dealer_category,
         MiscDb.dbo.pm_depot_master.depot_name,
         MiscDb.dbo.pm_depot_master.regn