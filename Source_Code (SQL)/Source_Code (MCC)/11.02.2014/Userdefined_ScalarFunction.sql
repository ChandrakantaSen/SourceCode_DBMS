-- create user defined scalar value function

create function fun_country
 (
	@city varchar (15),
	@return varchar(30)
 )
 Returns varchar(30)
as
 begin
	select @return = case @city
	 when 'New Delhi' then 'India'
	 when 'Bangalore' then 'India'
	 when 'Dhaka' then 'Bangaladesh'
	 when 'New York' then 'U.S.A'
	 else 'others'
 end
 return @return	 
 end	