USE [MiscDb]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_cursor]    Script Date: 02/19/2014 10:38:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [dbo].[fun_cursor]
(
	@dealer_code nvarchar(6)
)
RETURNS varchar (100)
AS
BEGIN
	declare @var varchar(100) 
	declare @dealer_child_code nvarchar(6)
	declare @counter integer
	
	
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

	fetch next from c1 into @dealer_child_code  
    end
	close c1
	deallocate c1
   	RETURN @var
END
