USE [MiscDb]
GO
/****** Object:  StoredProcedure [dbo].[prRow]    Script Date: 02/15/2014 11:47:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[prRow]
	-- Add the parameters for the stored procedure here
AS
    Declare @depot_code nvarchar(3)
    Declare @dealer_code nvarchar(6)
    Declare @dealer_child_code nvarchar(6)

    Declare c1 cursor for
            select dealer_code 
            from dn_dealer_link
            
    open c1
    fetch next from c1
    into @dealer_code
      
    while @@FETCH_STATUS = 0
	BEGIN
	SET NOCOUNT ON;
			  Declare c2 cursor for
			  select dealer_child_code from dn_dealer_link
			  where dealer_code = @dealer_code
				open c2
				fetch next from c2
				into  @dealer_child_code
				while @@FETCH_STATUS = 0
				Begin 	
					print @dealer_code + ' ' + @var
					fetch next from c2
					into  @dealer_child_code
				End
			   close c2
			   deallocate c2
    fetch next from c1
    into @dealer_code 
END
close c1
deallocate c1
