SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE proc2 
AS
BEGIN
	declare @var varchar(100) = ''
	declare @dealer_child_code nvarchar(6)
	declare @dealer_code nvarchar(6)
	set nocount on;	
    declare c1 cursor for
			select dealer_child_code from dn_dealer_link     
			where dealer_code = @dealer_code
			and dealer_code not in (dealer_child_code)
			
    open c1
    fetch next from c1 into @dealer_child_code   
	set @var = ''
	While @@FETCH_STATUS = 0
	begin

    if(@var IS NULL)
		set @var = @dealer_child_code +', '
	else
		set @var = @var +' '+ @dealer_child_code + ',  '
    insert into temp_table values(@dealer_code, @dealer_child_code)
	fetch next from c1 into @dealer_child_code  
    end
	close c1
	deallocate c1
   	RETURN @var
END

GO

