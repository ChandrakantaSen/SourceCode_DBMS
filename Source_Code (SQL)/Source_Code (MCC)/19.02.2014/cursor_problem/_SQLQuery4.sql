select distinct(dealer_code),dbo.fun_cursor(dealer_code) as "dealer_child_code"
from dn_dealer_link 
where dealer_code not in (dealer_child_code)

