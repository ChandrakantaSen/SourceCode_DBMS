USE [MiscDb]
GO
/****** Object:  StoredProcedure [dbo].[conn_cursor]    Script Date: 02/18/2014 15:06:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[conn_cursor]
	
	@dealer_code nvarchar(6),
	@statement_type nvarchar(20) = ''
AS
BEGIN
	SET NOCOUNT ON;
	declare @var varchar(100) = ''
	declare @dealer_child_code nvarchar(6)
	
	begin
    declare c1 cursor for
			select distinct(dealer_code), dealer_child_code from dn_dealer_link     
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
		set @var = @var +' '+ @dealer_child_code + ', '	
		
	fetch next from c1 into @dealer_child_code 
	
    end
    close c1
    deallocate c1
   end
END
GO

insert into tmp_table(dealer_code,dealer_child_code) values(@dealer_code, @dealer_child_code)