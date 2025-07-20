SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION fun_cursor
(
	@dealer_code varchar(10)
)
RETURNS varchar (100)
AS
BEGIN
	-- Declare the return variable here
	declare @var varchar (100)
	declare @dealer_child_code varchar(100)
    declare c1 cursor for
		select dealer_child_code from dn_dealer_link     
		where dealer_code = '73767'
    open c1
    fetch next from c1 into @dealer_child_code   
	While @@FETCH_STATUS = 0
	begin
		if(@var = '')
			set @var = @dealer_child_code
		else
			set @var = ' ' + @dealer_child_code
	     fetch next from c1 into @dealer_child_code  
    end
	
	close c1
	deallocate c1
	RETURN @var
END
GO

