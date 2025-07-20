SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE prRow
	-- Add the parameters for the stored procedure here
AS
    Declare @depot_code nvarchar(10)
    Declare @dealer_code nvarchar(10)
    Declare @dealer_child_code nvarchar(10)
    Declare c1 cursor for
            select depot_code, dealer_code, dealer_child_code from dn_dealer_link
    open c1
    fetch next from c1
    into @depot_code, @dealer_code, @dealer_child_code
    print @depot_code+ ',' +@dealer_code+ ',' +@dealer_child_code
    
    while @@FETCH_STATUS = 0
BEGIN
	SET NOCOUNT ON;
    fetch next from c1
    into @depot_code, @dealer_code, @dealer_child_code
    print @depot_code+ ',' +@dealer_code+ ',' +@dealer_child_code
END
close c1
deallocate c1
GO
