select MiscDb.dbo.pm_depot_master.regn,
	   MiscDb.dbo.dn_dealer_list.depot_code,
	   MiscDb.dbo.pm_depot_master.depot_name,
	   
		 sum(case
		     When MiscDb.dbo.dn_dealer_list.dealer_category='GC' Then 1
		     Else 0
		     End)as 'GC',
	
		sum(case
		    When MiscDb.dbo.dn_dealer_list.dealer_category='SC' Then 1
		    Else 0
		    End) as 'SC',
	
		sum(case
		    When MiscDb.dbo.dn_dealer_list.dealer_category='STA' Then 1
		    Else 0
		    End) as 'STA',
		 
		sum(case
		    When MiscDb.dbo.dn_dealer_list.dealer_category='OTH' Then 1
		    Else 0
		    End) as 'OTH'
		    
from MiscDb.dbo.pm_depot_master,MiscDb.dbo.dn_dealer_list
where MiscDb.dbo.pm_depot_master.depot_code = MiscDb.dbo.dn_dealer_list.depot_code
group by MiscDb.dbo.dn_dealer_list.depot_code,
         MiscDb.dbo.pm_depot_master.depot_name,
         MiscDb.dbo.pm_depot_master.regn
order by 
		 MiscDb.dbo.pm_depot_master.regn