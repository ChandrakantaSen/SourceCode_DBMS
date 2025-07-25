USE [MiscDb]
GO
/****** Object:  StoredProcedure [dbo].[cursor_procedure]    Script Date: 02/17/2014 14:24:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[cursor_procedure] 
	-- Add the parameters for the stored procedure here
AS
    Declare @dealer_child_code nvarchar(10)
    Declare @var VarChar(MAX) = ''	
    
    Declare c1 cursor for
	select dealer_child_code from dn_dealer_link     
	where dealer_code = '73767'
	SET NOCOUNT ON;
	
	open c1
	Fetch next from c1 into @dealer_child_code   
	While @@FETCH_STATUS = 0
	begin
		if(@var = '')
			set @var = @dealer_child_code
		else
			set @var = ' ' + @dealer_child_code

		select depot_code, dealer_code, @var
		from dn_dealer_link
		where dealer_code = '73767'
		fetch next from c1 into @dealer_child_code 
    end
close c1
deallocate c1
 