USE [toton]
GO
/****** Object:  StoredProcedure [dbo].[dealer_list_p1]    Script Date: 02/16/2014 22:03:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[dealer_list_p1] 
	-- Add the parameters for the stored procedure here
AS
	Declare @depot_code nvarchar(10)
    Declare @dealer_code nvarchar(10)
    Declare @dealer_child_code nvarchar(10)
    Declare @var nvarchar(10)
    
    Declare c1 cursor for
            select depot_code 
            from dealer_list
    open c1
    fetch next from c1
    into @depot_code
    
while @@FETCH_STATUS = 0
BEGIN
	SET NOCOUNT ON;
	Declare c2 cursor for
		select dealer_code, dealer_child_code from dealer_list
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