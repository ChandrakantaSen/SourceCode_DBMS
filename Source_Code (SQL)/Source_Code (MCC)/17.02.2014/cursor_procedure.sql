USE [MiscDb]
GO
/****** Object:  StoredProcedure [dbo].[cursor_procedure]    Script Date: 02/17/2014 10:44:15 ******/
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
	Declare @depot_code nvarchar(10)
    Declare @dealer_code nvarchar(10)
    Declare @dealer_child_code nvarchar(10)
    Declare @var nvarchar(10)
    
    Declare c1 cursor for
            select depot_code 
            from dn_dealer_link
    open c1
    fetch next from c1
    into @depot_code
    
while @@FETCH_STATUS = 0
BEGIN
	SET NOCOUNT ON;
	Declare c2 cursor for
		select dealer_code, dealer_child_code from dn_dealer_link
		where depot_code = @depot_code
    open c2
			fetch next from c2 into @dealer_code, @dealer_child_code        
			
            set @var = ISNULL(@var,'') + ISNULL(@dealer_child_code + ', ',LEN(@var))
			print (@depot_code+ ' ' +@dealer_code+ ' ' +@var)
    
			fetch next from c2 into @dealer_code, @dealer_child_code    
    close c2
	deallocate c2
    
    fetch next from c1
    into @depot_code
END
close c1
deallocate c1