USE [bd2]
GO
/****** Object:  StoredProcedure [dbo].[getstudents]    Script Date: 02/07/2014 13:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[getstudents]
	-- Add the parameters for the stored procedure here
	@studentId varchar(50)			--input  parameter declared
	@studentname varchar(50) OUT	--output parameter declared
	@studentemail varchar(50) OUT   --output parameter declared
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @studentname= Fname+' '+Lname,
		   @studentemail=Email from student where Student_Id=@studentId
END
