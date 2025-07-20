SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE getnameemail 
	-- Add the parameters for the stored procedure here
	@studentid varchar(50)
	--@Studentname varchar(50) OUT
	@studentemail varchar(50) OUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
--	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select --@studentname = Fname+' '+Lname,
		   @studentemail = Email from student where Student_Id=@studentid
END
GO
