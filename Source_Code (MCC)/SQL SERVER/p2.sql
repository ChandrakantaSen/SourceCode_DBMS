use miscdb
select pm_depot_master.regn,pm_depot_master.depot_code,pm_depot_master.depot_name,
 (select 
          count(dn_dealer_list.dealer_code) from dn_dealer_list
                                where dn_dealer_list.dealer_category='GC' 
                                      and 
                        dn_dealer_list.depot_code in(pm_depot_master.regn,pm_depot_master.depot_code,pm_depot_master.depot_name)) "GC",
                        (select 
          count(dn_dealer_list.dealer_code) from dn_dealer_list
                                where dn_dealer_list.dealer_category='STA' 
                                      and 
                        dn_dealer_list.depot_code in(pm_depot_master.regn,pm_depot_master.depot_code,pm_depot_master.depot_name)) "STA",
                        (select 
          count(dn_dealer_list.dealer_code) from dn_dealer_list
                                where dn_dealer_list.dealer_category='SC' 
                                      and 
                        dn_dealer_list.depot_code in(pm_depot_master.regn,pm_depot_master.depot_code,pm_depot_master.depot_name)) "SC",
                        (select 
          count(dn_dealer_list.dealer_code) from dn_dealer_list
                                where dn_dealer_list.dealer_category='OTH' 
                                      and 
                        dn_dealer_list.depot_code in(pm_depot_master.regn,pm_depot_master.depot_code,pm_depot_master.depot_name)) "OTH"
          from pm_depot_master
