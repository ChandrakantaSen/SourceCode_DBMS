select * from MiscDb.dbo.dn_dealer_list;
select * from MiscDb.dbo.pm_depot_master;

select MiscDb.dbo.pm_depot_master.depot_code
from   MiscDb.dbo.pm_depot_master   
union
select MiscDb.dbo.dn_dealer_list.depot_code
from   MiscDb.dbo.dn_dealer_list;

select MiscDb.dbo.pm_depot_master.regn,
	   MiscDb.dbo.dn_dealer_list.depot_code,
	   MiscDb.dbo.pm_depot_master.depot_name,
	   --MiscDb.dbo.dn_dealer_list.dealer_code,
	   --MiscDb.dbo.dn_dealer_list.active,
	   
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
		    End) as 'OTH',
		   
		   (case
		    when MiscDb.dbo.dn_dealer_list.dealer_code=44835 then 1
		    else 0
		    end) as 44835 
		    
from MiscDb.dbo.pm_depot_master,MiscDb.dbo.dn_dealer_list
where MiscDb.dbo.pm_depot_master.depot_code = MiscDb.dbo.dn_dealer_list.depot_code
      and MiscDb.dbo.pm_depot_master.depot_code = 020
      -- and MiscDb.dbo.pm_depot_master.regn = 'C1'
group by MiscDb.dbo.dn_dealer_list.depot_code,
         MiscDb.dbo.pm_depot_master.depot_name,
         MiscDb.dbo.pm_depot_master.regn
        -- MiscDb.dbo.dn_dealer_list.dealer_code,
        -- MiscDb.dbo.dn_dealer_list.active
order by 
		 MiscDb.dbo.pm_depot_master.regn
       
       