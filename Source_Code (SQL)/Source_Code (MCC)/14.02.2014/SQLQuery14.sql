--@out int,
--@out1 int,
	--@str varchar (10),


-- Add the T-SQL statements to compute the return value here
	/*SELECT @out = COUNT(dealer_child_code) from dn_dealer_link
	where dealer_code = @dealer_code  
	set @out1 = 1
	while(@out1 <= @out)
	begin
	set @str = @str +STUFF((SELECT ', ' +A.dealer_child_code 
	FROM dn_dealer_link A, dn_dealer_link B
Where A.depot_code=B.depot_code FOR XML PATH('')),1,1,'') */