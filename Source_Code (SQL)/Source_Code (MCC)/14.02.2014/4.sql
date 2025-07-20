select depot_code,dealer_code,dealer_child_code
from dn_dealer_link
where dealer_code = 70554
      
select dbo.('70554') 