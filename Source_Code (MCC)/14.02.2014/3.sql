SELECT distinct(depot_code), dealer_code
,STUFF((SELECT ', ' +A.dealer_child_code FROM dn_dealer_link A
Where A.depot_code=B.depot_code FOR XML PATH('')),1,1,'') As "dealer_child_code"
From dn_dealer_link B
Group By depot_code, dealer_code