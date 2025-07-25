USE [MiscDb]
GO
/****** Object:  StoredProcedure [dbo].[proc2]    Script Date: 02/18/2014 16:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[proc2] 
AS
	declare @var varchar(100) = ''
	declare @dealer_child_code nvarchar(6)
	declare @dealer_code nvarchar(6)

    declare c1 cursor for
			select dealer_code, dealer_child_code from dn_dealer_link     
			where dealer_code = @dealer_code
			and dealer_child_code = @dealer_child_code
			and dealer_code not in (dealer_child_code)
			
    open c1
    fetch next from c1 into @dealer_code, @dealer_child_code   
	
	While @@FETCH_STATUS = 0
	begin
	set nocount on;
	
    if(@var IS NULL)
		set @var = @dealer_child_code +', '
	else
		set @var = @var +' '+ @dealer_child_code + ', '
    
    insert into MiscDb.dbo.a values(@dealer_code,@var)
	
	fetch next from c1 into @dealer_code, @dealer_child_code  
    end
	
close c1
deallocate c1