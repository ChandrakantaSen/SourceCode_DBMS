USE [bd2]
GO
/****** Object:  StoredProcedure [dbo].[getname]    Script Date: 02/14/2014 18:46:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[getname] 
	-- Add the parameters for the stored procedure here
	-- @id int
AS
	c1 cursor
            set c1 = CURSOR FOR(select  from )
     Open @c1
     fetch next from @c1 into @var1
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	select 
--	where Studentid = @id
	
END
