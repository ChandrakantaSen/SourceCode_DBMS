USE [bd2]
GO
/****** Object:  StoredProcedure [dbo].[getstudents]    Script Date: 02/07/2014 12:55:09 ******/
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
	@Student_Id varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Fname+' '+Lname from student where Student_Id=@Student_Id
END
