SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ****************************************************************************************
CREATE PROCEDURE deleteStudentRecord 
	-- Add the parameters for the stored procedure here
	@fname varchar(10)
   ,@lname varchar(10)
   ,@email varchar(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    -- Insert statements for procedure here
	delete from tbl_Students
	where @lname=Null
END
GO
