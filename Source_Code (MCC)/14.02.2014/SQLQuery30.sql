SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE conn
	-- Add the parameters for the stored procedure here
	@dealer_child_code varchar(50) 
AS
    Declare 
            @var1 varchar(50),
            @c1 cursor
            set @c1 = CURSOR FOR(select dealer_code from dn_dealer_link)
     Open @c1
     fetch next from @c1 into @var1
while @@FETCH_STATUS = 0
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
    print @var1
	
	
END
GO
