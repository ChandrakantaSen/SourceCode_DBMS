USE [MiscDb]
GO
/****** Object:  StoredProcedure [dbo].[proc1]    Script Date: 02/14/2014 19:45:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[proc1] 
AS
	declare @dealer_code varchar(100)
	declare @dealer_child_code varchar(100)
	declare cpro1 cursor for 
	        select dealer_code from dn_dealer_link
	declare cpro2 cursor for
	        select dealer_child_code from dn_dealer_link 
	        where dealer_code = @dealer_code
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    open cpro1
    while @@FETCH_STATUS = 0
     begin
		fetch next from cpro1 into @dealer_code
		open cpro2
		while @@FETCH_STATUS = 0
		begin
			fetch next from cpro2 into @dealer_child_code
			print @dealer_code+' '+@dealer_child_code
		close cpro2
		deallocate cpro2
		end 
		--print ch(10)
		close cpro1
     end
    -- Insert statements for procedure here
    
  deallocate cpro1
END
