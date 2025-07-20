select * from MiscDb.dbo.dn_dealer_list;
select * from MiscDb.dbo.pm_depot_master;

select MiscDb.dbo.dn_dealer_list.depot_code,
       count(MiscDb.dbo.dn_dealer_list.dealer_category) as "GC"
       from MiscDb.dbo.dn_dealer_list
       where MiscDb.dbo.dn_dealer_list.dealer_category='GC'
group by
		MiscDb.dbo.dn_dealer_list.depot_code;        
     
     
     
     