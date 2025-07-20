SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE rowcount1 
	-- Add the parameters for the stored procedure here
	--empno nvarchar(30),
	@dept nvarchar(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT count(dept.eno) 
	FROM dbo.dept
	WHERE dept.dept=@dept
END
GO
