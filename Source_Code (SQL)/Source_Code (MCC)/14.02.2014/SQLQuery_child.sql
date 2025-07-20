select dbo.conn('72893') as "dealer_child_code";

select dn_dealer_link.depot_code,
       dn_dealer_link.dealer_code, 
       dbo.conn(dn_dealer_link.dealer_code) as "dealer_child_code" from dn_dealer_link
       where dn_dealer_link.dealer_code in(dn_dealer_link.dealer_code);
