select MiscDb.dbo.pm_depot_master.regn,
       MiscDb.dbo.pm_depot_master.depot_code,
       MiscDb.dbo.pm_depot_master.depot_name,
 (select 
          count(MiscDb.dbo.dn_dealer_list.dealer_code) from MiscDb.dbo.dn_dealer_list
                  where MiscDb.dbo.dn_dealer_list.dealer_category='GC' and 
                        MiscDb.dbo.dn_dealer_list.depot_code in
                       (MiscDb.dbo.pm_depot_master.regn,
                        MiscDb.dbo.pm_depot_master.depot_code,
                        MiscDb.dbo.pm_depot_master.depot_name))as "GC",
 (select 
          count(MiscDb.dbo.dn_dealer_list.dealer_code) from MiscDb.dbo.dn_dealer_list
                  where MiscDb.dbo.dn_dealer_list.dealer_category='STA' and 
                        MiscDb.dbo.dn_dealer_list.depot_code in
                       (MiscDb.dbo.pm_depot_master.regn,
                        MiscDb.dbo.pm_depot_master.depot_code,
                        MiscDb.dbo.pm_depot_master.depot_name))as "STA",
 (select 
          count(MiscDb.dbo.dn_dealer_list.dealer_code) from MiscDb.dbo.dn_dealer_list
                 where MiscDb.dbo.dn_dealer_list.dealer_category='SC'  and 
                        MiscDb.dbo.dn_dealer_list.depot_code in
                       (MiscDb.dbo.pm_depot_master.regn,
                        MiscDb.dbo.pm_depot_master.depot_code,
                        MiscDb.dbo.pm_depot_master.depot_name))as "SC",
 (select 
          count(MiscDb.dbo.dn_dealer_list.dealer_code) from MiscDb.dbo.dn_dealer_list
                 where MiscDb.dbo.dn_dealer_list.dealer_category='OTH' and 
                        MiscDb.dbo.dn_dealer_list.depot_code in
                       (MiscDb.dbo.pm_depot_master.regn,
                        MiscDb.dbo.pm_depot_master.depot_code,
                        MiscDb.dbo.pm_depot_master.depot_name))as "OTH"
 from MiscDb.dbo.dn_dealer_list,
      MiscDb.dbo.pm_depot_master
 group by 
		MiscDb.dbo.pm_depot_master.regn,
		MiscDb.dbo.pm_depot_master.depot_code,
        MiscDb.dbo.pm_depot_master.depot_name		
