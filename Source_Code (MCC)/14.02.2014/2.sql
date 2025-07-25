/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [depot_code]
      ,[dealer_code]
      ,[dealer_child_code]
  FROM [MiscDb].[dbo].[dn_dealer_link]
  
SELECT depot_code, dealer_code
,STUFF((SELECT ', ' +A.dealer_child_code FROM dn_dealer_link A
Where A.depot_code=B.depot_code FOR XML PATH('')),1,1,'') As "dealer_child_code"
From dn_dealer_link B
Group By depot_code, dealer_code

SELECT 
      dealer_code
      ,count(dealer_child_code)
  FROM [MiscDb].[dbo].[dn_dealer_link]
group by dealer_code
having (count(dealer_child_code))>1

select depot_code,dealer_code,dealer_child_code
from dn_dealer_link
where dealer_code = 70554

SELECT t.depot_code, t.dealer_code,STUFF(
	(SELECT ','+s.dealer_child_code
		FROM dn_dealer_link s, dn_dealer_link t
		WHERE s.depot_code = t.depot_code),1,1,'') AS CSV
FROM dn_dealer_link AS t
where t.dealer_code = 70554
GROUP BY t.depot_code,t.dealer_code