USE [bd2]
GO
/****** Object:  StoredProcedure [dbo].[getname]    Script Date: 02/12/2014 13:56:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[getname] 
	-- Add the parameters for the stored procedure here
	@id int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	select Firstname,Lastname
	from tbl_Students
	where Studentid = @id
	
END
