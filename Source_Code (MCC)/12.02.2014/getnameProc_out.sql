USE [bd2]
GO
/****** Object:  StoredProcedure [dbo].[getnameout]    Script Date: 02/12/2014 14:47:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =================================================================
ALTER PROCEDURE [dbo].[getnameout] 
	-- Add the parameters for the stored procedure here
	@id int
   ,@name varchar (10) out -- output variable is declared									 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select @name = Firstname +' '+ Lastname 
	from tbl_Students
	where Studentid = @id
	               
END
