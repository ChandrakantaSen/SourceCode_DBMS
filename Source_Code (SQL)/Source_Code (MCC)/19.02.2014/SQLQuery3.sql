USE [MiscDb]
GO
/****** Object:  StoredProcedure [dbo].[proc3]    Script Date: 02/19/2014 13:43:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[proc3]
	
AS
	declare @dealer_code nvarchar(6) 
	declare p2 cursor for
	    select distinct(dealer_code) from dn_dealer_link   
	    
	open p2
	fetch next from p2 into @dealer_code
	
	While @@FETCH_STATUS = 0
	begin
	SET NOCOUNT ON;

    exec proc2
    @dealer_code=@dealer_code
	
	END
	
	close p2
	deallocate p2
