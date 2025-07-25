USE [MiscDb]
GO
/****** Object:  StoredProcedure [dbo].[proc2]    Script Date: 02/19/2014 14:33:39 ******/
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
		
	--@dealer_code nvarchar(6)
AS
	declare @var varchar(6)
	declare @dealer_child_code nvarchar(6)
	declare @dealer_code nvarchar(6)
	
    delete from MiscDb.dbo.a;
    
    declare c1 cursor for
			select distinct(dealer_code),dealer_child_code from dn_dealer_link
			where 
				dealer_code in (dealer_code) and
				dealer_code not in (dealer_child_code)
					
    open c1
    fetch next from c1 into @dealer_code, @dealer_child_code   
	
	While @@FETCH_STATUS = 0
	begin
	set nocount on;
	set @var = ''
	
   /* if(@var IS NULL)
		set @var = @dealer_child_code +', '
	else
		set @var = @var +' '+ @dealer_child_code*/
		select @var = COALESCE(@dealer_child_code + ', ', '') + @var FROM dn_dealer_link
    insert into MiscDb.dbo.a values(@dealer_code ,@var)
    
	fetch next from c1 into @dealer_code, @dealer_child_code  
    end
close c1
deallocate c1